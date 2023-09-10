

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../screens/widgets/toasts.dart';
import '../models/cards_model.dart';

class UserCardsRepository{
  final FirebaseFirestore firestore;
  UserCardsRepository({required this.firestore});

  Future<void> addCard({required UserCard cardModel}) async {
    try {
      DocumentReference newCard =
      await firestore.collection("Cards").add(cardModel.toJson());
      await firestore
          .collection("Cards")
          .doc(newCard.id)
          .update({"cardId": newCard.id});
      getMyToast(message: 'saved card');
    } on FirebaseException catch (e) {
      getMyToast(message: e.message.toString());
    }
  }

  Stream<List<UserCard>> getAllCards() => firestore
      .collection("Cards")
      .snapshots()
      .map((querySnapshot) => querySnapshot.docs
      .map((e) => UserCard.fromJson(e.data()))
      .toList());


  Future<void> updateCard({required UserCard cardModel}) async {
    try {
      await firestore
          .collection("Cards")
          .doc(cardModel.cardId)
          .update(cardModel.toJson());
      getMyToast(message: "card saved!!!");
    } on FirebaseException catch (e) {
      getMyToast(message: e.message.toString());
    }
  }


  Future<void> deleteCard({required String docId}) async {
    try {
      await firestore.collection("Cards").doc(docId).delete();
      getMyToast(message: "card Saved!");
    } on FirebaseException catch (e) {
      getMyToast(message: e.message.toString());
    }
  }
}