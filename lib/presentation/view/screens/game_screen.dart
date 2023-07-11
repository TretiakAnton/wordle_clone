import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/core/constants.dart';
import 'package:wordle_clone/presentation/state_management/game_bloc/game_cubit.dart';
import 'package:wordle_clone/presentation/view/widgets/letters_field.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String _word = '';

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<GameCubit>();

    return SafeArea(
      child: BlocBuilder<GameCubit, GameState>(
        builder: (context, state) {
          return Column(
            children: [
              ListView.builder(
                itemCount: bloc.numbersOfGuesses,
                itemBuilder: (BuildContext context, int index) {
                  return LettersField(
                    enabled: bloc.guessesMade == index,
                    defaultBoxSize:
                        horizontalPadding(context: context, pixels: 40),
                    onChange: (String word) => setState(() {
                      _word = word;
                    }),
                  );
                },
              ),
              OutlinedButton(
                onPressed: () async {
                  if (_word.length == bloc.numberOfLetters) {
                    await bloc.guess(_word);
                  }
                },
                child: const Text('Guess'),
              ),
            ],
          );
        },
      ),
    );
  }
}
