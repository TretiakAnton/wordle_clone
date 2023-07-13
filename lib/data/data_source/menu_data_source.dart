import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:wordle_clone/data/entity/requests/menu/word_refill_request.dart';
import 'package:http/http.dart' as http;
import 'package:wordle_clone/data/entity/responses/get_words_response.dart';

//TODO move to https://api.wordnik.com/v4/words.json/randomWords
class MenuDataSource {
  final String _baseUrl =
      'https://random-word-api.herokuapp.com/word?number=100';

  Future<Map<int, GetWordsResponse>> refillWords(
      {required WordRefillRequest request}) async {
    return await compute(_performWordsRefill, request);
  }

  Future<Map<int, GetWordsResponse>> _performWordsRefill(
      WordRefillRequest request) async {
    Map<int, GetWordsResponse> result = {};
    List<int> lengthOfWordsToRefill = [];
    if (request.is4letterWordsNeedRefill) {
      lengthOfWordsToRefill.add(4);
    }
    if (request.is5letterWordsNeedRefill) {
      lengthOfWordsToRefill.add(5);
    }
    if (request.is6letterWordsNeedRefill) {
      lengthOfWordsToRefill.add(6);
    }
    for (int index = 0; index < lengthOfWordsToRefill.length; index++) {
      final response = await http.get(Uri.parse('$_baseUrl&length=5'));
      final json = jsonDecode(response.body);
      result[lengthOfWordsToRefill[index]] = GetWordsResponse.fromJson(json);
    }
    return result;
  }
}
