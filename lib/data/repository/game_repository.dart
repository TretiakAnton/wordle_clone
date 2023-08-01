import 'package:wordle_clone/core/networking/repo_loggy.dart';
import 'package:wordle_clone/data/data_source/box_manager.dart';
import 'package:wordle_clone/data/data_source/game_data_source.dart';
import 'package:wordle_clone/domain/model/guess_options.dart';

class GameRepository with RepoLoggy {
  final BoxManager _boxManager = BoxManager();
  final GameDataSource _dataSource = GameDataSource();

  List<GuessOptions> makeGuess({required String guess, required String secretWord}) {
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

  Future<String> getSecretWord({required int length, required bool isEn}) async {
    return await _boxManager.getWordlistFromBox(
      length: length,
      isEn: isEn,
    );
  }
  Future<bool> checkValidityOfWord({required String word, required bool isEn}) async {
    return await _dataSource.checkValidityOfWord(word: word, isEn: isEn);
  }
}
