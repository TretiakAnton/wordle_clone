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
  "unknown_word": "Unknown word",
  "try_another_one": "Try another one",
  "wait_until_game_is_loaded": "Wait until game is loaded",
  "welcome_to_wordle": "Welcome to Wordle!",
  "log_out": "Log out",
  "are_you_sure_you_want_to_log_out": "Are you sure you want to log out?",
  "yes": "Yes",
  "no": "No",
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
  "unknown_word": "Невідоме слово",
  "try_another_one": "Спробуйте інше",
  "wait_until_game_is_loaded": "Зачекайте доки гра завантажиться",
  "welcome_to_wordle": "Ласкаво просимо до Wordle!",
  "log_out": "Вийти",
  "are_you_sure_you_want_to_log_out": "Ви впевнені що хочете вийти?",
  "yes": "Так",
  "no": "Ні",
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
