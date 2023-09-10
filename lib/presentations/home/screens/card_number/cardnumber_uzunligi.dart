String hideCardNumber(String cardNumber) {
  if (cardNumber.length < 16) {
    return cardNumber;
  }

  String maskedNumber = cardNumber.substring(0, 4);

  for (int i = 0; i < 8; i++) {
    maskedNumber += '*';
  }

  maskedNumber += cardNumber.substring(14);

  return maskedNumber;
}