import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

  void loginData() async {
    // if (userErrorText == null && passwordErrorText == null) {
    try {
      setState(() {
        showing = true;
      });
      final auth = FirebaseAuth.instance;
      final singinemail = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      print('>>>>>>>>>>');
      print(singinemail);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/bottompage');
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
      backgroundColor: const Color(0xffAE9B9B),
      appBar: AppBar(
        backgroundColor: const Color(0xffAE9B9B),
        leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/registerpage');
            },
            icon: Icon(Icons.arrow_back)),
        title: const Text(
          'LoginPage',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 50, left: 20),
              child: const Text(
                'Welcome Back',
                style: TextStyle(fontSize: 18),
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
                  ),
                  onChanged: (value) {
                    setState(() {
                      value = test;
                    });
                  }),
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
              height: 50,
              padding: const EdgeInsets.only(left: 20, right: 20),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  loginData();
                },
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 99, 73, 73)),
                child: showing
                    ? Center(child: CircularProgressIndicator())
                    : const Text('Login',
                        style: TextStyle(color: Colors.black)),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.popAndPushNamed(context, '/registerpage');
              },
              child: Container(
                child: const Text("Don't have an account? Register"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
