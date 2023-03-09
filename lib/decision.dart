import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:xpensetrack/Home.dart';
import 'package:xpensetrack/signUP.dart';

class decision extends StatelessWidget {
  const decision({super.key});

  @override
  Widget build(BuildContext context) {
if(FirebaseAuth.instance.currentUser != null){
return const homeScreen();}
else{
return const signUP();
}
  }
}