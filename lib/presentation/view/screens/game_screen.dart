import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/core/constants.dart';
import 'package:wordle_clone/generated/locale_keys.g.dart';
import 'package:wordle_clone/presentation/state_management/game_bloc/game_cubit.dart';
import 'package:wordle_clone/presentation/state_management/settings_bloc/settings_cubit.dart';
import 'package:wordle_clone/presentation/view/widgets/dialogs/game_results_dialogs.dart';
import 'package:wordle_clone/presentation/view/widgets/dialogs/unknown_word_dialog.dart';
import 'package:wordle_clone/presentation/view/widgets/letters_field.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<GameCubit>();

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          bloc.clean(context);
          return true;
        },
        child: Scaffold(
          body: FutureBuilder(
            future: bloc.getSecretWord(locale: context.read<SettingsCubit>().selectedWordLanguage),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return _GameContent(
                  textEditingControllers: _fillControllers(length: bloc.numberOfLetters + 1),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
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
  final List<TextEditingController> textEditingControllers;

  const _GameContent({
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
    final bloc = context.read<GameCubit>();

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
        } else if (state is GameWordUnknown) {
          showUnknownWordDialog(
            context: context,
            word: state.word,
          );
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            Flexible(
              fit: FlexFit.loose,
              flex: bloc.numberOfLetters + 2,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: bloc.numberOfLetters + 1,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding(context: context, pixels: 15),
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
            SizedBox(
              height: verticalPadding(context: context, pixels: 15),
            ),
            OutlinedButton(
              onPressed: () async {
                if (_wordGuess.length == bloc.numberOfLetters) {
                  FocusScope.of(context).unfocus();
                  await bloc.guess(
                    word: _wordGuess,
                    isEn: context.read<SettingsCubit>().selectedWordLanguage.languageCode == 'en',
                  );
                }
              },
              child: Text(LocaleKeys.guess.tr()),
            ),
            const Spacer(),
          ],
        );
      },
    );
  }

  void _onExit() {
    context.read<GameCubit>().clean(context);
    context.router.popUntilRoot();
  }
}
