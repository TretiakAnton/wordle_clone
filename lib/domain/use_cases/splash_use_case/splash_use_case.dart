import 'package:wordle_clone/data/repository/splash_repository.dart';
import 'package:wordle_clone/domain/model/wordle_user.dart';


class SplashUseCase {
  final SplashRepository _repository = SplashRepository();

  bool checkSavedUser() {
    final WordleUser? user = _getUser();
    return user != null;
  }

  WordleUser? _getUser() {
    final response = _repository.getUser();
    WordleUser? user;
    response.fold((failure) {}, (userResponse) {
      user = userResponse;
    });
    return user;
  }
}
