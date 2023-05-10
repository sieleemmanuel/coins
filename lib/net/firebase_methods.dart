import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../model/coin.dart';

String uid = FirebaseAuth.instance.currentUser!.uid;

Future<bool> signUp(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == "weak-password") {
      print("The password provided is too weak");
    } else if (e.code == 'email-already-in-use') {
      print("The account already exists for that email");
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> login(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
    return false;
  }
}

Future<bool> addCoin(Coin coinObject) async {
  try {
    DocumentReference coinsRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Coins')
        .doc(coinObject.id);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(coinsRef);
      if (!snapshot.exists) {
        ///await coinsRef.set(coinObject.toFirestore());
        transaction.set(coinsRef, coinObject.toFirestore());
      } else {
        var newAmount = snapshot.get('amount') + coinObject.amount;
        transaction.update(coinsRef, {'amount': newAmount});
      }
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> removeCoin(String id) async {
  FirebaseFirestore.instance
      .collection("Users")
      .doc(uid)
      .collection("Coins")
      .doc(id)
      .delete();
  return true;
}
