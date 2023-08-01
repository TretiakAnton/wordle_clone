import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:wordle_clone/core/constants.dart';
import 'package:http/http.dart' as http;
import 'package:wordle_clone/firebase_options.dart';

class GameDataSource {
  Map<int, String> uaWordKeys = {
    4: 'word4letters',
    5: 'word5letters',
    6: 'word6letters',
  };
  final String _baseUrl = 'https://api.wordnik.com/v4/word.json/';

  Future<bool> checkValidityOfWord({required String word, required bool isEn}) async {
    if (isEn) {
      return await _checkEnWord(word);
    } else {
      return await _checkUaWord(word);
    }
  }

  Future<bool> _checkEnWord(String word) async {
    final request = '/frequency?api_key=$apiKey';
    try {
      final uri = Uri.parse('$_baseUrl$word$request');
      final response = await http.get(uri);
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _checkUaWord(String word) async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    }
    final db = FirebaseFirestore.instance;
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection(uaWordKeys[word.length]!).where('word', isEqualTo: word).get();
    return snapshot.docs.isNotEmpty;
  }
}
