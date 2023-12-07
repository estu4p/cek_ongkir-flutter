// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ControllerCurrencyConverter {
//   TextEditingController amountController = TextEditingController();
//   String currencyType = "USD";
//   String resultText = "";
//   var item = ['IDR', 'USD', 'EUR', 'GBP'];

//   static void convertCurrency() async {
//     double amount = double.parse(amountController.text);
//     String apiUrl = "https://api.exchangerate-api.com/v4/latest/IDR";

//     http.Response response = await http.get(Uri.parse(apiUrl));

//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       double result = amount * data['rates'][currencyType];
//       setState(() {
//         resultText = "Result: $result $currencyType";
//       });
//     } else {
//       setState(() {
//         resultText = "Failed to get data";
//       });
//     }
//   }
// }
