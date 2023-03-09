import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xpensetrack/Expenses/transaction.dart';

import '../Firebase/fireBase.dart';

class cashflow extends StatefulWidget {
  const cashflow({super.key});

  @override
  State<cashflow> createState() => _cashflowState();
}

class _cashflowState extends State<cashflow> {
  @override
  Widget build(BuildContext context) {
  final Stream<QuerySnapshot> ref =
        FirebaseFirestore.instance.collection('USERDATA').doc(FirebaseApi.getuid()).collection("CashFlow").snapshots();
    // Getting height(h) and Width w form MediaQuery
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Material(
      child: Scaffold(
     
      body: StreamBuilder<QuerySnapshot>(
        stream: ref,
      builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }
FirebaseFirestore.instance
                  .collection('users')
                  .get()
                  .then((QuerySnapshot querySnapshot) {
                for (var doc in querySnapshot.docs) {
                  print(doc["first_name"]);
                }
              });
                 return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;data.length;
            return MyTransaction(transactionName: data["name"], money: data["amount"], expenseOrIncome: data["expenseOrIncome"]);
          }).toList());

        }
      ),),
    );
  }
}