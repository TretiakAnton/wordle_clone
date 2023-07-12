import 'package:wordle_clone/data/entity/requests/menu/word_refill_request.dart';
import 'package:wordle_clone/data/entity/responses/check_words_response.dart';

class MenuTranslator {
  WordRefillRequest checkWordResponseToWordsRefillRequest(
      {required CheckWordsResponse response}) {
    return WordRefillRequest(
      is4letterWordsNeedRefill: response.is4LettersWordsEmpty,
      is5letterWordsNeedRefill: response.is5LettersWordsEmpty,
      is6letterWordsNeedRefill: response.is6LettersWordsEmpty,
    );
  }
}
