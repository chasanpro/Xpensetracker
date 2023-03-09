// ignore: file_names
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseApi {
  static String? getuid() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final uniqID = auth.currentUser?.uid.toString();
    return uniqID;
  }

  static Future<String?> logOut() async {
    await FirebaseAuth.instance.signOut();
    return null;
  }

  static String? getUserID() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    return user!.email.toString();
  }

//Creatiion of Empty documents for a User only for Testting
  static initialTemplateCreation(String uid) async {
    CollectionReference ref = FirebaseFirestore.instance.collection("USERDATA");

    print("🦄🦄 $uid");
    ref.doc("CashFlow").set({"test": "test"});

    ref.doc("Remainders").set({});
  }

//Add a transaction
  static updateTransaction(
      String uid, Map<String, dynamic> newTransaction) async {
    CollectionReference ref = FirebaseFirestore.instance.collection("USERDATA");
    ref.doc(getuid()).collection("CashFlow").add(newTransaction);
  }

  //remove a remainder from remainder tab
  static removeRemainder(Map<String, dynamic> newRemainder) async {
await  FirebaseFirestore.instance.collection("USERDATA")
        .doc(getuid())
        .collection("Remainders")
        .doc(newRemainder["key"]).delete();


  }

  //pay the Remainder Payment and remove it from remainders tab
  static payRemainder(Map<String, dynamic> newRemainder) async {

    await updateTransaction(getuid()!, {
      "name": newRemainder["name"],
      "amount": newRemainder["amount"],
      "expenseOrIncome": "expense"
    });

  }

  //Create a remainder
  static createRemainder(Map<String, dynamic> newRemainder) async {
    CollectionReference ref = FirebaseFirestore.instance.collection("USERDATA");

    await ref
        .doc(getuid())
        .collection("Remainders")
        .doc(newRemainder["key"])
        .set(newRemainder);
  }
}
