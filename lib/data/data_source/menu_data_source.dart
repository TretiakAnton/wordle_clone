import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:wordle_clone/data/entity/requests/menu/word_refill_request.dart';
import 'package:http/http.dart' as http;
import 'package:wordle_clone/data/entity/responses/get_words_response.dart';

class MenuDataSource {
  final String _baseUrl =
      'https://random-word-api.herokuapp.com/word?number=10&length=6';

  Future<void> refillWords({required WordRefillRequest request}) async {
    return await compute(_performWordsRefill, request);
  }

  Future<GetWordsResponse> _performWordsRefill(
      WordRefillRequest request) async {
    final response = await http.get(Uri.parse(_baseUrl));
    final json = jsonDecode(response.body);
    return GetWordsResponse.fromJson(json);
  }
}
