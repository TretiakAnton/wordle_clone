import 'package:wordle_clone/domain/model/guess_options.dart';

class GuessesResult {
  List<List<GuessOptions>> result = [];

  addResult(List<GuessOptions> newResult) {
    result.add(newResult);
  }
}
