import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';
import 'package:wordle_clone/firebase_options.dart';
import 'package:wordle_clone/wordle_app.dart';

Future<void> main() async {
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(WordleApp());
}
