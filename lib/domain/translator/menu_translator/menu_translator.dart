import 'package:wordle_clone/data/entity/requests/menu/word_refill_request.dart';
import 'package:wordle_clone/data/entity/responses/check_words_response.dart';
import 'package:wordle_clone/data/entity/responses/get_words_response.dart';
import 'package:wordle_clone/data/entity/word_list.dart';

class MenuTranslator {
  WordRefillRequest checkWordResponseToWordsRefillRequest({required CheckWordsResponse response}) {
    return WordRefillRequest(
      is4letterWordsNeedRefill: response.is4LettersWordsEmpty,
      is5letterWordsNeedRefill: response.is5LettersWordsEmpty,
      is6letterWordsNeedRefill: response.is6LettersWordsEmpty,
    );
  }

  WordList getWordsResponseToWordList({required GetWordsResponse response}) {
    return WordList(name: 'wordsList', words: response.words);
  }

  GetWordsResponse filterWordsResponse(GetWordsResponse getWordsResponse) {
    List<String> words = [];
    for (var element in getWordsResponse.words) {
      if (!element.contains(RegExp(r'[A-Z.]'))) {
        words.add(element);
      }
    }
    return GetWordsResponse(words: words);
  }
}
