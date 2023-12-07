import 'package:cek_ongkir2/model/riwayat_ongkir_model.dart';
import 'package:cek_ongkir2/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<RiwayatOngkir>(RiwayatOngkirAdapter());
  await Hive.openBox<RiwayatOngkir>("riwayatOngkir");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "PublicSansBold",
      ),
      home: const LoginPage(),
    );
  }
}
