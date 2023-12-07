// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'riwayat_ongkir_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RiwayatOngkirAdapter extends TypeAdapter<RiwayatOngkir> {
  @override
  final int typeId = 0;

  @override
  RiwayatOngkir read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RiwayatOngkir(
      alamatAsal: fields[0] as String,
      typeAsal: fields[1] as String,
      alamatTujuan: fields[2] as String,
      typeTujuan: fields[3] as String,
      berat: fields[4] as String,
      kurir: fields[5] as String,
      description: fields[6] as String,
      value: fields[7] as String,
    )..key = fields[8] as String;
  }

  @override
  void write(BinaryWriter writer, RiwayatOngkir obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.alamatAsal)
      ..writeByte(1)
      ..write(obj.typeAsal)
      ..writeByte(2)
      ..write(obj.alamatTujuan)
      ..writeByte(3)
      ..write(obj.typeTujuan)
      ..writeByte(4)
      ..write(obj.berat)
      ..writeByte(5)
      ..write(obj.kurir)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.value)
      ..writeByte(8)
      ..write(obj.key);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RiwayatOngkirAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
