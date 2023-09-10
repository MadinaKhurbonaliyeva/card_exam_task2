
class UserCard {
  final String cardId;
  final String name;
  final String cvv;
  final String expiry;
  final String cardNumber;

  UserCard({
    required this.cardNumber,
    required this.name,
    required this.cardId,
    required this.cvv,
    required this.expiry,
  });

  factory UserCard.fromJson(Map<String, dynamic> json) {
    return UserCard(
      name: json['name'],
      expiry: json['expiry'],
      cvv: json['cvv'],
      cardId: json['cardId'],
      cardNumber: json['cardNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cardNumber': cardNumber,
      'cardId': cardId,
      'name': name,
      'expiry': expiry,
      'cvv': cvv,
    };
  }
}