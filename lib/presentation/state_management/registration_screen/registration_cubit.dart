import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/domain/model/login_email_request.dart';
import 'package:wordle_clone/domain/use_cases/auth_use_case/auth_use_case.dart';
import 'package:wordle_clone/presentation/view/widgets/snackbars.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationInitial());

  final AuthUseCase _useCase = AuthUseCase();

  Future<void> emailPasswordLogin({
    required String email,
    required String password,
  }) async {
    if (state is RegistrationInProgress) {
      return;
    }
    emit(RegistrationInProgress());

    final resultState = await _useCase.emailPasswordRegister(
      model: EmailPasswordRequestModel(
        email: email,
        password: password,
      ),
    );
    if (resultState is RegistrationFailed) {
      OrdinarySnackbar().showSnackBar(label: resultState.error ?? 'Error');
    }
    emit(resultState);
  }
}
