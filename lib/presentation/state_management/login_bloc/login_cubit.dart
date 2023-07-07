import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/domain/model/login_email_request.dart';
import 'package:wordle_clone/domain/use_cases/auth_use_case/auth_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final AuthUseCase _useCase = AuthUseCase();

  Future<void> googleLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginInProgress());

    final state = await _useCase.login(
      model: LoginEmailRequestModel(
        email: email,
        password: password,
      ),
    );
    emit(state);
  }
}
