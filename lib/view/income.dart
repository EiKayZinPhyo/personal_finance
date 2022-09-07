import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:personal_finance/view/home.dart';

class IncomePage extends StatefulWidget {
  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  var test = '';
  TextEditingController numberController = TextEditingController();

  Future<void> addIncome() async {
    final String title = '';
    final double amount = double.parse(numberController.text);
    // if (title.length <= 0 || amount <= 0) return;

    //widget.addTransaction(title, amount);

   
    var data = FirebaseFirestore.instance
        .collection("income")
        .doc(FirebaseAuth.instance.currentUser?.uid.toString())
        .collection("total_income");

    var result = await data.add({"title": title, "amount": amount});
    print(result);

    Navigator.pop(context,"income");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'IncomePage',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          backgroundColor: const Color(0xffAE9B9B),
          elevation: 1,
          leading: IconButton(
            color: Colors.black,
            onPressed: () {
              Navigator.restorablePopAndPushNamed(context, '/bottompage');
            },
            icon: const Icon(Icons.arrow_back),
          )),
      backgroundColor: const Color(0xffAE9B9B),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            height: 90,
            child: TextField(
              onSubmitted: (value) {
                setState(() {
                  value = numberController.text;
                });
              },
              controller: numberController,
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
            ),
          ),
          Container(
            width: double.infinity,
            height: 70,
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: addIncome,
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 99, 73, 73),
              ),
              child: const Text("Add Income"),
            ),
          )
        ]),
      ),
    );
  }
}
