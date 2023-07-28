import 'package:hive_flutter/hive_flutter.dart';
import 'package:wordle_clone/data/entity/word_list.dart';

class BoxManager {
  static final BoxManager _instance = BoxManager._internal();
  final String _key4Letters = '4Letters';
  final String _key5Letters = '5Letters';
  final String _key6Letters = '6Letters';
  final String _hiveUaWordBox = 'uaWordsBox';
  final String _hiveEnWordBox = 'enWordsBox';
  bool _isInited = false;
  late Box _enWordsBox;
  late Box _uaWordsBox;

  factory BoxManager() {
    return _instance;
  }

  BoxManager._internal();

  Future<void> init() async {
    if (_isInited) {
      return;
    }
    _uaWordsBox = await Hive.openBox(_hiveUaWordBox);
    _enWordsBox = await Hive.openBox(_hiveEnWordBox);
    _isInited = true;
  }

  Future<bool> _isWordlistBoxEmpty(Box wordBox, String key) async {
    final WordList? words = await wordBox.get(key);
    return words?.words.isEmpty ?? true;
  }

  Future<bool> checkBoxEmpty({required bool isEn, required int length}) async {
    final String key = _chooseKey(length: length);
    return await _isWordlistBoxEmpty(isEn ? _enWordsBox : _uaWordsBox, key);
  }

  Future<void> fillWords({required bool isEn, required int length, required WordList words}) async {
    final String key = _chooseKey(length: length);
    return await _putWordlistToBox(isEn ? _enWordsBox : _uaWordsBox, key, words);
  }

  Future<void> _putWordlistToBox(Box wordBox, String key, WordList words) async {
    return await wordBox.put(key, words);
  }

  Future<String> getFromBox(Box wordBox, String key) async {
    final WordList list = await wordBox.get(key);
    final word = list.words.removeAt(0);
    await wordBox.put(key, list);
    return word;
  }

  Future<String> getWordlistFromBox({required int length, required bool isEn}) async {
    final String key = _chooseKey(length: length);
    return await getFromBox(isEn ? _enWordsBox : _uaWordsBox, key);
  }

  String _chooseKey({required int length}) {
    switch (length) {
      case 4:
        return _key4Letters;
      case 5:
        return _key5Letters;
      case 6:
        return _key6Letters;
      default:
        return _key4Letters;
    }
  }
}
