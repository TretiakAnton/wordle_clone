import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wordle_clone/domain/model/game_result.dart';
import 'package:wordle_clone/generated/locale_keys.g.dart';

Future<void> showWinDialog({
  required BuildContext context,
  required bool isWin,
  required GameResult result,
  required VoidCallback onExit,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        child: _EndGameDialog(
          isWin: isWin,
          result: result,
          onExit: onExit,
        ),
      );
    },
  );
}

class _EndGameDialog extends StatelessWidget {
  final bool isWin;
  final GameResult result;
  final VoidCallback onExit;

  const _EndGameDialog({
    required this.result,
    Key? key,
    required this.onExit,
    required this.isWin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(isWin ? LocaleKeys.you_win.tr() : LocaleKeys.you_loose.tr()),
          Text('${isWin ? LocaleKeys.you_guess_word.tr() : LocaleKeys.you_dont_guess_word.tr()}: ${result.word}'),
          Text(LocaleKeys.guesses.plural(result.guessesMade)),
          TextButton(
            onPressed: () {
              onExit();
            },
            child: Text(LocaleKeys.close.tr()),
          ),
        ],
      ),
    );
  }
}
