class ProvinceModel {
  String? provinceId;
  String? province;

  ProvinceModel({
    this.provinceId,
    this.province,
  });

  ProvinceModel.fromJson(Map<String, dynamic> json) {
    provinceId = json["province_id"];
    province = json["province"];
  }

  Map<String, dynamic> toJson() => {
        "province_id": provinceId,
        "province": province,
      };

  static List<ProvinceModel> fromJsonList(List? list) {
    if (list == null || list.isEmpty) return [];
    return list.map((e) => ProvinceModel.fromJson(e)).toList();
  }

  @override
  String toString() => province!;
}
