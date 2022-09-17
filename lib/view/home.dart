import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:personal_finance/models/expenseList.dart';
import 'package:personal_finance/models/newexpense.dart';

import '../models/piechart.dart';

class HomePage extends StatefulWidget {
  Function? callback;

  @override
  // ignore: no_logic_in_create_state
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState();

  double totalIncome = 0.0;
  double expenseNo = 0.0;

  fetchIncome() async {
    double tempTotalIncome = 0.0;
    var data = FirebaseFirestore.instance
        .collection("income")
        .doc(FirebaseAuth.instance.currentUser?.uid.toString())
        .collection("total_income");

    var result = await data.get();
    List<Newexpense> emptyList = [];
    result.docs.forEach((element) {
      tempTotalIncome += element['amount'];
    });

    setState(() {
      totalIncome = tempTotalIncome;
    });
  }

  fetchExpense() async {
    double tempTotalExpense = 0.0;
    var data = FirebaseFirestore.instance
        .collection("expense")
        .doc(FirebaseAuth.instance.currentUser?.uid.toString())
        .collection("totalexp");

    var result = await data.get();
    List<Newexpense> emptyList = [];
    result.docs.forEach((element) {
      tempTotalExpense += element['amount'];
    });

    setState(() {
      expenseNo = tempTotalExpense;
    });
  }

  List<Newexpense> transactions = [];

  fetchExpenseList() async {
    //print(FirebaseAuth.instance.currentUser?.uid);

    var data = FirebaseFirestore.instance
        .collection("expense")
        .doc(FirebaseAuth.instance.currentUser?.uid.toString())
        .collection("totalexp");

    var result = await data.get();
    List<Newexpense> emptyList = [];

    result.docs.forEach((element) {
      Newexpense ex =
          Newexpense(title: element['title'], amount: element['amount']);
      emptyList.add(ex);
    });

    setState(() {
      transactions.clear();
      transactions.addAll(emptyList);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    // addTransaction('', 1.0);

    fetchIncome();
    fetchExpense();
    fetchExpenseList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffAE9B9B),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 100,
            child: PieChartPage(
              totalExpense: expenseNo,
              totalIncome: totalIncome,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // height: 30,
                width: 180,
                height: 80,
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () async {
                    var result = await Navigator.pushNamed(
                        context, '/incomepage',
                        arguments: {"isTap": false});

                    if (result == "income") {
                      fetchIncome();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xffC9CDD0)),
                  child: const Text(
                    'Add Income',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Container(
                // height: 30,
                width: 180,
                height: 80,
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () async {
                    final result = await Navigator.pushNamed(
                        context, '/expensepage',
                        arguments: {"isTap": false});

                    if (result == "expense") {
                      fetchExpenseList();
                      fetchExpense();
                    } else {}
                  },
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xffC9CDD0)),
                  child: const Text(
                    'Add Expense',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 180,
                height: 110,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xffC9CDD0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Income',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(totalIncome.toString()),
                    Text('kyats'),
                  ],
                ),
              ),
              Container(
                width: 180,
                height: 110,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: Color(0xffC9CDD0),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                      )
                    ]),
                child: Column(
                  children: [
                    Text(
                      'Expense',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(expenseNo.toString()),
                    Text('kyats'),
                  ],
                ),
              ),
            ],
          ),

          ExpenseList(
            transactions: transactions,
          ),
          // Container(
          //   height: 100,
          //   child: ListView.builder(
          //     itemCount: expense.length,
          //     itemBuilder: ((context, index) {
          //       return Card(
          //         child: Row(children: [
          //           Text(expense[index].title.toString()),
          //         ]),
          //       );
          //     }),
          //   ),
          // ),
        ],
      ),
    );
  }
}
