import 'package:wordle_clone/data/entity/requests/menu/word_refill_request.dart';
import 'package:wordle_clone/data/entity/responses/check_words_response.dart';
import 'package:wordle_clone/data/entity/word_list.dart';

class MenuTranslator {
  List<WordRefillRequest> checkWordResponseToWordsRefillRequest({required List<CheckWordsResponse> response}) {
    List<WordRefillRequest> result = [];

    for (CheckWordsResponse element in response) {
      if (element.isEmpty) {
        result.add(WordRefillRequest(
          isEn: element.isEn,
          wordLength: element.wordLength,
        ));
      }
    }

    return result;
  }

  WordList getWordsResponseToWordList({required List<String> response}) {
    return WordList(name: 'wordsList', words: response);
  }

  List<String> filterWordsResponse(List<String> input) {
    List<String> result = [];
    for (var element in input) {
      if (!element.contains(RegExp(r"[A-Z.']"))) {
        result.add(element);
      }
    }
    return result;
  }
}
