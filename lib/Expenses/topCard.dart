

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'fireBase.dart';

class TopNeuCard extends StatelessWidget {
  // final String balance;
  // final String income;
  // final String expense;

  const TopNeuCard({super.key, 
    // required this.balance,
    // required this.expense,
    // required this.income,
  });

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> ref = FirebaseFirestore.instance
        .collection('USERDATA')
        .doc(FirebaseApi.getuid())
        .collection("CashFlow")
        .snapshots();
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return StreamBuilder<QuerySnapshot>(
        stream: ref,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
         double expense=0, incomeAmount=0;
for (var doc in snapshot.data!.docs) {

if(doc["expenseOrIncome"]=="income"){
incomeAmount = incomeAmount + double.parse(doc["amount"]);
}
else{

expense =expense+double.parse(doc["amount"] );}

}
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            height: h/5,
             width: w * .9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 183, 193, 255),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade500,
                      offset: const Offset(4.0, 4.0),
                      blurRadius: 15.0,
                      spreadRadius: 1.0),
                  const BoxShadow(
                      color: Colors.white,
                      offset: Offset(-4.0, -4.0),
                      blurRadius: 15.0,
                      spreadRadius: 1.0),
                ]),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('B A L A N C E',
                      style: TextStyle(color: Colors.grey[500], fontSize: 16)),
                  Text(
                    '₹${incomeAmount-expense}',
                    style: TextStyle(color: Colors.grey[800], fontSize: 40),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[200],
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_upward,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Income',
                                    style: TextStyle(color: Colors.grey[500])),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text('₹$incomeAmount',
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.bold)),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[200],
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_downward,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Expense',
                                    style: TextStyle(color: Colors.grey[500])),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text('₹$expense',
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.bold)),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
