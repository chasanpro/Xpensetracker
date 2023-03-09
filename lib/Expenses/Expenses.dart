import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:xpensetrack/Expenses/cashFlow.dart';
import 'package:xpensetrack/Firebase/fireBase.dart';
import 'package:xpensetrack/Expenses/topCard.dart';
import 'package:xpensetrack/Widgets/widgets.dart';

class expenses extends StatefulWidget {
  const expenses({super.key});

  @override
  State<expenses> createState() => _expensesState();
}

class _expensesState extends State<expenses> {
  @override
  Widget build(BuildContext context) {
    // Getting height(h) and Width w form MediaQuery
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final iskeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Material(
      child: Scaffold(
        extendBody: true,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 20,
              ),
              const TopNeuCard(),
              Stack(children: [
                SizedBox(
                    height: h * .68, width: w * .9, child: const cashflow()),
                Positioned(
                  top: 500,
                  left: w / 2.6,
                  child: AnimatedButton(
                    height: 50,
                    onPressed: () {
                      _newTransaction(context);
                    },
                    width: 60,
                    color: const Color.fromARGB(255, 183, 193, 255),
                    child:
                        styledText("+", 30, const Color.fromARGB(255, 0, 0, 0)),
                  ),
                )
              ]),
              const SizedBox(
                height: 70,
              )
            ],
          ),
        ),
      ),
    );
  }
}

final _textcontrollerAMOUNT = TextEditingController();
final _textcontrollerITEM = TextEditingController();
final _formKey = GlobalKey<FormState>();
bool _isIncome = false;

void _newTransaction(context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: const Text('N E W  T R A N S A C T I O N'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Expense'),
                        Switch(
                          activeColor: const Color.fromARGB(255, 183, 193, 255),
                          value: _isIncome,
                          onChanged: (newValue) {
                            setState(() {
                              _isIncome = newValue;
                            });
                          },
                        ),
                        const Text('Income'),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Amount?',
                              ),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Enter an amount';
                                }
                                return null;
                              },
                              controller: _textcontrollerAMOUNT,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'For what?',
                            ),
                            controller: _textcontrollerITEM,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                MaterialButton(
                  color: const Color.fromARGB(255, 183, 193, 255),
                  child: const Text('Cancel',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                MaterialButton(
                  color: const Color.fromARGB(255, 183, 193, 255),
                  child: const Text('Enter',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      late String expenseOrIncome;
                      if (!_isIncome) {
                        expenseOrIncome = "expense";
                      } else {
                        expenseOrIncome = "income";
                      }
                      Map<String, dynamic> transactionData = {
                        'name': _textcontrollerITEM.text,
                        'amount': _textcontrollerAMOUNT.text,
                        'expenseOrIncome': expenseOrIncome
                      };
                      print(transactionData);
                      String? uid = FirebaseApi.getuid();
                      FirebaseApi.updateTransaction(uid!, transactionData);
                      _textcontrollerAMOUNT.clear();
                      _textcontrollerITEM.clear();
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            );
          },
        );
      });
}
