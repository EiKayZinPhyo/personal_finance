import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ResetPage extends StatefulWidget {
  const ResetPage({Key? key}) : super(key: key);

  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  final _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();

  Future<void> resetPassword() async {
    try {
      await _auth.sendPasswordResetEmail(email: emailController.text);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Password reset Link send! Check your email'),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.text;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffAE9B9B),
      appBar: AppBar(
          backgroundColor: Color(0xffAE9B9B),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settingpage');
            },
            icon: Icon(Icons.arrow_back),
          )),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Enter your Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (val) {
                  val == emailController.text;
                },
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              height: 80,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    resetPassword();
                  });
                },
                style:
                    ElevatedButton.styleFrom(primary: const Color(0xffD3C3AF)),
                child: const Text(
                  'Reset Password',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
