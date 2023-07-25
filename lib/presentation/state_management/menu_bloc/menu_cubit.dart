import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/domain/use_cases/menu_use_case/menu_use_case.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(MenuInitial()) {
    checkWords();
  }

  final MenuUseCase _useCase = MenuUseCase();

  bool _isWordsLoaded = false;

  int? get numberOfLetters => _useCase.numberOfLetters;

  bool get isWordsLoaded => _isWordsLoaded;

  set numberOfLetters(int? value) {
    ///only allowed length of words
    assert(value == 4 || value == 5 || value == 6 || value == null);
    _useCase.numberOfLetters = value;
    emit(MenuLettersSelected());
  }

  bool isSelected(int value) {
    return value == _useCase.numberOfLetters;
  }

  Future<void> checkWords() async {
    emit(MenuInProgress());
    _isWordsLoaded = false;
    final MenuState result = await _useCase.checkWords();
    if (result is MenuCompleted) {
      _isWordsLoaded = true;
    }
    emit(result);
  }
}
