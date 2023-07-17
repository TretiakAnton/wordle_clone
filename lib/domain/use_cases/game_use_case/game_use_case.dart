import 'package:wordle_clone/data/repository/game_repository.dart';
import 'package:wordle_clone/domain/model/guesses_result.dart';
import 'package:wordle_clone/domain/use_cases/menu_use_case/menu_use_case.dart';

class GameUseCase {
  final GameRepository _repository = GameRepository();
  String _secretWord = '';
  final GuessesResult result = GuessesResult();

  bool makeGuess({required String guess}) {
    bool isSuccess = false;
    final guessResult =
        _repository.makeGuess(guess: guess, secretWord: _secretWord);
    if (guessResult.isNotEmpty) {
      result.addResult(guessResult);
      isSuccess = true;
    }
    return isSuccess;
  }

  Future<void> getSecretWord() async {
    final word =
        await _repository.getSecretWord(length: MenuUseCase().numberOfLetters!);
    _secretWord = word;
  }
}
