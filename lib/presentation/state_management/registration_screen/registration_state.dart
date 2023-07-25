part of 'registration_cubit.dart';

@immutable
abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class RegistrationInProgress extends RegistrationState {}

class RegistrationCompleted extends RegistrationState {}

class RegistrationFailed extends RegistrationState {
  final String? error;

  RegistrationFailed(this.error);
}
