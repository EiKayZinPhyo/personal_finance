import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isVisible = false;
  bool checking = false;
  bool showing = false;

  String? get emailErrorText {
    if (emailController.value.text.isEmpty) {
      return " Email can't be blank";
    }
    return null;
  }

  String? get passwordErrorText {
    if (passwordController.value.text.isEmpty) {
      return "Password can't be blank";
    }
    return null;
  }

  void saveData() async {
    // if (emailErrorText == null && passwordErrorText == null) {
    try {
      setState(() {
        showing = true;
      });
      final auth = FirebaseAuth.instance;
      final newemail = await auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      print('>>>>>>>>>>');
      print(newemail);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/loginpage');
      setState(() {
        showing = false;
      });
    } catch (e) {
      setState(() {
        showing = false;
      });
      const snackbar = SnackBar(
        backgroundColor: Colors.red,
        content:
            Text('The email or password is Wrong and You need to register '),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var test = '';
    return Scaffold(
      backgroundColor: Color(0xffAE9B9B),
      appBar: AppBar(
        backgroundColor: const Color(0xffAE9B9B),
        title: const Text(
          'Register',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50),
              child: const Text(
                'Create Account',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              width: double.infinity,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  errorText: checking ? emailErrorText : null,
                  hintText: "Enter your email",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    value = test;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              width: double.infinity,
              child: TextField(
                obscureText: isVisible,
                controller: passwordController,
                decoration: InputDecoration(
                  errorText: checking ? passwordErrorText : null,
                  hintText: "Enter your password",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    icon: Icon(isVisible
                        ? Icons.visibility_off
                        : Icons.visibility_outlined),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    value = test;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              height: 95,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 99, 73, 73),
                ),
                onPressed: () async {
                  saveData();
                  // setState(() {
                  //   loading = true;
                  // });
                  // saveData();
                  // setState(() {
                  //   loading = false;
                  // });
                },
                child: showing
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text("Register"),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.popAndPushNamed(context, '/loginpage');
              },
              child: Container(
                child: const Text("Already have an account? Login"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
