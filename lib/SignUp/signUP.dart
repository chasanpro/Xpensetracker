import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:animated_button/animated_button.dart';
import 'package:lottie/lottie.dart';
import 'package:xpensetrack/Login.dart';

class signUP extends StatefulWidget {
  const signUP({super.key});

  @override
  State<signUP> createState() => _signUPState();
}

class _signUPState extends State<signUP> {
  bool isHover = false;

  String? mail, passcode;
  @override
  Widget build(BuildContext context) {
    final double x = MediaQuery.of(context).size.width;
    final double y = MediaQuery.of(context).size.height;
    final authie = FirebaseAuth.instance;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: 1.0,
      ),
      child: Scaffold(
backgroundColor:  const Color(0xFFf5f6ff),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: y / 5,
              child: Center(
                child: Lottie.network(
                    'https://assets10.lottiefiles.com/packages/lf20_GDzACf91vu.json'),
                // child: Image.network(
              ),
            ),
            Center(
              child: Stack(
                alignment: Alignment.topRight,
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFFe2e6fe),
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    height: y / 4,
                    width: x * .85,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              mail = value.toString().trim();
                            });
                          },
                          textAlign: TextAlign.center,

                          style: GoogleFonts.poppins(),
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: 'Mail'),
                        ),
                        TextField(
                          style: GoogleFonts.poppins(),
                          onChanged: (value) {
                            setState(() {
                              passcode = value;
                            });
                          },
                          obscureText: true,
                          textAlign: TextAlign.center,

                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: 'Password'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: AnimatedButton(
                    height: 50,
                    width: 150,

                    onPressed: () async {
                      try {
                        final credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: mail!, password: passcode!
                        );
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text(
                      'SIGN UP',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 255, 255, 255),
                            letterSpacing: .5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account ?",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0),
                        letterSpacing: .5),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Login()));
                  },
                  child: Text(
                    "Log In",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.blueAccent,
                          letterSpacing: .5),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
