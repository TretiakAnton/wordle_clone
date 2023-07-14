import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/core/constants.dart';
import 'package:wordle_clone/presentation/state_management/game_bloc/game_cubit.dart';
import 'package:wordle_clone/presentation/state_management/menu_bloc/menu_cubit.dart';
import 'package:wordle_clone/presentation/view/widgets/letters_field.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String _wordGuess = '';
  List<TextEditingController> textEditingControllers = [];

  @override
  Widget build(BuildContext context) {
    final gameBloc = context.read<GameCubit>();
    final menuBloc = context.read<MenuCubit>();
    if (textEditingControllers.isEmpty) {
      _fillControllers(length: menuBloc.numberOfLetters! + 1);
    }
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<GameCubit, GameState>(
          builder: (context, state) {
            return Column(
              children: [
                const Spacer(),
                Flexible(
                  fit: FlexFit.loose,
                  flex: menuBloc.numberOfLetters!,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: menuBloc.numberOfLetters! + 1,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              horizontalPadding(context: context, pixels: 25),
                          vertical:
                              verticalPadding(context: context, pixels: 0),
                        ),
                        child: LettersField(
                          enabled: gameBloc.guessesMade == index,
                          textController: textEditingControllers[index],
                          defaultBoxSize:
                              horizontalPadding(context: context, pixels: 40),
                          onChange: (String word) => setState(() {
                            _wordGuess = word;
                          }),
                        ),
                      );
                    },
                  ),
                ),
                OutlinedButton(
                  onPressed: () async {
                    if (_wordGuess.length == menuBloc.numberOfLetters) {
                      FocusScope.of(context).unfocus();
                      gameBloc.guess(_wordGuess);
                    }
                  },
                  child: const Text('Guess'),
                ),
                const Spacer(),
              ],
            );
          },
        ),
      ),
    );
  }

  void _fillControllers({required int length}) {
    for (int index = 0; index < length; index++) {
      textEditingControllers.add(TextEditingController());
    }
  }
}
