class CityModel {
  String? cityId;
  String? provinceId;
  String? province;
  String? type;
  String? cityName;
  String? postalCode;

  CityModel({
    this.cityId,
    this.provinceId,
    this.province,
    this.type,
    this.cityName,
    this.postalCode,
  });

  CityModel.fromJson(Map<String, dynamic> json) {
    cityId = json["city_id"];
    provinceId = json["province_id"];
    province = json["province"];
    type = json["type"];
    cityName = json["city_name"];
    postalCode = json["postal_code"];
  }

  Map<String, dynamic> toJson() => {
        "city_id": cityId,
        "province_id": provinceId,
        "province": province,
        "type": type,
        "city_name": cityName,
        "postal_code": postalCode,
      };

  static List<CityModel> fromJsonList(List? list) {
    if (list == null || list.isEmpty) return [];
    return list.map((e) => CityModel.fromJson(e)).toList();
  }

  @override
  String toString() => cityName!;
}
