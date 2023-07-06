import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wordle_clone/firebase_options.dart';
import 'package:wordle_clone/wordle_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const WordleApp());
}



