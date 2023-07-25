import 'package:wordle_clone/data/repository/auth_repository.dart';
import 'package:wordle_clone/domain/model/login_email_request.dart';
import 'package:wordle_clone/domain/model/user.dart';
import 'package:wordle_clone/domain/translator/auth_translator/login_email_translator.dart';
import 'package:wordle_clone/presentation/state_management/login_bloc/login_cubit.dart';
import 'package:wordle_clone/presentation/state_management/registration_screen/registration_cubit.dart';

class AuthUseCase {
  final AuthRepository _repository = AuthRepository();
  final LoginEmailTranslator _translator = LoginEmailTranslator();
  User? _user;

  Future<LoginState> emailPasswordLogin({required EmailPasswordRequestModel model}) async {
    LoginState result = LoginInProgress();
    final entity = _translator.emailPasswordRequestModelToEntity(model: model);
    final response = await _repository.emailPasswordLogin(request: entity);
    response.fold((failure) {
      result = LoginFailed(failure.errorMessage);
    }, (register) {
      _user = _translator.userCredentialToUser(credential: register);
      result = LoginCompleted();
    });
    return result;
  }

  Future<RegistrationState> emailPasswordRegister({required EmailPasswordRequestModel model})async {
    RegistrationState result = RegistrationInProgress();
    final entity = _translator.emailPasswordRequestModelToEntity(model: model);
    final response = await _repository.emailPasswordRegistration(request: entity);
    response.fold((failure) {
      result = RegistrationFailed(failure.errorMessage);
    }, (register) {
      _user = _translator.userCredentialToUser(credential: register);
      result = RegistrationCompleted();
    });
    return result;
  }
}
