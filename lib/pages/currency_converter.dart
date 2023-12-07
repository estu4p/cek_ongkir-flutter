import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  TextEditingController amountController = TextEditingController();
  String toCurrencyType = "IDR";
  String currencyType = "IDR";
  String resultText = "";
  var item = ['IDR', 'USD', 'EUR', 'GBP'];

  void _convertCurrency() async {
    double amount = double.parse(amountController.text);
    String apiUrl = "https://api.exchangerate-api.com/v4/latest/$currencyType";

    http.Response response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      double result = amount * data['rates'][toCurrencyType];
      setState(() {
        resultText = "$result $toCurrencyType";
      });
    } else {
      setState(() {
        resultText = "Terjadi kesalahan";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Konversi Mata uang",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        shape: const Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 3, bottom: 5),
              child: Text(
                'Konversi',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(width: 3),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(8, 8),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Masukkan Jumlah Uang",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(width: 3),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(8, 8),
                        ),
                      ],
                    ),
                    child: DropdownButton(
                      value: currencyType,
                      items: item.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          currencyType = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Conversion
            const Padding(
              padding: EdgeInsets.only(top: 3, bottom: 5),
              child: Text(
                'Hasil',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    padding:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(width: 3),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(8, 8),
                        ),
                      ],
                    ),
                    child: (resultText.isNotEmpty)
                        ? Text(
                            resultText,
                            style: const TextStyle(fontSize: 16),
                          )
                        : const Text(
                            "Hasil Konversi",
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(width: 3),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(8, 8),
                        ),
                      ],
                    ),
                    child: DropdownButton(
                      value: toCurrencyType,
                      items: item.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          toCurrencyType = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(8, 8),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _convertCurrency,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(
                      width: 3,
                      color: Colors.black,
                    ),
                  ),
                  child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Konversi Mata Uang",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
