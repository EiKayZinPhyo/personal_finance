import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:personal_finance/screen/login.dart';
import 'package:personal_finance/screen/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:personal_finance/screen/splash.dart';
import 'package:personal_finance/setting/resetpage.dart';
import 'package:personal_finance/setting/settingpage.dart';
import 'package:personal_finance/view/bottom.dart';
import 'package:personal_finance/view/expense.dart';
import 'package:personal_finance/view/home.dart';
import 'package:personal_finance/view/income.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/registerpage',
      routes: {
        '/registerpage': ((context) => const RegisterPage()),
        '/': ((context) => const SplashPage()),
        '/loginpage': ((context) => const LoginPage()),
        '/homepage': (context) => HomePage(
            // enumber: '',

            ),
        '/incomepage': (context) => IncomePage(),
        '/bottompage': (context) => const BottomPage(),
        '/expensepage': (context) => ExpensePage(),
        '/settingpage': (context) => SettingPage(),
        '/resetpage': (context) => ResetPage(),
      },
    );
  }
}
