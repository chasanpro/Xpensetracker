
import 'package:animated_button/animated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xpensetrack/fireBase.dart';
import 'package:xpensetrack/widgets.dart';

class remainderScreen extends StatefulWidget {
  const remainderScreen({super.key});

  @override
  State<remainderScreen> createState() => _remainderScreenState();
}

class _remainderScreenState extends State<remainderScreen> {
  @override
  Widget build(BuildContext context) {
    
  double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    double responsiveHeight = h/1.2;
    late String? name ,amount,date;
 

    return   Scaffold(
    extendBody: true,
body: Center(
  child:   Column(mainAxisAlignment: MainAxisAlignment.center,
  children:  [
    const SizedBox(height: 30,),
  styledText("Remainders", 40, const Color.fromARGB(255, 3, 31, 54)),
    styledText("TAP ON CARD TO CANCEL THE REAMINDER", 10, const Color.fromARGB(255, 14, 71, 119)),
 
   Stack(
     children: [
              SizedBox(
                  height: h / 1.2,
                  width: w * .9,
                  child: const remaindersList()),
                 Positioned(
                 right: 10,
                 bottom: 60,

                   child: AnimatedButton(
                                 height: 50,
                                 onPressed: () {
                                 showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: styledText(
                                "ADD A REMAINDER", 15, Colors.black),
                            // content: const Text('This is an alert dialogue.'),
                            actions: <Widget>[
                             Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
onChanged: (value){
setState(() {
  name = value;
});

},
            decoration: const InputDecoration(
              hintText: 'NAME OF THE PAYMENT',
              labelText: 'NAME',
            ),
          ),
        ),),
                     Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextField(
                                  onChanged: (value) {
                                  setState(() {
                                    amount = value;
                                  });

                                    },
keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: 'AMOUNT',
                                     
                                      labelText: 'AMOUNT',
                                    ),
                                  ),
                                ),
                              ),
                                 AnimatedButton(
                                // width: 100,
                                // height: 40,
                                color: const Color.fromARGB(255, 183, 193, 255),
                                child: const Text('SELECT DATE'),
                                onPressed: () async{


 DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
    
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        date = picked.toString();
      });
    }

                                },
                              ),
const SizedBox(height: 5,),
                              Center(
                                child: AnimatedButton(
                                  width: 100,
                                  height: 50,
                                  color: const Color.fromARGB(255, 183, 193, 255),
                                  child: const Text('SUBMIT'),
                                  onPressed: () {
                                  Map<String, dynamic> remainderdata = {
                                      'name': name,
                                      'amount': amount,
                                      'date': date,
                                      'key': DateTime.now().toString().trim()
                                    };

print(remainderdata);
FirebaseApi.createRemainder(remainderdata);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                       
                            ],
                           
                          );
                        });
                  },
                                 width: 60,
                                 color: const Color.fromARGB(255, 183, 193, 255),
                                 child: styledText("+", 30, const Color.fromARGB(255, 0, 0, 0)),
                               ),
                 ),
            ]
   ),
  const SizedBox(height: 10,)
    ]
  ,),
),
    );
  }
}

class remaindersList extends StatefulWidget {
  const remaindersList({super.key});

  @override
  State<remaindersList> createState() => _remaindersListState();
}

class _remaindersListState extends State<remaindersList> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> ref =
        FirebaseFirestore.instance.collection('USERDATA').doc(FirebaseApi.getuid()).collection("Remainders").snapshots();

  
    return StreamBuilder<QuerySnapshot>(
      stream: ref,
      builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }

        return ListView(

        children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
           return Padding(
      padding: const EdgeInsets.all(5),
        child: InkWell(
        onTap: (){

               showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: styledText("REMOVE REMAINDER", 15, Colors.black),
                        // content: const Text('This is an alert dialogue.'),
                        actions: <Widget>[
                          AnimatedButton(
                           width: 100,
                              height: 40,
                              color: const Color.fromARGB(255, 183, 193, 255),
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          AnimatedButton(
                              color: const Color.fromARGB(255, 183, 193, 255),
                           width: 100,
                              height: 40,
                            child: const Text('OK'),
                            onPressed: () {
                               Map<String, dynamic> remainderdata = {
                                  'name': data["name"],
                                  'amount': data["amount"],
                                  'expenseOrIncome': "expense",
                                  'key': data["key"]
                                };
                           FirebaseApi.removeRemainder(remainderdata);
    
    
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );});
        },
          child: Container(
           decoration: BoxDecoration(
           color: const Color.fromARGB(218, 218, 255, 154),
           borderRadius: BorderRadius.circular(15),
           border: Border.all(
           color: const Color.fromARGB(218, 180, 243, 63),
           
           )
           ),
          height: 120,
          width: 80,
          child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              styledText(data["name"].toString().toUpperCase(), 18, Colors.black),
                styledText(DateFormat.yMMMd().format(DateTime.parse(data["date"])), 15, const Color.fromARGB(255, 50, 77, 76))
              ],
              ),
              Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              styledText("₹${data["amount"]}", 19, const Color.fromARGB(255, 0, 137, 5)),
              AnimatedButton(
              width: 100,
              height: 40,
              onPressed: (){
               Map<String, dynamic> remainderdata = {
                                  'name': data["name"],
                                  'amount': data["amount"],
                                  'expenseOrIncome': "expense",
                                  'key':data["key"]
                                };
    
              FirebaseApi.payRemainder(remainderdata);
              FirebaseApi.removeRemainder(remainderdata);

              }, child:  styledText("Pay Now ",15,Colors.white))
              ],)
            ],
          ),
          
          ),
        ),
      );  

     
    
          }).toList());
         
      }
    );
  }
  Future<void> _selectDate(BuildContext context) async {
   
  }

}

