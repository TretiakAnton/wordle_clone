import 'package:hive_flutter/hive_flutter.dart';
import 'package:wordle_clone/core/constants.dart';
import 'package:wordle_clone/data/entity/word_list.dart';

class BoxManager {
  static final BoxManager _instance = BoxManager._internal();
  final String key = 'lettersList';
  late Box words4LetterBox;
  late Box words5LetterBox;
  late Box words6LetterBox;

  factory BoxManager() {
    return _instance;
  }

  BoxManager._internal();

  Future<void> init() async {
    words4LetterBox = await Hive.openBox(hiveKey4Letters);
    words5LetterBox = await Hive.openBox(hiveKey5Letters);
    words6LetterBox = await Hive.openBox(hiveKey6Letters);
  }

  Future<bool> is4LettersEmpty() async {
    final WordList? words = await words4LetterBox.get(key);
    if (words != null) {
      return words.words.isEmpty;
    }
    return true;
  }

  Future<bool> is5LettersEmpty() async {
    final WordList? words = await words5LetterBox.get(key);
    if (words != null) {
      return words.words.isEmpty;
    }
    return true;
  }

  Future<bool> is6LettersEmpty() async {
    final WordList? words = await words6LetterBox.get(key);
    if (words != null) {
      return words.words.isEmpty;
    }
    return true;
  }
}