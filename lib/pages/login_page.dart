import 'package:cek_ongkir2/pages/home_page.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController? usernameController = TextEditingController();
    TextEditingController? passwordController = TextEditingController();
    bool isLoginSuccess = false;

    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Login",
              style: TextStyle(fontSize: 32),
            ),
            const Text(
              "Selamat datang kembali",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            // Username
            const SizedBox(height: 40),
            const Text(
              "Username",
              style: TextStyle(fontSize: 18),
            ),
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                label: Text(
                  "Masukkan Username",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.5,
                  ),
                ),
              ),
            ),
            // Password
            const SizedBox(height: 40),
            const Text(
              "Password",
              style: TextStyle(fontSize: 18),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                label: Text(
                  "Masukkan Password",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.5,
                  ),
                ),
              ),
            ),
            // Button Login
            const SizedBox(height: 90),
            Container(
              width: double.infinity,
              height: 67,
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
                onPressed: () {
                  String username = usernameController.text;
                  String password = passwordController.text;

                  String text = "";

                  final hashedPassword =
                      sha256.convert(utf8.encode("admin123")).toString();

                  final enteredHashPassword =
                      sha256.convert(utf8.encode(password)).toString();

                  if (username == "admin" &&
                      enteredHashPassword == hashedPassword) {
                    print("Enkripsi username dan password = ");
                    print(enteredHashPassword);
                    print(hashedPassword);
                    setState(() {
                      text = "Login Berhasil";
                      isLoginSuccess = true;
                    });
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const HomePage();
                        },
                      ),
                    );
                  } else {
                    setState(() {
                      text = "Login Gagal";
                      isLoginSuccess = false;
                    });
                  }
                  SnackBar snackBar = SnackBar(
                    backgroundColor:
                        (isLoginSuccess) ? Colors.blue : Colors.red,
                    content: Text(text),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  side: const BorderSide(
                    width: 3,
                    color: Colors.black,
                  ),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
            // Google Login
            const SizedBox(height: 40),
            Container(
              width: double.infinity,
              height: 67,
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  side: const BorderSide(
                    width: 3,
                    color: Colors.black,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/google.png", width: 25),
                    const SizedBox(width: 20),
                    const Text(
                      "Login Dengan Google",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Belum punya akun? ",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Text(
                  "Buat Akun",
                  style: TextStyle(fontSize: 16),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
