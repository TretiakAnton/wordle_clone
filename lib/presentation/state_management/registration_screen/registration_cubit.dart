import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/domain/model/login_email_request.dart';
import 'package:wordle_clone/domain/use_cases/auth_use_case/auth_use_case.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationInitial());

  final AuthUseCase _useCase = AuthUseCase();

  Future<void> emailPasswordLogin({
    required String email,
    required String password,
  }) async {
    emit(RegistrationInProgress());

    final state = await _useCase.emailPasswordRegister(
      model: EmailPasswordRequestModel(
        email: email,
        password: password,
      ),
    );
    emit(state);
  }
}
