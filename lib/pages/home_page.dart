import 'package:cek_ongkir2/pages/currency_converter.dart';
import 'package:cek_ongkir2/pages/login_page.dart';
import 'package:cek_ongkir2/pages/ongkir_page.dart';
import 'package:cek_ongkir2/pages/profile_page.dart';
import 'package:cek_ongkir2/pages/time_converter.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> body = [
    const OngkirPage(),
    const CurrencyConverter(),
    const TimeConverter(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: const Text('hello'),
      body: body[_currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.amber,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                backgroundColor: Colors.amber,
                label: "Beranda",
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: "Mata Uang",
                icon: Icon(Icons.attach_money),
              ),
              BottomNavigationBarItem(
                label: "Waktu",
                icon: Icon(Icons.access_time),
              ),
              BottomNavigationBarItem(
                label: "Profil",
                icon: Icon(Icons.person),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _logOut(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}
