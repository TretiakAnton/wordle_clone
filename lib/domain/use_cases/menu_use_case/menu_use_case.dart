import 'package:wordle_clone/data/entity/requests/menu/word_refill_request.dart';
import 'package:wordle_clone/data/entity/responses/check_words_response.dart';
import 'package:wordle_clone/data/entity/responses/get_words_response.dart';
import 'package:wordle_clone/data/repository/menu_repository.dart';
import 'package:wordle_clone/domain/translator/menu_translator/menu_translator.dart';
import 'package:wordle_clone/presentation/state_management/menu_bloc/menu_cubit.dart';

class MenuUseCase {
  final MenuRepository _repository = MenuRepository();
  final MenuTranslator _translator = MenuTranslator();
  int? _numberOfLetters;

  static final MenuUseCase _instance = MenuUseCase._internal();

  factory MenuUseCase() {
    return _instance;
  }

  MenuUseCase._internal();

  int? get numberOfLetters => _numberOfLetters;

  set numberOfLetters(int? value) {
    ///only allowed length of words
    assert(value == 4 || value == 5 || value == 6 || value == null);
    _numberOfLetters = value;
  }

  Future<MenuState> checkWords() async {
    MenuState result = MenuInitial();
    final response = await _repository.checkWords();
    await response.fold((failure) async {
      return result = MenuFailed(failure.errorMessage);
    }, (checkWordResponse) async {
      if (checkWordResponse.any((element) => element.isEmpty)) {
        result = await _refillWords(checkWordResponse: checkWordResponse);
      } else {
        result = MenuCompleted();
      }
    });
    return result;
  }

  Future<MenuState> _refillWords({required List<CheckWordsResponse> checkWordResponse}) async {
    MenuState result = MenuInitial();
    final List<WordRefillRequest> refillRequests =
        _translator.checkWordResponseToWordsRefillRequest(response: checkWordResponse);
    final wordsResponse = await _repository.refillWords(refillRequests: refillRequests);
    await wordsResponse.fold((failure) async {
      return result = MenuFailed(failure.errorMessage);
    }, (wordsSource) async {
      await _writeWordsToStorage(source: wordsSource);
      result = MenuCompleted();
    });
    return result;
  }

  Future<void> _writeWordsToStorage({required GetWordsResponse source}) async {
    final List<bool Function(int?)> checkList = [
      (int? value) => source.enWords?.keys.contains(value) ?? false,
      (int? value) => source.uaWords?.keys.contains(value) ?? false,
    ];

    for (int index = 4; index <= 6; index++) {
      for (int i = 0; i < checkList.length; i++) {
        if (checkList[i](index)) {
          final Map<int, List<String>>? wordsMap = i == 0 ? source.enWords : source.uaWords;
          if (wordsMap != null) {
            final List<String> filteredWords = _translator.filterWordsResponse(wordsMap[index]!);
            await _repository.setWordsList(
              isEn: i == 0,
              wordLength: index,
              words: _translator.getWordsResponseToWordList(response: filteredWords),
            );
          }
        }
      }
    }
  }
}
