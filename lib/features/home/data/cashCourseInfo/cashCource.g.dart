// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cashCource.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CashCourceAdapter extends TypeAdapter<CashCource> {
  @override
  final int typeId = 3;

  @override
  CashCource read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CashCource(
      courceName: fields[0] as String,
      watcheHoures: fields[1] as String,
      startedCourceAt: fields[2] as DateTime,
      achievement: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CashCource obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.courceName)
      ..writeByte(1)
      ..write(obj.watcheHoures)
      ..writeByte(2)
      ..write(obj.startedCourceAt)
      ..writeByte(3)
      ..write(obj.achievement);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CashCourceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
