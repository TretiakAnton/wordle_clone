import 'package:hive/hive.dart';
import 'dart:ui';

class LocaleAdapter extends TypeAdapter<Locale> {
  @override
  final int typeId = 3;

  @override
  Locale read(BinaryReader reader) {
    final languageCode = reader.readString();
    final countryCode = reader.readString();
    return Locale(languageCode, countryCode);
  }

  @override
  void write(BinaryWriter writer, Locale obj) {
    writer.writeString(obj.languageCode);
    writer.writeString(obj.countryCode ?? '');
  }
}
