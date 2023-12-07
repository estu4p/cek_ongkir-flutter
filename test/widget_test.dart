import 'package:cek_ongkir2/model/province_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");

  try {
    final response = await http.get(
      url,
      headers: {"key": "3636ebd5258702506bc8c255ef1e24fe"},
    );

    var dataProvince = jsonDecode(response.body) as Map<String, dynamic>;
    var listProvince = dataProvince['rajaongkir']['results'];

    if (dataProvince['rajaongkir']['status']['code'] != 200) {
      throw dataProvince['rajaongkir']['status']['description'];
    }

    var listData = ProvinceModel.fromJsonList(listProvince);

    print(listData);
    // print(jsonDecode(response.body));
  } catch (e) {
    print(e);
  }
}
