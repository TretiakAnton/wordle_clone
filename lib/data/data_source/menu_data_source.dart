import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:wordle_clone/data/entity/requests/menu/word_refill_request.dart';
import 'package:http/http.dart' as http;
import 'package:wordle_clone/data/entity/responses/get_words_response.dart';

class MenuDataSource {
  final String _baseUrl =
      'https://api.wordnik.com/v4/words.json/randomWords?api_key=w01qji5soq8nxk76xt4033rteyol99vuqd01uqngotia83wi0&partOfSpeech=noun&hasExamples=true';

  Future<Map<int, GetWordsResponse>> refillWords({required WordRefillRequest request}) async {
    final Map<int, GetWordsResponse> result = await compute(_performWordsRefill, request);
    return result;
  }

  Future<Map<int, GetWordsResponse>> _performWordsRefill(WordRefillRequest request) async {
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
      final length = lengthOfWordsToRefill[index];
      const amount = 30;
      final response = await http.get(Uri.parse('$_baseUrl&minLength=$length&maxLength=$length&limit=$amount'));
      final json = jsonDecode(response.body);
      result[lengthOfWordsToRefill[index]] = GetWordsResponse.fromJson(json);
    }
    return result;
  }
}
