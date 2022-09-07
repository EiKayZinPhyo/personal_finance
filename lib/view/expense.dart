import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExpensePage extends StatefulWidget {
  final Function(String title, double amount) addTransaction;
  ExpensePage({Key? key, required this.addTransaction}) : super(key: key);
  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  TextEditingController enumberController = TextEditingController();

  TextEditingController name = TextEditingController();

  Future<void> submitTransaction() async {
    final String title = name.text;
    final double amount = double.parse(enumberController.text);
    // if (title.length <= 0 || amount <= 0) return;

    //widget.addTransaction(title, amount);

    var data = FirebaseFirestore.instance
        .collection("expense")
        .doc(FirebaseAuth.instance.currentUser?.uid.toString())
        .collection("totalexp");

    var result = await data.add({"title": title, "amount": amount});

    Navigator.pop(context, "expense");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffAE9B9B),
        elevation: 1,
        title: const Text(
          'ExpensePage',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/bottompage');
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
      ),
      backgroundColor: Color(0xffAE9B9B),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          height: 90,
          child: TextField(
            controller: name,
            decoration: InputDecoration(
              hintText: 'Type Something(eg,Buy egg)',
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.black)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.black)),
            ),
            onSubmitted: (_) {
              submitTransaction();
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          height: 90,
          child: TextField(
            controller: enumberController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Add amount',
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.black)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.black)),
            ),
            onSubmitted: (_) {
              submitTransaction();
            },
          ),
        ),
        Container(
          width: double.infinity,
          height: 70,
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () {
              submitTransaction();
              // setState(() {
              //   var route = MaterialPageRoute(
              //       builder: ((context) => HomePage(
              //             enumber: enumberController.text,
              //             number: '',
              //           )));
              //   Navigator.of(context).push(route);
              // });
              // Navigator.pushNamed(context, '/homepage');
            },
            style: ElevatedButton.styleFrom(
              primary: const Color.fromARGB(255, 99, 73, 73),
            ),
            child: const Text("Add Expense"),
          ),
        )
      ]),
    );
  }
}
