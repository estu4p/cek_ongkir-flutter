import 'dart:convert';

import 'package:cek_ongkir2/model/costs_model.dart';
import 'package:cek_ongkir2/pages/ongkir_page.dart';
import 'package:cek_ongkir2/utils/global_color.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ControllerOngkir {
  // Asal
  static String province_origin = "0";
  static String city_origin = "0";
  static String Asal = "";
  static String typeAsal = "";
  // destination
  static String province_destination = "0";
  static String city_destination = "0";
  static String Tujuan = "";
  static String typeTujuan = "";
  // Berat
  static TextEditingController weight = TextEditingController();
  // Kurir
  static String code_kurir = "";
  static String nama_kurir = "";
  // Nama untuk simpan
  static TextEditingController alertController = TextEditingController();
  // Ongkir
  static List<CostsModel> ongkir = [];
  static List result = [];

  static Future cekOngkir(BuildContext context) async {
    if (province_origin != "0" &&
        city_origin != "0" &&
        province_destination != "0" &&
        city_destination != "0" &&
        code_kurir != "0" &&
        weight != "") {
      print('masuk');
      try {
        Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");
        var response = await http.post(url, headers: {
          "content-type": "application/x-www-form-urlencoded",
          "key": "3636ebd5258702506bc8c255ef1e24fe",
        }, body: {
          "origin": city_origin,
          "destination": city_destination,
          "weight": weight.text,
          "courier": code_kurir,
        });
        List results = jsonDecode(response.body)['rajaongkir']['results'][0]
            ['costs'] as List;
        ongkir = CostsModel.fromJsonList(results);

        print('cek cek');

        // ignore: use_build_context_synchronously
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return SizedBox(
              height: 500,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          Asal,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        const Icon(Icons.arrow_right_alt_rounded, size: 36),
                        Text(
                          Tujuan,
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
                          "Kurir: $nama_kurir",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Berat: ${weight.text} gram",
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
                        children: ongkir
                            .map(
                              (e) => ListTile(
                                title: Text(
                                  "Layanan: ${e.description!}",
                                  style: const TextStyle(fontSize: 18),
                                ),
                                subtitle: Text(
                                  "Rp ${e.cost![0].value}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                              alert(context);
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
                              "Simpan",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: GlobalColors.hitam,
                                offset: const Offset(4, 4),
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
                              side: BorderSide(
                                width: 3,
                                color: GlobalColors.hitam,
                              ),
                            ),
                            child: const Text(
                              "Batal",
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

        return print('oke');
        // var rel = Ongkir.map((e) => Text(e.service!)).toList();
      } catch (e) {
        print(e);
        print('masuk tp error');
      }
    } else {
      print('tidak masuk');
    }
  }

  static void alert(BuildContext context) {
    showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          title: const Text(
            "Beri nama",
            style: TextStyle(fontSize: 18),
          ),
          content: TextField(
            onChanged: (value) {
              //
            },
            controller: alertController,
            decoration: const InputDecoration(
              hintText: "Masukkan nama untuk simpan",
            ),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OngkirPage(),
                  ),
                );
              },
              color: Colors.white,
              textColor: Colors.black,
              child: const Text("Batal"),
            ),
            MaterialButton(
              onPressed: () {
                // tambahRiwayat();
                // Box<RiwayatOngkir> riwayatOngkir =
                //     Hive.box<RiwayatOngkir>("riwayatOngkir");
                // riwayatOngkir.put(
                //   'key',
                //   RiwayatOngkir(
                //     name: ControllerOngkir.alertController.text,
                //     alamatAsal: ControllerOngkir.Asal,
                //     alamatTujuan: ControllerOngkir.Tujuan,
                //     berat: ControllerOngkir.weight.text,
                //     kurir: ControllerOngkir.nama_kurir,
                //     ongkir: ControllerOngkir.ongkir,
                //   ),
                // );
                Navigator.pop(context);
              },
              color: Colors.amber,
              textColor: Colors.black,
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }
}
