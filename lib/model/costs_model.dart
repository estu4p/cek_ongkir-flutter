class CostsModel {
  String? service;
  String? description;
  List<Cost>? cost;

  CostsModel({
    this.service,
    this.description,
    this.cost,
  });

  CostsModel.fromJson(Map<String, dynamic> json) {
    service = json['service'] as String?;
    description = json['description'] as String?;
    cost = List<Cost>.from(
      json['cost'].map((data) => Cost.fromJson(data)),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['service'] = service;
    data['description'] = description;
    data['cost'] = cost?.map((item) => item.toJson()).toList();
    return data;
  }

  static List<CostsModel> fromJsonList(List? list) {
    if (list == null || list.isEmpty) return List<CostsModel>.empty();
    return list.map((data) => CostsModel.fromJson(data)).toList();
  }
}

class Cost {
  int? value;
  String? etd;
  String? note;

  Cost({
    this.value,
    this.etd,
    this.note,
  });

  Cost.fromJson(Map<String, dynamic> json)
      : value = json['value'] as int?,
        etd = json['etd'] as String?,
        note = json['note'] as String?;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['value'] = value;
    data['etd'] = etd;
    data['note'] = note;
    return data;
  }
}
