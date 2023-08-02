import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeModeAdapter extends TypeAdapter<ThemeMode> {
  @override
  final int typeId = 2; // Unique identifier for the type

  @override
  ThemeMode read(BinaryReader reader) {
    // Read the index of the enum from the binary data and convert it to ThemeMode
    return ThemeMode.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, ThemeMode obj) {
    // Write the index of the enum to the binary data
    writer.writeByte(obj.index);
  }
}
