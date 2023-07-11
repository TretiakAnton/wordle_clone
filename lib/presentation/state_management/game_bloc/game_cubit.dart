import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/domain/model/login_email_request.dart';
import 'package:wordle_clone/domain/use_cases/auth_use_case/auth_use_case.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameInitial());

  late int _numberOfLetters;

  set numberOfLetters(int value) {
    ///only allowed length of words
    assert(value != 4 || value != 5 || value != 6);
    _numberOfLetters = value;
  }

  final AuthUseCase _useCase = AuthUseCase();
}
