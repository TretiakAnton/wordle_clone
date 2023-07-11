import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/core/navigation/routes.dart';
import 'package:wordle_clone/presentation/state_management/game_bloc/game_cubit.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () =>
                  _navigateToGame(context: context, numberOfLetters: 4),
              child: const Text('4 letters'),
            ),
            OutlinedButton(
              onPressed: () =>
                  _navigateToGame(context: context, numberOfLetters: 5),
              child: const Text('5 letters'),
            ),
            OutlinedButton(
              onPressed: () =>
                  _navigateToGame(context: context, numberOfLetters: 6),
              child: const Text('6 letters'),
            ),
          ],
        ),
      ),
    );
  }

  _navigateToGame({
    required BuildContext context,
    required int numberOfLetters,
  }) {
    final bloc = context.read<GameCubit>();
    bloc.numberOfLetters = numberOfLetters;
    context.router.pushNamed(Routes.gameScreen);
  }
}
