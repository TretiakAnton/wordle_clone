import 'dart:ui';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:wordle_clone/data/entity/word_list.dart';
import 'package:wordle_clone/domain/model/wordle_user.dart';

class BoxManager {
  static final BoxManager _instance = BoxManager._internal();
  final _KeyManager _keyManager = _KeyManager();

  bool _isInited = false;
  late Box _enWordsBox;
  late Box _uaWordsBox;
  late Box _settingsBox;
  late Box _credentialsBox;

  factory BoxManager() {
    return _instance;
  }

  BoxManager._internal();

  Future<void> init() async {
    if (_isInited) {
      return;
    }
    _uaWordsBox = await Hive.openBox('uaWordsBox');
    _enWordsBox = await Hive.openBox('enWordsBox');
    _settingsBox = await Hive.openBox('settingsBox');
    _credentialsBox = await Hive.openBox('credentialsBox');
    await _initLanguages();
    _isInited = true;
  }

  WordleUser? getCurrentUser() {
    return _credentialsBox.get(_keyManager.keyCurrentUser);
  }

  Future<void> saveUser(WordleUser user) async {
    return await _credentialsBox.put(_keyManager.keyCurrentUser, user);
  }

  Future<void> deleteCurrentUser() async {
    return await _credentialsBox.delete(_keyManager.keyCurrentUser);
  }

  Future<void> _initLanguages() async {
    const Locale uaLang = Locale('uk', 'UA');
    const Locale enLang = Locale('en', 'GB');
    await _settingsBox.put(_keyManager.keyWordsLanguage, [enLang, uaLang]);
  }

  Future<bool> _isWordlistBoxEmpty(Box wordBox, String key) async {
    final WordList? words = await wordBox.get(key);
    return words?.words.isEmpty ?? true;
  }

  Future<bool> checkBoxEmpty({required bool isEn, required int length}) async {
    final String key = _chooseWordsLengthKey(length: length);
    return await _isWordlistBoxEmpty(isEn ? _enWordsBox : _uaWordsBox, key);
  }

  Future<void> fillWords({required bool isEn, required int length, required WordList words}) async {
    final String key = _chooseWordsLengthKey(length: length);
    return await _putWordlistToBox(isEn ? _enWordsBox : _uaWordsBox, key, words);
  }

  Future<void> _putWordlistToBox(Box wordBox, String key, WordList words) async {
    return await wordBox.put(key, words);
  }

  Future<String> getFromWordsBox(Box wordBox, String key) async {
    final WordList list = await wordBox.get(key);
    final word = list.words.removeAt(0);
    await wordBox.put(key, list);
    return word;
  }

  Future<String> getWordlistFromBox({required int length, required bool isEn}) async {
    final String key = _chooseWordsLengthKey(length: length);
    return await getFromWordsBox(isEn ? _enWordsBox : _uaWordsBox, key);
  }

  String _chooseWordsLengthKey({required int length}) {
    switch (length) {
      case 4:
        return _keyManager.key4Letters;
      case 5:
        return _keyManager.key5Letters;
      case 6:
        return _keyManager.key6Letters;
      default:
        return _keyManager.key4Letters;
    }
  }

  Locale getSelectedWordsLanguage() {
    Locale? selectedLocale = _settingsBox.get(_keyManager.keySelectedWordsLanguage);
    if (selectedLocale == null) {
      selectedLocale = _settingsBox.get(_keyManager.keyWordsLanguage).first;
      _settingsBox.put(_keyManager.keySelectedWordsLanguage, selectedLocale);
    }
    return selectedLocale!;
  }

  List<Locale> getAvailableWordsLanguage() {
    return _settingsBox.get(_keyManager.keyWordsLanguage);
  }

  Future<void> setWordsLanguage(Locale selected) async {
    return await _settingsBox.put(_keyManager.keyWordsLanguage, selected);
  }
}

class _KeyManager {
  final String key4Letters = '4Letters';
  final String key5Letters = '5Letters';
  final String key6Letters = '6Letters';
  final String keyCurrentUser = 'currentUser';
  final String keyWordsLanguage = 'wordsLanguage';
  final String keySelectedWordsLanguage = 'selectedWordsLanguage';
}
