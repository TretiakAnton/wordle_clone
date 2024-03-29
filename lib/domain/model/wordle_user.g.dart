// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wordle_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WordleUserAdapter extends TypeAdapter<WordleUser> {
  @override
  final int typeId = 1;

  @override
  WordleUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WordleUser(
      name: fields[0] as String,
      email: fields[1] as String,
      id: fields[2] as String,
      photo: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WordleUser obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.photo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordleUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
