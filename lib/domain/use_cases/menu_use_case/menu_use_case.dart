import 'package:wordle_clone/data/entity/responses/get_words_response.dart';
import 'package:wordle_clone/data/repository/menu_repository.dart';
import 'package:wordle_clone/domain/translator/menu_translator/menu_translator.dart';
import 'package:wordle_clone/presentation/state_management/menu_bloc/menu_cubit.dart';

class MenuUseCase {
  final MenuRepository _repository = MenuRepository();
  final MenuTranslator _translator = MenuTranslator();

  Future<MenuState> checkWords() async {
    MenuState result = MenuInitial();
    final response = await _repository.checkWords();
    response.fold((failure) {
      return result = MenuFailed(failure.errorMessage);
    }, (checkWordResponse) async {
      if (checkWordResponse.is4LettersWordsEmpty ||
          checkWordResponse.is5LettersWordsEmpty ||
          checkWordResponse.is6LettersWordsEmpty) {
        final refillRequest = _translator.checkWordResponseToWordsRefillRequest(
            response: checkWordResponse);
        final wordsResponse =
            await _repository.refillWords(refillRequest: refillRequest);
        wordsResponse.fold((failure) {
          return result = MenuFailed(failure.errorMessage);
        }, (wordsSource) async {
          await _writeWordsToStorage(source: wordsSource);
          result = MenuCompleted();
        });
      }
    });
    return result;
  }

  Future<void> _writeWordsToStorage(
      {required Map<int, GetWordsResponse> source}) async {
    for (int index = 4; index <= 6; index++) {
      if (source.keys.contains(index)) {
        await _repository.setWordsList(
          wordLength: index,
          words:
              _translator.getWordsResponseToWordList(response: source[index]!),
        );
      }
    }
  }
}
