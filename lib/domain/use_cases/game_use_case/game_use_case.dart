import 'package:wordle_clone/data/repository/game_repository.dart';
import 'package:wordle_clone/domain/model/guess_options.dart';
import 'package:wordle_clone/domain/use_cases/menu_use_case/menu_use_case.dart';

class GameUseCase {
  GameUseCase() {
    getSecretWord(length: MenuUseCase().numberOfLetters!);
  }

  final GameRepository _repository = GameRepository();
  final String secretWord = '';

  List<GuessOptions> makeGuess({required String guess}) {
    return _repository.makeGuess(guess: guess, secretWord: secretWord);
  }

  Future<void> getSecretWord({required int length}) async {
    await _repository.getSecretWord(length: length);
  }
}
