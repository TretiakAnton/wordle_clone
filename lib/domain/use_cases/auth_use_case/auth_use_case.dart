import 'package:wordle_clone/data/repository/auth_repository.dart';
import 'package:wordle_clone/domain/model/login_email_request.dart';
import 'package:wordle_clone/domain/model/wordle_user.dart';
import 'package:wordle_clone/domain/translator/auth_translator/auth_translator.dart';
import 'package:wordle_clone/presentation/state_management/auth_bloc/auth_state.dart';

class AuthUseCase {
  final AuthRepository _repository = AuthRepository();
  final AuthTranslator _translator = AuthTranslator();

  Future<AuthState> emailPasswordLogin({required EmailPasswordRequestModel model}) async {
    AuthState result = AuthInProgress();
    final entity = _translator.emailPasswordRequestModelToEntity(model: model);
    final response = await _repository.emailPasswordLogin(request: entity);
    await response.fold((failure) {
      result = AuthFailed(failure.errorMessage);
    }, (register) async {
      final user = _translator.userCredentialToUser(credential: register);
      result = await _saveUser(user);
    });
    return result;
  }

  Future<AuthState> emailPasswordRegister({required EmailPasswordRequestModel model}) async {
    AuthState result = AuthInProgress();
    final entity = _translator.emailPasswordRequestModelToEntity(model: model);
    final response = await _repository.emailPasswordRegistration(request: entity);
    await response.fold((failure) {
      result = AuthFailed(failure.errorMessage);
    }, (register) async {
      final user = _translator.userCredentialToUser(credential: register);
      result = await _saveUser(user);
    });
    return result;
  }

  Future<AuthState> _saveUser(WordleUser user) async {
    AuthState result = AuthInProgress();
    final saveResult = await _repository.saveUser(user: user);
    saveResult.fold(
      (l) => result = AuthFailed(l.errorMessage),
      (r) => result = AuthCompleted(),
    );
    return result;
  }
}
