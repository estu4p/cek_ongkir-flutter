import 'package:cek_ongkir2/model/riwayat_ongkir_model.dart';
import 'package:cek_ongkir2/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Box<RiwayatOngkir> riwayatBox;
  late RiwayatOngkir? Rongkir;
  late int indexDetail = 0;

  @override
  void initState() {
    riwayatBox = Hive.box<RiwayatOngkir>("riwayatOngkir");
    Rongkir = riwayatBox.get('key');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            // Background dan profile
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/bg-profi.jpg",
                        fit: BoxFit.cover,
                        height: 230,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -60,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 4),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            // spreadRadius: 2,
                            offset: Offset(5, 5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/images/profil.jpg",
                          width: 120,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 15,
                    top: 20,
                    child: PopupMenuButton<String>(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      onSelected: (value) {
                        if (value == 'contact') {
                          urlLauncher();
                          print('Contact');
                        } else if (value == 'logout') {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                          print('Logout');
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'contact',
                          child: ListTile(
                            title: Text('Pesan dan Kesan PAM'),
                            leading: Icon(Icons.mail),
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'logout',
                          child: ListTile(
                            title: Text('Logout'),
                            leading: Icon(Icons.exit_to_app),
                          ),
                        ),
                      ],
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 3),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade200,
                          boxShadow: const [
                            BoxShadow(offset: Offset(3, 3)),
                          ],
                        ),
                        child: const Icon(Icons.more_vert_rounded, size: 35),
                      ),
                    ),
                  ),

                  // Positioned(
                  //   right: 15,
                  //   top: 20,
                  //   child: InkWell(
                  //     onTap: () {
                  //       // popUpMenu();
                  //     },
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //         border: Border.all(width: 3),
                  //         borderRadius: BorderRadius.circular(10),
                  //         color: Colors.grey.shade200,
                  //         boxShadow: const [
                  //           BoxShadow(offset: Offset(3, 3)),
                  //         ],
                  //       ),
                  //       child: const Icon(Icons.more_vert_rounded, size: 35),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 100),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  // Nama
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Reza Pramudya",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 3),
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.check, size: 22),
                      )
                    ],
                  ),
                  // NIM
                  const Text(
                    "124210066",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  // Daftar Tersimpan
                  const SizedBox(height: 30),
                  // Jumlah Riwayat tersimpan
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 90,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(width: 3),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(8, 8),
                              ),
                            ],
                          ),
                          child: riwayatBox.isNotEmpty
                              ? Text(
                                  "${riwayatBox.length}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 28),
                                )
                              : const Text(
                                  "0",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 28),
                                ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 3),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.amber,
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(8, 8),
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Ongkir Tersimpan",
                                style: TextStyle(fontSize: 24),
                              ),
                              Icon(
                                Icons.bookmark,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Daftar Riwayat tersimpan
                  const SizedBox(height: 5),
                  riwayatBox.isEmpty
                      ? const SizedBox(
                          height: 250,
                          child: Center(
                            child: Text(
                              "Belum ada riwayat ongkir",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: riwayatBox.length,
                          itemBuilder: (context, index) {
                            var riwayat = riwayatBox.getAt(index);
                            return Padding(
                              padding: const EdgeInsets.only(
                                top: 15,
                                left: 15,
                                right: 15,
                              ),
                              child: InkWell(
                                onTap: () {
                                  showDetail(index);
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 3),
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(offset: Offset(4, 4)),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            "${riwayat?.kurir}",
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            "${riwayat?.berat}",
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "${riwayat?.typeAsal} ${riwayat?.alamatAsal}",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          // Icon(Icons.arrow_circle_down_rounded),
                                          Text(
                                            "${riwayat?.alamatTujuan} ${riwayat?.alamatTujuan}",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }

  void showDetail(int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        var riwayat = riwayatBox.getAt(index);
        return SizedBox(
          height: 500,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                // Text Ongkos Kirim
                const Text(
                  "Ongkos Kirim",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(height: 2),
                const SizedBox(height: 20),
                // Provinsi asal
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "${riwayat?.alamatAsal}",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    const Icon(Icons.arrow_right_alt_rounded, size: 36),
                    Text(
                      "${riwayat?.alamatTujuan}",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Kurir: ${riwayat?.kurir}",
                      // "Kurir: $nama_kurir",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Berat: ${riwayat?.berat} gram",
                      // "Berat: ${weight.text} gram",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          "${riwayat?.description}",
                          style: const TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          "Rp ${riwayat?.value}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Button Hapus
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(4, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          riwayatBox.deleteAt(index);
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 25,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: Colors.amber,
                          side: const BorderSide(
                            width: 3,
                            color: Colors.amber,
                          ),
                        ),
                        child: const Text(
                          "Hapus",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Button Tutup
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(4, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 25,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: Colors.white,
                          side: const BorderSide(
                            width: 3,
                            color: Colors.black,
                          ),
                        ),
                        child: const Text(
                          "Tutup",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void urlLauncher() async {
    print("proses url launch");
    final Uri url = Uri.parse("https://wa.me/6285729237545");
    if (!await launchUrl(url)) {
      await launchUrl(url);
    } else {
      throw Exception("Gagal membuka url");
    }
  }
}
