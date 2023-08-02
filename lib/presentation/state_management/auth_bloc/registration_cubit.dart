import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/domain/model/login_email_request.dart';
import 'package:wordle_clone/domain/use_cases/auth_use_case/auth_use_case.dart';
import 'package:wordle_clone/presentation/state_management/auth_bloc/auth_state.dart';
import 'package:wordle_clone/presentation/view/widgets/snackbars.dart';


class RegistrationCubit extends Cubit<AuthState> {
  RegistrationCubit() : super(AuthInitial());

  final AuthUseCase _useCase = AuthUseCase();

  Future<void> emailPasswordLogin({
    required String email,
    required String password,
  }) async {
    if (state is AuthInProgress) {
      return;
    }
    emit(AuthInProgress());

    final resultState = await _useCase.emailPasswordRegister(
      model: EmailPasswordRequestModel(
        email: email,
        password: password,
      ),
    );
    if (resultState is AuthFailed) {
      OrdinarySnackbar().showSnackBar(label: resultState.error ?? 'Error');
    }
    emit(resultState);
  }
}
