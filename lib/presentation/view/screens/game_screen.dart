import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/core/constants.dart';
import 'package:wordle_clone/presentation/state_management/game_bloc/game_cubit.dart';
import 'package:wordle_clone/presentation/view/widgets/game_results_dialogs.dart';
import 'package:wordle_clone/presentation/view/widgets/letters_field.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<GameCubit>();

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: bloc.getSecretWord(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return _GameContent(
                bloc: bloc,
                textEditingControllers: _fillControllers(length: bloc.numberOfLetters + 1),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  List<TextEditingController> _fillControllers({required int length}) {
    List<TextEditingController> textEditingControllers = [];
    for (int index = 0; index < length; index++) {
      textEditingControllers.add(TextEditingController());
    }
    return textEditingControllers;
  }
}

class _GameContent extends StatefulWidget {
  final GameCubit bloc;
  final List<TextEditingController> textEditingControllers;

  const _GameContent({
    required this.bloc,
    required this.textEditingControllers,
    Key? key,
  }) : super(key: key);

  @override
  State<_GameContent> createState() => _GameContentState();
}

class _GameContentState extends State<_GameContent> {
  String _wordGuess = '';

  @override
  Widget build(BuildContext context) {
    final bloc = widget.bloc;

    return BlocConsumer<GameCubit, GameState>(
      listener: (context, state) {
        if (state is GameLoose) {
          showWinDialog(
            context: context,
            isWin: false,
            result: state.result,
            onExit: () => _onExit(),
          );
        } else if (state is GameWin) {
          showWinDialog(
            context: context,
            isWin: true,
            result: state.result,
            onExit: () => _onExit(),
          );
        }
      },
      builder: (context, state) {
        return Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            Flexible(
              fit: FlexFit.loose,
              flex: bloc.numberOfLetters,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: bloc.numberOfLetters + 1,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding(context: context, pixels: 15),
                      vertical: verticalPadding(context: context, pixels: 10),
                    ),
                    child: LettersField(
                      codeLength: bloc.numberOfLetters,
                      enabled: bloc.guessesMade == index,
                      textController: widget.textEditingControllers[index],
                      defaultBoxSize: horizontalPadding(context: context, pixels: 40),
                      onChange: (String word) => setState(() {
                        _wordGuess = word;
                      }),
                      guesses: bloc.guessesResult.result.length > index ? bloc.guessesResult.result[index] : null,
                    ),
                  );
                },
              ),
            ),
            OutlinedButton(
              onPressed: () async {
                if (_wordGuess.length == bloc.numberOfLetters) {
                  FocusScope.of(context).unfocus();
                  bloc.guess(_wordGuess);
                }
              },
              child: const Text('Guess'),
            ),
            const Spacer(),
          ],
        );
      },
    );
  }

  void _onExit() {
    widget.bloc.clean(context);
    context.router.popUntilRoot();
  }
}
