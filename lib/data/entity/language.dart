import 'dart:ui';

import 'package:hive_flutter/hive_flutter.dart';

part 'language.g.dart';

@HiveType(typeId: 2)
class Language {
  Language({required this.locale});

  @HiveField(0)
  final Locale locale;

  String icon() {
    return 'https://flagcdn.com/w320/${locale.countryCode?.toLowerCase()}.png';
  }

  String languageName() {
    switch (locale.countryCode) {
      case 'GB':
        return 'English';
      case 'UA':
        return 'Ukrainian';
      default:
        return '';
    }
  }
}
