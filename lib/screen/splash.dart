import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    checkLoginOrNot() {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          Navigator.pushReplacementNamed(context, '/registerpage');
        } else {
          Navigator.pushReplacementNamed(context, '/bottompage');
        }
      });
    }

    checkLoginOrNot();

    return const Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
          child: CircularProgressIndicator(
        color: Colors.white,
      )),
    );
  }
}
