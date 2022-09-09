import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance/controllers/bottom_controller.dart';
import 'package:personal_finance/view/expense.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../controllers/incomebotto_controller.dart';
import '../setting/settingpage.dart';
import 'home.dart';
import 'income.dart';

class BottomPage extends StatefulWidget {
  const BottomPage({Key? key}) : super(key: key);

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  BottomController btnController = Get.put(BottomController());
  // IncomeBottomController incomebtnController =
  //     Get.put(IncomeBottomController());

  PageController pageController = PageController();
  // PageController incomepageController = PageController();

  int _currentIndex = 0;

  void onTabTapped(int value) {
    pageController.jumpToPage(value);
  }

  void onPageChanged(int index) {
    setState(() {
      index = this._currentIndex;
    });
  }

  final List<Widget> _children = [
    HomePage(),
    IncomePage(isTabIncome: true),
    ExpensePage(isTab: true),
    SettingPage(),
  ];

  // final _auth = FirebaseAuth.instance;

  // void getCurrentUser() async {
  //   try {
  //     final user = _auth.currentUser;
  //     if (user != null) {
  //       loginUser = user;
  //       Navigator.pushNamed(context, '/bottompage');
  //     }
  //     print(loginUser!.email);
  //   } catch (e) {
  //     // Navigator.pushNamed(context, '/registerpage');
  //   }
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getCurrentUser();
  // }

  @override
  Widget build(BuildContext context) {
    btnController.addPage(pageController);
    // incomebtnController.addPage(incomepageController);

    return Scaffold(
      body: PageView(
        controller: pageController,
        children: _children,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        unselectedItemColor: Color(0xffAE9B9B),
        selectedItemColor: Colors.black,
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money_rounded),
            label: 'Income',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money_off),
            label: 'Expense',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
