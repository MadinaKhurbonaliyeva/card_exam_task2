import 'package:flutter/material.dart';

class CardNumberWidget extends StatelessWidget {
  final String cardNumber;

  const CardNumberWidget({Key? key, required this.cardNumber}) : super(key: key);

  String getLogoImagePath() {
    if (cardNumber.startsWith('9860')) {
      return 'asset/images/humocard.jpg';
    } else if (cardNumber.startsWith('4500')) {
      return 'asset/images/visa_card_png.png';
    } else {
      return 'asset/images/visa_card_png.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    String logoImagePath = getLogoImagePath();

    return Column(
      children: [
        Image.asset(
          logoImagePath,
          width: 25,
          height: 20,
        ),
      ],
    );
  }
}