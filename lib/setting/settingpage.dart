import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffAE9B9B),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 85,
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              child: const Text(
                'Reset Password',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/resetpage');
              },
              style: ElevatedButton.styleFrom(primary: Color(0xffC9CDD0)),
            ),
          ),
          Container(
            width: double.infinity,
            height: 85,
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/registerpage');
              },
              style: ElevatedButton.styleFrom(primary: Color(0xffC9CDD0)),
            ),
          ),
        ],
      ),
    );
  }
}
