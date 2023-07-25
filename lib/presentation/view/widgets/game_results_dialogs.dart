import 'package:flutter/material.dart';
import 'package:wordle_clone/domain/model/game_result.dart';

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
        child: isWin
            ? _WinDialog(
                result: result,
                onExit: onExit,
              )
            : _LooseDialog(
                result: result,
                onExit: onExit,
              ),
      );
    },
  );
}

class _WinDialog extends StatelessWidget {
  final GameResult result;
  final VoidCallback onExit;

  const _WinDialog({required this.result, Key? key, required this.onExit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('You win'),
          Text('you guess word: ${result.word}'),
          Text('with ${result.guessesMade} guesses'),
          TextButton(
            onPressed: () {
              onExit();
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _LooseDialog extends StatelessWidget {
  final GameResult result;
  final VoidCallback onExit;

  const _LooseDialog({required this.result, Key? key, required this.onExit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('You loose'),
        Text('you failed to guess word: ${result.word}'),
        Text('with ${result.guessesMade} guesses'),
        TextButton(
          onPressed: () {
            onExit();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
