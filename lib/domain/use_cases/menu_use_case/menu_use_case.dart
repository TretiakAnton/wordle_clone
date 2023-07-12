import 'package:hive_flutter/hive_flutter.dart';
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
      result = MenuFailed(failure.errorMessage);
    }, (checkWordResponse) async {
      if (checkWordResponse.is4LettersWordsEmpty ||
          checkWordResponse.is5LettersWordsEmpty ||
          checkWordResponse.is6LettersWordsEmpty) {
        final refillRequest = _translator.checkWordResponseToWordsRefillRequest(
            response: checkWordResponse);
        await _repository.refillWords(refillRequest: refillRequest);
      }
    });
    return result;
  }
}
