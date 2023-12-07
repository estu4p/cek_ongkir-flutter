import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'riwayat_ongkir_model.g.dart';

@HiveType(typeId: 0)
class RiwayatOngkir {
  @HiveField(0)
  late String alamatAsal;

  @HiveField(1)
  late String typeAsal;

  @HiveField(2)
  late String alamatTujuan;

  @HiveField(3)
  late String typeTujuan;

  @HiveField(4)
  late String berat;

  @HiveField(5)
  late String kurir;

  @HiveField(6)
  late String description;

  @HiveField(7)
  late String value;

  @HiveField(8)
  late String key;

  RiwayatOngkir({
    required this.alamatAsal,
    required this.typeAsal,
    required this.alamatTujuan,
    required this.typeTujuan,
    required this.berat,
    required this.kurir,
    required this.description,
    required this.value,
  }) : key = const Uuid().v4();
}
