import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:wordle_clone/generated/codegen_loader.g.dart';

class EasyLocalizationWidget extends StatelessWidget {
  final Widget widget;

  const EasyLocalizationWidget({Key? key, required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'GB'),
      assetLoader: const CodegenLoader(),
      saveLocale: true,
      supportedLocales: const [
        Locale('en', 'GB'),
        Locale('uk', 'UA'),
      ],
      child: widget,
    );
  }
}
