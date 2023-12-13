// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SmartShedUserAdapter extends TypeAdapter<SmartShedUser> {
  @override
  final int typeId = 1;

  @override
  SmartShedUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SmartShedUser(
      id: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String,
      position: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SmartShedUser obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.position);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SmartShedUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
