import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/domain/model/login_email_request.dart';
import 'package:wordle_clone/domain/use_cases/auth_use_case/auth_use_case.dart';
import 'package:wordle_clone/domain/use_cases/menu_use_case/menu_use_case.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(MenuInitial());
  late int _numberOfLetters;

  int get numberOfLetters => _numberOfLetters;

  set numberOfLetters(int value) {
    ///only allowed length of words
    assert(value != 4 || value != 5 || value != 6);
    _numberOfLetters = value;
    emit(state);
  }

  bool isSelected(int value) {
    return value == _numberOfLetters;
  }

  final MenuUseCase _useCase = MenuUseCase();

  Future<void> checkWords() async {
    emit(MenuInProgress());
    await _useCase.checkWords();
  }
}
