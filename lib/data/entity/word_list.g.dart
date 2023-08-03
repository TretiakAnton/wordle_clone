// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WordListAdapter extends TypeAdapter<WordList> {
  @override
  final int typeId = 0;

  @override
  WordList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WordList(
      name: fields[0] as String,
      words: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, WordList obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.words);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
