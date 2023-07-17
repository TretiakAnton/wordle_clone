import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/domain/model/guesses_result.dart';
import 'package:wordle_clone/domain/use_cases/game_use_case/game_use_case.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameInitial()) {
    _getSecretWord();
  }

  final GameUseCase _useCase = GameUseCase();

  GuessesResult get guessesResult => _useCase.result;

  int _guessesMade = 0;

  int get guessesMade => _guessesMade;

  void _incrementGuessesMade() {
    _guessesMade = _guessesMade += 1;
  }

  void guess(String word) async {
    emit(GameLoading());
    final guessResult = _useCase.makeGuess(guess: word);
    if (guessResult) {
      _incrementGuessesMade();
      emit(GameGuessMade());
    } else {
      emit(GameFailed('error'));
    }
  }

  Future<void> _getSecretWord() async {
    emit(GameLoading());
    await _useCase.getSecretWord();
    emit(GameReady());
  }
}
