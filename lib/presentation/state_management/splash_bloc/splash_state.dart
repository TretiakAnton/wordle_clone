part of 'splash_cubit.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashInProgress extends SplashState {}

class SplashCompleted extends SplashState {
  final bool canSkipLogin;

  SplashCompleted({required this.canSkipLogin});
}

class SplashFailed extends SplashState {
  final String? error;

  SplashFailed(this.error);
}
