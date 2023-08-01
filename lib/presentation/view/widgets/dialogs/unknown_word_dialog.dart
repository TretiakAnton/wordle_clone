import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wordle_clone/core/constants.dart';
import 'package:wordle_clone/generated/locale_keys.g.dart';

Future<void> showUnknownWordDialog({
  required BuildContext context,
  required String word,
}) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        child: _UnknownWordDialog(
          word: word,
        ),
      );
    },
  );
}

class _UnknownWordDialog extends StatelessWidget {
  final String word;

  const _UnknownWordDialog({
    required this.word,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${LocaleKeys.unknown_word.tr()}: $word'),
          SizedBox(
            height: verticalPadding(context: context, pixels: 15),
          ),
          Text(LocaleKeys.try_another_one.tr()),
          TextButton(
            onPressed: () {
              context.router.pop();
            },
            child: Text(LocaleKeys.close.tr()),
          ),
        ],
      ),
    );
  }
}
