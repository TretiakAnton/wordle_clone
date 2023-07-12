import 'package:hive_flutter/hive_flutter.dart';

part 'word_list.g.dart';

@HiveType(typeId: 1)
class WordList {
  WordList({required this.name, required this.words});

  @HiveField(0)
  String name;

  @HiveField(1)
  List<String> words;
}
