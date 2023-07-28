import 'package:flutter/services.dart';
import 'package:wordle_clone/data/entity/requests/menu/word_refill_request.dart';

class UaWordsRequest {
  final List<WordRefillRequest> requests;
  final RootIsolateToken rootIsolateToken;

  UaWordsRequest(this.requests, this.rootIsolateToken);
}