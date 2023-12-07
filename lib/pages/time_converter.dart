import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeConverter extends StatefulWidget {
  const TimeConverter({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TimeConverterState createState() => _TimeConverterState();
}

class _TimeConverterState extends State<TimeConverter> {
  DateTime currentTime = DateTime.now();
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());
  }

  void _updateTime() {
    setState(() {
      currentTime = DateTime.now();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Konversi Waktu",
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
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 3, bottom: 5),
                child: Text(
                  'Waktu Saat Ini:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
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
                child: Text(
                  DateFormat('HH:mm:ss || dd-MM-yyyy').format(currentTime),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.only(top: 3, bottom: 5),
                child: Text(
                  'Konversi Waktu',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TimeCard('WIB', '0'),
              TimeCard('WIT', '+2'),
              TimeCard('WITA', '+1'),
              TimeCard('London', '+7'),
            ],
          ),
        ),
      ),
    );
  }

  Widget TimeCard(String location, String offset) {
    DateTime convertedTime =
        currentTime.add(Duration(hours: int.parse(offset)));
    String formattedTime =
        DateFormat('HH:mm:ss || dd-MM-yyyy').format(convertedTime);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
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
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              location,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              formattedTime,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
