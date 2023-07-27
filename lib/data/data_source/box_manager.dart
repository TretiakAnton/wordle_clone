import 'package:hive_flutter/hive_flutter.dart';
import 'package:wordle_clone/core/constants.dart';
import 'package:wordle_clone/data/entity/word_list.dart';

class BoxManager {
  static final BoxManager _instance = BoxManager._internal();
  final String key = 'lettersList';
  bool _isInited = false;
  late Box words4LetterEnBox;
  late Box words5LetterEnBox;
  late Box words6LetterEnBox;
  late Box words4LetterUaBox;
  late Box words5LetterUaBox;
  late Box words6LetterUaBox;

  factory BoxManager() {
    return _instance;
  }

  BoxManager._internal();

  Future<void> init() async {
    if (_isInited) {
      return;
    }
    words4LetterEnBox = await Hive.openBox(hiveKey4LettersEn);
    words5LetterEnBox = await Hive.openBox(hiveKey5LettersEn);
    words6LetterEnBox = await Hive.openBox(hiveKey6LettersEn);
    words4LetterUaBox = await Hive.openBox(hiveKey4LettersUa);
    words5LetterUaBox = await Hive.openBox(hiveKey5LettersUa);
    words6LetterUaBox = await Hive.openBox(hiveKey6LettersUa);
    _isInited = true;
  }

  Future<bool> isBoxEmpty(Box wordBox, String key) async {
    final WordList? words = await wordBox.get(key);
    return words?.words.isEmpty ?? true;
  }

  Future<bool> is4LettersEnEmpty() async {
    return isBoxEmpty(words4LetterEnBox, key);
  }

  Future<bool> is4LettersUaEmpty() async {
    return isBoxEmpty(words4LetterUaBox, key);
  }

  Future<bool> is5LettersEnEmpty() async {
    return isBoxEmpty(words5LetterEnBox, key);
  }

  Future<bool> is5LettersUaEmpty() async {
    return isBoxEmpty(words5LetterUaBox, key);
  }

  Future<bool> is6LettersEnEmpty() async {
    return isBoxEmpty(words6LetterEnBox, key);
  }

  Future<bool> is6LettersUaEmpty() async {
    return isBoxEmpty(words6LetterUaBox, key);
  }

  Future<void> fill4LettersEnWords({required WordList words}) async {
    return await words4LetterEnBox.put(key, words);
  }

  Future<void> fill5LettersEnWords({required WordList words}) async {
    return await words5LetterEnBox.put(key, words);
  }

  Future<void> fill6LettersEnWords({required WordList words}) async {
    return await words6LetterEnBox.put(key, words);
  }

  Future<void> fill4LettersUaWords({required WordList words}) async {
    return await words4LetterUaBox.put(key, words);
  }

  Future<void> fill5LettersUaWords({required WordList words}) async {
    return await words5LetterUaBox.put(key, words);
  }

  Future<void> fill6LettersUaWords({required WordList words}) async {
    return await words6LetterUaBox.put(key, words);
  }

  Future<String> getWord({required int length, required bool isEn}) async {
    String word = '';
    Box box;
    if (isEn) {
      switch (length) {
        case 4:
          box = words4LetterEnBox;
          break;
        case 5:
          box = words5LetterEnBox;
          break;
        case 6:
          box = words6LetterEnBox;
          break;
        default:
          box = words5LetterEnBox;
      }
    } else {
      switch (length) {
        case 4:
          box = words4LetterUaBox;
          break;
        case 5:
          box = words5LetterUaBox;
          break;
        case 6:
          box = words6LetterUaBox;
          break;
        default:
          box = words5LetterUaBox;
      }
    }
    final WordList list = await box.get(key);
    word = list.words.removeAt(0);
    await box.put(key, list);
    return word;
  }
}
