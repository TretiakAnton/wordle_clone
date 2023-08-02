
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthInProgress extends AuthState {}

class AuthCompleted extends AuthState {}

class AuthFailed extends AuthState {
  final String? error;

  AuthFailed(this.error);
}
