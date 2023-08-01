import 'package:wordle_clone/data/repository/game_repository.dart';
import 'package:wordle_clone/domain/model/guess_options.dart';
import 'package:wordle_clone/domain/model/guesses_result.dart';
import 'package:wordle_clone/domain/use_cases/menu_use_case/menu_use_case.dart';

class GameUseCase {
  final GameRepository _repository = GameRepository();
  String? secretWord;
  final GuessesResult result = GuessesResult();

  bool makeGuess({required String guess}) {
    bool isSuccess = false;
    final guessResult = _repository.makeGuess(guess: guess, secretWord: secretWord ?? '');
    if (guessResult.isNotEmpty) {
      result.addResult(guessResult);
      isSuccess = true;
    }
    return isSuccess;
  }

  bool? checkWinOrLoose(int guessesMade) {
    bool isWin = true;
    final List<GuessOptions>? guessResult = result.result.last;

    ///check for win
    for (GuessOptions element in guessResult!) {
      if (element != GuessOptions.rightLetterRightPosition) {
        isWin = false;
      }
    }
    if (isWin) {
      return true;
    }

    ///check for loose
    if (guessesMade == secretWord!.length + 1) {
      return false;
    }
    return null;
  }

  Future<void> getSecretWord({required bool isEn}) async {
    secretWord = '';
    final word = await _repository.getSecretWord(length: MenuUseCase().numberOfLetters!, isEn: isEn);
    secretWord = word;
  }

  void cleanWord() {
    secretWord = null;
    result.clear();
  }

  Future<bool> checkValidityOfWord({required String word, required bool isEn}) async {
    return await _repository.checkValidityOfWord(word: word, isEn: isEn);
  }
}
