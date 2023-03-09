import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:xpensetrack/widgets.dart';

import 'fireBase.dart';
import 'Login.dart';

class profile extends StatelessWidget {
  const profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
children: [
styledText(FirebaseApi.getUserID()!, 20, Colors.black),
AnimatedButton(onPressed: (){
FirebaseApi.logOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Login()));

},color: const Color(0xFFe2e6fe), child:  styledText("Logout ",18,Colors.black)
)
],
    ),);
  }
}