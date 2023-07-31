import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loggy/loggy.dart';
import 'package:wordle_clone/data/entity/locale.g.dart';
import 'package:wordle_clone/data/entity/word_list.dart';
import 'package:wordle_clone/firebase_options.dart';
import 'package:wordle_clone/localization_widget.dart';
import 'package:wordle_clone/wordle_app.dart';

Future<void> main() async {
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await _initHive();
  runApp(EasyLocalizationWidget(widget: WordleApp()));
}

_initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(WordListAdapter());
  Hive.registerAdapter(LocaleAdapter());
}
