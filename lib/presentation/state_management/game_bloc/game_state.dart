part of 'game_cubit.dart';

@immutable
abstract class GameState {}

class GameInitial extends GameState {}

class GameLoading extends GameState {}

class GameWordUnknown extends GameState {
  final String word;

  GameWordUnknown(this.word);
}

class GameReady extends GameState {}

class GameGuessMade extends GameState {}

class GameLoose extends GameState {
  final GameResult result;

  GameLoose(this.result);
}

class GameWin extends GameState {
  final GameResult result;

  GameWin(this.result);
}

class GameFailed extends GameState {
  final String? error;

  GameFailed(this.error);
}
