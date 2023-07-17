part of 'game_cubit.dart';

@immutable
abstract class GameState {}

class GameInitial extends GameState {}

class GameLoading extends GameState {}

class GameReady extends GameState {}

class GameGuessMade extends GameState {}

class GameFailed extends GameState {
  final String? error;

  GameFailed(this.error);
}
