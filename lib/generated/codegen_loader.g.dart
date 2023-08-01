// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en_GB = {
  "english": "English",
  "ukrainian": "Ukrainian",
  "version": "version",
  "confirm": "Confirm",
  "language": "Language",
  "guess": "Guess",
  "words_language": "Words language",
  "dont_have_an_account": "Don't have an account? ",
  "create_it_now": "Create it now!",
  "you_win": "You win",
  "you_loose": "You loose",
  "you_guess_word": "You guess word",
  "you_dont_guess_word": "You don't guess word",
  "start": "Start",
  "wait_until_game_is_loaded": "Wait until game is loaded",
  "guesses": {
    "one": "with {} guess",
    "two": "with {} guesses",
    "few": "with {} guesses",
    "many": "with {} guesses",
    "other": "with {} guesses"
  },
  "letter": {
    "zero": "{} letters",
    "one": "{} letter",
    "two": "{} letters",
    "few": "{} letters",
    "many": "{} letters",
    "other": "{} letters"
  },
  "close": "Close",
  "register": "Register",
  "login": "Login"
};
static const Map<String,dynamic> uk_UA = {
  "english": "Англійська",
  "ukrainian": "Українська",
  "version": "версія",
  "confirm": "Підтвердити",
  "language": "Мова",
  "guess": "Вгадати",
  "words_language": "Мова слів",
  "dont_have_an_account": "Не маєте аккаунту? ",
  "create_it_now": "Створіть зараз!",
  "you_win": "Ви виграли",
  "you_loose": "Ви програли",
  "you_guess_word": "Ви вгадали слово",
  "you_dont_guess_word": "Ви не вгадали слово",
  "start": "Розпочати",
  "wait_until_game_is_loaded": "Зачекайте доки гра завантажиться",
  "guesses": {
    "one": "використавши {} спробу",
    "two": "використавши {} спроби",
    "few": "використавши {} спроби",
    "many": "використавши {} спроб",
    "other": "використавши {} спроб"
  },
  "letter": {
    "one": "{} буква",
    "two": "{} букви",
    "few": "{} букви",
    "many": "{} букв",
    "other": "{} букв"
  },
  "close": "Закрити",
  "register": "Регістрація",
  "login": "Логін"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en_GB": en_GB, "uk_UA": uk_UA};
}
