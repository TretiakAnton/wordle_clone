import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/domain/model/login_email_request.dart';
import 'package:wordle_clone/domain/use_cases/auth_use_case/auth_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final AuthUseCase _useCase = AuthUseCase();

  Future<void> emailPasswordLogin({
    required String email,
    required String password,
  }) async {
    if (state is LoginInProgress) {
      return;
    }
    emit(LoginInProgress());
    final resultState = await _useCase.emailPasswordLogin(
      model: EmailPasswordRequestModel(
        email: email,
        password: password,
      ),
    );
    emit(resultState);
  }
}
