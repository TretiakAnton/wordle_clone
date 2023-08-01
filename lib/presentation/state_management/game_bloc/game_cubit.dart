import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/domain/model/game_result.dart';
import 'package:wordle_clone/domain/model/guesses_result.dart';
import 'package:wordle_clone/domain/use_cases/game_use_case/game_use_case.dart';
import 'package:wordle_clone/presentation/state_management/menu_bloc/menu_cubit.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameInitial());

  final GameUseCase _useCase = GameUseCase();

  GuessesResult get guessesResult => _useCase.result;

  int _guessesMade = 0;

  int get guessesMade => _guessesMade;

  int get numberOfLetters => _useCase.secretWord?.length ?? 4;

  void _incrementGuessesMade() {
    _guessesMade = _guessesMade += 1;
  }

  void guess(String word) async {
    emit(GameLoading());
    final guessResult = _useCase.makeGuess(guess: word);
    if (guessResult) {
      _incrementGuessesMade();
      bool? gameResultIsWin = _useCase.checkWinOrLoose(_guessesMade);
      if (gameResultIsWin == null) {
        emit(GameGuessMade());
      } else if (gameResultIsWin) {
        emit(
          GameWin(
            GameResult(
              guessesMade: guessesMade,
              word: _useCase.secretWord!,
            ),
          ),
        );
      } else {
        emit(
          GameLoose(
            GameResult(
              guessesMade: guessesMade,
              word: _useCase.secretWord!,
            ),
          ),
        );
      }
    } else {
      emit(GameFailed('error'));
    }
  }

  Future<void> getSecretWord({required Locale locale}) async {
    emit(GameLoading());
    _guessesMade = 0;
    await _useCase.getSecretWord(isEn: locale.languageCode == 'en');
    emit(GameReady());
  }

  void clean(BuildContext context) {
    _useCase.cleanWord();
    context.read<MenuCubit>().numberOfLetters = null;
    context.read<MenuCubit>().checkWords();
  }
}
