// To parse this JSON data, do
//
//     final newexpense = newexpenseFromJson(jsonString);

import 'dart:convert';

class Newexpense {
  Newexpense({
    required this.title,
    required this.amount,
  });

  String title;
  double amount;

  // factory Newexpense.fromRawJson(String str) =>
  //     Newexpense.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  // factory Newexpense.fromJson(Map<String, dynamic> json) => Newexpense(
  //       title: json["title"],
  //       amount: json["amount"].toDouble(),
  //     );

  // Map<String, dynamic> toJson() => {
  //       "title": title,
  //       "amount": amount,
  //     };
}
