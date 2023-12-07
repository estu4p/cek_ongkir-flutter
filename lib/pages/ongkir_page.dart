import 'dart:convert';

import 'package:cek_ongkir2/controller/controller_ongkir.dart';
import 'package:cek_ongkir2/model/city_model.dart';
import 'package:cek_ongkir2/model/costs_model.dart';
import 'package:cek_ongkir2/model/province_model.dart';
import 'package:cek_ongkir2/model/riwayat_ongkir_model.dart';
import 'package:cek_ongkir2/utils/global_color.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class OngkirPage extends StatefulWidget {
  const OngkirPage({super.key});

  @override
  State<OngkirPage> createState() => _OngkirPageState();
}

class _OngkirPageState extends State<OngkirPage> {
  static late Box<RiwayatOngkir> favoritesBox;

  @override
  void initState() {
    reset();
    super.initState();
    favoritesBox = Hive.box<RiwayatOngkir>("riwayatOngkir");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cek Ongkir",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        shape: Border(
          bottom: BorderSide(
            color: GlobalColors.hitam,
            width: 2,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15.0),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Provinsi Asal
              const Padding(
                padding: EdgeInsets.only(top: 3, bottom: 5),
                child: Text(
                  'Asal',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: GlobalColors.hitam,
                        // spreadRadius: 2,
                        offset: const Offset(8, 8),
                      ),
                    ],
                  ),
                  child: DropdownSearch<ProvinceModel>(
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 3,
                            color: GlobalColors.hitam,
                          ),
                        ),
                        labelText: "Provinsi",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(width: 3, color: GlobalColors.hitam),
                        ),
                        fillColor: Colors.red,
                        filled: true,
                      ),
                    ),
                    asyncItems: (Text) async {
                      var response = await Dio().get(
                        'https://api.rajaongkir.com/starter/province',
                        queryParameters: {
                          "key": "3636ebd5258702506bc8c255ef1e24fe"
                        },
                      );
                      var model = ProvinceModel.fromJsonList(
                        response.data["rajaongkir"]["results"],
                      );
                      return model;
                    },
                    onChanged: (data) => ControllerOngkir.province_origin =
                        data?.provinceId ?? "0",
                    itemAsString: (data) {
                      return "${data.province}";
                    },
                    popupProps: const PopupPropsMultiSelection.menu(
                      showSearchBox: true,
                    ),
                  ),
                ),
              ),
              // Kabupaten / Kota Asal
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: GlobalColors.hitam,
                        // spreadRadius: 2,
                        offset: const Offset(8, 8),
                      ),
                    ],
                  ),
                  child: DropdownSearch<CityModel>(
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 3,
                            color: GlobalColors.hitam,
                          ),
                        ),
                        labelText: "Kabupaten / Kota",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(width: 3, color: GlobalColors.hitam),
                        ),
                        fillColor: Colors.blue,
                        filled: true,
                      ),
                    ),
                    asyncItems: (Text) async {
                      var response = await Dio().get(
                        'https://api.rajaongkir.com/starter/city?province=${ControllerOngkir.province_origin}',
                        queryParameters: {
                          "key": "3636ebd5258702506bc8c255ef1e24fe"
                        },
                      );
                      var model = CityModel.fromJsonList(
                        response.data["rajaongkir"]["results"],
                      );
                      return model;
                    },
                    onChanged: (data) =>
                        ControllerOngkir.city_origin = data?.cityId ?? "0",
                    itemAsString: (data) {
                      ControllerOngkir.Asal = data.cityName!;
                      ControllerOngkir.typeAsal = data.type!;
                      return "${data.type} ${data.cityName}";
                    },
                    popupProps: const PopupPropsMultiSelection.menu(
                      showSearchBox: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Tujuan
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  'Tujuan',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: GlobalColors.hitam,
                        // spreadRadius: 2,
                        offset: const Offset(8, 8),
                      ),
                    ],
                  ),
                  // Provinsi
                  child: DropdownSearch<ProvinceModel>(
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 3,
                            color: GlobalColors.hitam,
                          ),
                        ),
                        labelText: "Provinsi",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(width: 3, color: GlobalColors.hitam),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                    asyncItems: (Text) async {
                      var response = await Dio().get(
                        'https://api.rajaongkir.com/starter/province',
                        queryParameters: {
                          "key": "3636ebd5258702506bc8c255ef1e24fe"
                        },
                      );
                      var model = ProvinceModel.fromJsonList(
                        response.data["rajaongkir"]["results"],
                      );
                      return model;
                    },
                    onChanged: (data) => ControllerOngkir.province_destination =
                        data?.provinceId ?? "0",
                    itemAsString: (data) {
                      return "${data.province}";
                    },
                    popupProps: const PopupPropsMultiSelection.menu(
                      showSearchBox: true,
                    ),
                  ),
                ),
              ),
              // Kabupaten / Kota Tujuan
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: GlobalColors.hitam,
                        // spreadRadius: 2,
                        offset: const Offset(8, 8),
                      ),
                    ],
                  ),
                  child: DropdownSearch<CityModel>(
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 3,
                            color: GlobalColors.hitam,
                          ),
                        ),
                        labelText: "Kabupaten / Kota",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(width: 3, color: GlobalColors.hitam),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                    asyncItems: (Text) async {
                      var response = await Dio().get(
                        'https://api.rajaongkir.com/starter/city?province=${ControllerOngkir.province_destination}',
                        queryParameters: {
                          "key": "3636ebd5258702506bc8c255ef1e24fe"
                        },
                      );
                      var model = CityModel.fromJsonList(
                        response.data["rajaongkir"]["results"],
                      );
                      return model;
                    },
                    onChanged: (data) =>
                        ControllerOngkir.city_destination = data?.cityId ?? "0",
                    itemAsString: (data) {
                      ControllerOngkir.Tujuan = data.cityName!;
                      ControllerOngkir.typeTujuan = data.type!;
                      return "${data.type} ${data.cityName}";
                    },
                    popupProps: const PopupPropsMultiSelection.menu(
                      showSearchBox: true,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Berat
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text(
                            'Berat',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: GlobalColors.hitam,
                                  // spreadRadius: 2,
                                  offset: const Offset(8, 8),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: ControllerOngkir.weight,
                              autocorrect: false,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Berat (gram)",
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    width: 3,
                                    color: GlobalColors.hitam,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.all(18),
                                border: const OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      width: 3, color: GlobalColors.hitam),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Kurir
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(
                          'Kurir',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: GlobalColors.hitam,
                                  // spreadRadius: 2,
                                  offset: const Offset(8, 8),
                                ),
                              ],
                            ),
                            child: DropdownSearch<Map<String, dynamic>>(
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      width: 3,
                                      color: GlobalColors.hitam,
                                    ),
                                  ),
                                  labelText: "Kurir",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        width: 3, color: GlobalColors.hitam),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                              ),
                              items: const [
                                {
                                  "code": "jne",
                                  "name": "JNE",
                                },
                                {
                                  "code": "pos",
                                  "name": "POS Indonesia",
                                },
                                {
                                  "code": "tiki",
                                  "name": "TIKI",
                                }
                              ],
                              onChanged: (data) => ControllerOngkir.code_kurir =
                                  data?['code'] ?? "",
                              itemAsString: (data) {
                                ControllerOngkir.nama_kurir = data['name'];
                                return "${data['name']}";
                              },
                              popupProps: const PopupPropsMultiSelection.menu(
                                showSearchBox: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              // Tombol
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
                    onPressed: () {
                      // ControllerOngkir.cekOngkir(context);
                      cekOngkir(context);
                    },
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
                        'Cek Ongkir',
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
        ],
      ),
    );
  }

  static Future cekOngkir(BuildContext context) async {
    if (ControllerOngkir.province_origin != "0" &&
        ControllerOngkir.city_origin != "0" &&
        ControllerOngkir.city_destination != "0" &&
        ControllerOngkir.city_destination != "0" &&
        ControllerOngkir.code_kurir != "0" &&
        ControllerOngkir.weight != "") {
      print('masuk');
      try {
        Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");
        var response = await http.post(url, headers: {
          "content-type": "application/x-www-form-urlencoded",
          "key": "3636ebd5258702506bc8c255ef1e24fe",
        }, body: {
          "origin": ControllerOngkir.city_origin,
          "destination": ControllerOngkir.city_destination,
          "weight": ControllerOngkir.weight.text,
          "courier": ControllerOngkir.code_kurir,
        });
        List results = jsonDecode(response.body)['rajaongkir']['results'][0]
            ['costs'] as List;
        ControllerOngkir.ongkir = CostsModel.fromJsonList(results);

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
                          ControllerOngkir.Asal,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        const Icon(Icons.arrow_right_alt_rounded, size: 36),
                        Text(
                          ControllerOngkir.Tujuan,
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
                          "Kurir: ${ControllerOngkir.nama_kurir}",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Berat: ${ControllerOngkir.weight.text} gram",
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
                        children: ControllerOngkir.ongkir
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
                        // Button Simpan
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
                              tambahRiwayat();
                              reset();
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
                        // Button Tutup
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
                              reset();
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

  static void tambahRiwayat() {
    print('Tambah ke riwayat');
    favoritesBox.add(
      RiwayatOngkir(
        alamatAsal: ControllerOngkir.Asal,
        typeAsal: ControllerOngkir.typeAsal,
        alamatTujuan: ControllerOngkir.Tujuan,
        typeTujuan: ControllerOngkir.typeTujuan,
        berat: ControllerOngkir.weight.text,
        kurir: ControllerOngkir.nama_kurir,
        description:
            ControllerOngkir.ongkir.map((e) => e.description).first ?? "",
        value: ControllerOngkir.ongkir
            .map((e) => e.cost![0].value)
            .first
            .toString(),
      ),
    );
  }

  static void reset() {
    ControllerOngkir.province_origin = "";
    ControllerOngkir.province_destination = "";
    ControllerOngkir.city_origin = "";
    ControllerOngkir.city_destination = "";
    ControllerOngkir.weight.text = "";
    ControllerOngkir.code_kurir = "";
  }
}
