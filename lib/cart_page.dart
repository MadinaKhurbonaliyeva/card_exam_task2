
import 'package:credit_card_1/server/cart_add.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get_storage/get_storage.dart';

class CardPage extends StatefulWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  State<CardPage> createState() => _CardPageState();
}

final box = GetStorage();

class _CardPageState extends State<CardPage> {
  List<BankCard> bankCards = [];
  final cardNameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final cardDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }
  void _deleteAllCards() {
    setState(() {
      bankCards.clear();
    });

    _saveData();
  }

  @override
  void dispose() {
    cardNameController.dispose();
    cardNumberController.dispose();
    cardDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Cards'),
      ),
      body: ListView.builder(
        itemCount: bankCards.length,
        itemBuilder: (context, index) {

          return ListTile(

            title: CreditCardWidget(
              cardNumber: bankCards[index].number,
              expiryDate: bankCards[index].date,
              cardHolderName: bankCards[index].name,
              cvvCode: '', // You can add a CVV code if needed
              showBackView: false,
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _showAddCardDialog(context);
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              _deleteAllCards();
            },
            child: const Icon(Icons.delete_forever),
          ),
        ],
      ),
    );

  }

  void _loadData() {
    final cardList = box.read<List<Map<String, String>>>(
      'bank_cards',
    );

    if (cardList != null) {
      setState(() {
        bankCards = cardList.map((cardData) {
          return BankCard(
            name: cardData['name'] ?? '',
            number: cardData['number'] ?? '',
            date: cardData['date'] ?? '',
          );
        }).toList();
      });
    }
  }

  void _saveData() {
    final cardList = bankCards.map((card) {
      return {
        'name': card.name,
        'number': card.number,
        'date': card.date,
      };
    }).toList();

    box.write('bank_cards', cardList);
  }

  void _deleteCard(int index) {
    setState(() {
      bankCards.removeAt(index);
    });

    _saveData();
  }

  Future<void> _showAddCardDialog(BuildContext context) async {
    String cardName = '';
    String cardNumber = '';
    String cardDate = '';

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Bank Card'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: cardNameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(labelText: 'Card Name'),
                onChanged: (value) {
                  cardName = value;
                },
              ),
              TextFormField(
                controller: cardNumberController,
                decoration: const InputDecoration(labelText: 'Card Number'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                  CardNumberInputFormatter(),
                ],
                onChanged: (value) {
                  cardNumber = value;
                },
              ),
              TextFormField(
                controller: cardDateController,
                decoration: const InputDecoration(labelText: 'Card Date (MM/yy)'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // Allow only digits
                  LengthLimitingTextInputFormatter(4),
                  CardDateInputFormatter(),
                ],
                onChanged: (value) {
                  cardDate = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                addCart(cardNameController.text, cardNumberController.text, cardDateController.text);
                if (_validateInputs(cardName, cardNumber, cardDate)) {
                  setState(() {
                    bankCards.add(

                      BankCard(
                        name: cardNameController.text,
                        number: cardNumberController.text,
                        date: cardDateController.text,
                      ),
                    );
                  });

                  _saveData();

                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter valid card information'),
                    ),
                  );
                }

                cardDateController.clear();
                cardNameController.clear();
                cardNumberController.clear();

              },
              child: const Text('Add'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  bool _validateInputs(String name, String number, String date) {

    final cleanedCardNumber = number.replaceAll(' ', '');

    // Check that the name is not empty, the card number has 16 digits, and the date has the format "MM/yy"
    if (name.isEmpty || cleanedCardNumber.length != 16 || !_isValidDateFormat(date)) {
      return false;
    }

    return true;
  }

  bool _isValidDateFormat(String date) {
    if (date.length != 5) return false;

    final month = int.tryParse(date.substring(0, 2));
    final year = int.tryParse(date.substring(3, 5));

    final currentYear = DateTime.now().year % 100; // Get the last two digits of the current year

    return month != null && year != null && month >= 1 && month <= 12 && year >= currentYear;
  }
}

class BankCard {
  final String name;
  final String number;
  final String date;

  BankCard({required this.name, required this.number, required this.date});
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.replaceAll(RegExp(r'\s+\b|\b\s'), '');
    final formatted = <String>[];

    for (var i = 0; i < text.length; i += 4) {
      formatted.add(text.substring(i, i + 4));
    }

    return newValue.copyWith(
      text: formatted.join(' '),
      selection: TextSelection.collapsed(offset: formatted.join(' ').length),
    );
  }
}

class CardDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.replaceAll(RegExp(r'\s+\b|\b\s'), '');
    final formatted = <String>[];

    for (var i = 0; i < text.length; i += 2) {
      formatted.add(text.substring(i, i + 2));
    }

    return newValue.copyWith(
      text: formatted.join('/'),
      selection: TextSelection.collapsed(offset: formatted.join('/').length),
    );
  }
}

void main() async {
  await GetStorage.init();
  runApp(const MaterialApp(
    home: CardPage(),
  ));
}
