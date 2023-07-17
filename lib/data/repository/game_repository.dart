import 'package:wordle_clone/core/networking/repo_loggy.dart';
import 'package:wordle_clone/data/data_source/box_manager.dart';
import 'package:wordle_clone/domain/model/guess_options.dart';

class GameRepository with RepoLoggy {
  final BoxManager _boxManager = BoxManager();

  List<GuessOptions> makeGuess(
      {required String guess, required String secretWord}) {
    List<GuessOptions> results = [];
    for (int i = 0; i < guess.length; i++) {
      if (guess[i] == secretWord[i]) {
        results.add(GuessOptions.rightLetterRightPosition);
      } else if (secretWord.contains(guess[i])) {
        results.add(GuessOptions.rightLetterWrongPosition);
      } else {
        results.add(GuessOptions.wrongLetter);
      }
    }
    return results;
  }

  Future<String> getSecretWord({required int length}) async {
    return await _boxManager.getWord(length: length);
  }
}