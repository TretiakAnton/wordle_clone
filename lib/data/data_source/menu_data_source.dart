import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:wordle_clone/data/entity/requests/menu/word_refill_request.dart';
import 'package:http/http.dart' as http;
import 'package:wordle_clone/data/entity/requests/menu/ua_words_request.dart';
import 'package:wordle_clone/data/entity/responses/get_words_response.dart';
import 'package:wordle_clone/firebase_options.dart';

class MenuDataSource {
  final _amount = 30;

  final String _baseUrl =
      'https://api.wordnik.com/v4/words.json/randomWords?api_key=w01qji5soq8nxk76xt4033rteyol99vuqd01uqngotia83wi0&partOfSpeech=noun&hasExamples=true&hasDictionaryDef=true&isStrict=true';

  Future<GetWordsResponse> refillWords({required List<WordRefillRequest> requests}) async {
    final GetWordsResponse result = GetWordsResponse();
    if (requests.any((element) => element.isEn)) {
      final enWords = await compute(_refillEnWords, requests);
      result.enWords = enWords;
    }
    if (requests.any((element) => !element.isEn)) {
      RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
      final uaWords = await compute(_refillUaWords, UaWordsRequest(requests, rootIsolateToken));
      result.uaWords = uaWords;
    }
    return result;
  }

  Future<Map<int, List<String>>> _refillEnWords(List<WordRefillRequest> request) async {
    Map<int, List<String>> result = {};
    List<int> lengthOfWordsToRefill = [];
    if (request.any((element) => element.wordLength == 4)) {
      lengthOfWordsToRefill.add(4);
    }
    if (request.any((element) => element.wordLength == 5)) {
      lengthOfWordsToRefill.add(5);
    }
    if (request.any((element) => element.wordLength == 6)) {
      lengthOfWordsToRefill.add(6);
    }
    for (int index = 0; index < lengthOfWordsToRefill.length; index++) {
      final length = lengthOfWordsToRefill[index];
      final response = await http.get(Uri.parse('$_baseUrl&minLength=$length&maxLength=$length&limit=$_amount'));
      final words = _parseEnFromJson(response);
      result[lengthOfWordsToRefill[index]] = words;
    }
    return result;
  }

  List<String> _parseEnFromJson(http.Response response) {
    List<String> wordsList = [];
    List<dynamic> jsonList = jsonDecode(response.body);
    for (var item in jsonList) {
      String word = item['word'];
      wordsList.add(word);
    }
    return wordsList;
  }

  Future<Map<int, List<String>>> _refillUaWords(UaWordsRequest params) async {
    final request = params.requests;
    BackgroundIsolateBinaryMessenger.ensureInitialized(params.rootIsolateToken);
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    }
    final db = FirebaseFirestore.instance;
    Map<int, List<String>> result = {};
    Map<int, String> keys = {
      4: 'word4letters',
      5: 'word5letters',
      6: 'word6letters',
    };
    List<int> lengthOfWordsToRefill = [];
    if (request.any((element) => element.wordLength == 4)) {
      lengthOfWordsToRefill.add(4);
    }
    if (request.any((element) => element.wordLength == 5)) {
      lengthOfWordsToRefill.add(5);
    }
    if (request.any((element) => element.wordLength == 6)) {
      lengthOfWordsToRefill.add(6);
    }
    for (int index = 0; index < lengthOfWordsToRefill.length; index++) {
      List<String> words = [];
      final String key = keys[lengthOfWordsToRefill[index]]!;
      final QuerySnapshot<Map<String, dynamic>> collection = await db.collection(key).get();
      for (var doc in collection.docs) {
        String word = doc.data()['word'] as String;
        words.add(word);
      }
      result[lengthOfWordsToRefill[index]] = words;
    }
    return result;
  }
}
