import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/card_bloc.dart';
import '../../data/models/cards_model.dart';


class EditCardPage extends StatefulWidget {
  const EditCardPage({super.key, required this.card});

  final UserCard card;

  @override
  State<EditCardPage> createState() => _EditCardPageState();
}

class _EditCardPageState extends State<EditCardPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.card.name;
    expiryController.text = widget.card.expiry;
    cvvController.text = widget.card.cvv;
    cardNumberController.text = widget.card.cardNumber;

  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CardBloc, CardState>(
      listener: (context, state) {
        if (state.status == CardStateStatus.cardUpdated) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: const Text('Edit Card', style: TextStyle(color: Colors.white),),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5,),
                  child: TextFormField(
                    controller: cardNumberController,
                    decoration: InputDecoration(
                      labelText: "Enter number)",
                      labelStyle: const TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      fillColor: Colors.green,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: Colors.green,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20,),
                  child: TextFormField(
                    controller: expiryController,
                    decoration: InputDecoration(
                      labelText: "Enter expire date",
                      labelStyle: const TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      fillColor: Colors.green,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: Colors.green,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20,),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Enter your name",
                      labelStyle: const TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      fillColor: Colors.green,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: Colors.green,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20,),
                  child: TextFormField(
                    controller: cvvController,
                    decoration: InputDecoration(
                      labelText: "Enter CVV",
                      labelStyle: const TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      fillColor: Colors.green,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: Colors.green,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(fixedSize: Size(350, 55), backgroundColor: Colors.green),
                  onPressed: () {
                    context.read<CardBloc>().add(
                      UpdateCardEvent(
                        cardModel: UserCard(
                          cardNumber: cardNumberController.text,
                          name: nameController.text,
                          expiry: expiryController.text,
                          cvv: cvvController.text,
                          cardId: widget.card.cardId,
                        ),
                      ),
                    );
                  },
                  child: const Text('Update Card', style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}