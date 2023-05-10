import 'package:cloud_firestore/cloud_firestore.dart';

class Coin {
  String id = "";
  String name = "";
  double price = 0.0;
  double amount = 0.0;

  Coin({
    required this.id,
    required this.name,
    required this.price,
    required this.amount,
  });

  factory Coin.fromFirestore(Map<String, dynamic> jsonData) {
    return Coin(
      id: jsonData['id'],
      name: jsonData['name'],
      price: jsonData['price'],
      amount: jsonData['amount'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "name": name,
      "price": price,
      "amount": amount,
    };
  }
}
