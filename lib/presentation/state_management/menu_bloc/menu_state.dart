part of 'menu_cubit.dart';

@immutable
abstract class MenuState {}

class MenuInitial extends MenuState {}

class MenuInProgress extends MenuState {}

class MenuCompleted extends MenuState {}

class MenuFailed extends MenuState {
  final String? error;

  MenuFailed(this.error);
}
