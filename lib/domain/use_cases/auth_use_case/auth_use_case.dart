import 'package:wordle_clone/data/repository/auth_repository.dart';
import 'package:wordle_clone/domain/model/login_email_request.dart';
import 'package:wordle_clone/domain/model/user.dart';
import 'package:wordle_clone/domain/translator/login_email_translator.dart';
import 'package:wordle_clone/presentation/state_management/login_bloc/login_cubit.dart';

class AuthUseCase {
  final AuthRepository _repository = AuthRepository();
  final LoginEmailTranslator _translator = LoginEmailTranslator();
  User? _user;

  Future<LoginState> emailPasswordLogin(
      {required LoginEmailRequestModel model}) async {
    LoginState result = LoginInProgress();
    final entity = _translator.loginEmailRequestModelToEntity(model: model);
    final response = await _repository.emailPasswordLogin(request: entity);
    response.fold((failure) {
      result = LoginFailed(failure.errorMessage);
    }, (register) {
      _user = _translator.userCredentialToUser(credential: register);
      result = LoginCompleted();
    });
    return result;
  }
}
