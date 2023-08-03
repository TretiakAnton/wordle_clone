import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wordle_clone/core/navigation/app_router.dart';
import 'package:wordle_clone/generated/locale_keys.g.dart';
import 'package:wordle_clone/presentation/view/widgets/language_selectable_tile.dart';
import 'package:wordle_clone/presentation/view/widgets/setting_frame.dart';

class InterfaceLanguageScreen extends StatefulWidget {
  const InterfaceLanguageScreen({Key? key}) : super(key: key);

  @override
  State<InterfaceLanguageScreen> createState() => _InterfaceLanguageScreenState();
}

class _InterfaceLanguageScreenState extends State<InterfaceLanguageScreen> {
  Locale? _selected;

  @override
  Widget build(BuildContext context) {
    _selected = _selected ?? context.locale;
    return SettingsFrame(
      appbarTitle: LocaleKeys.language.tr(),
      child: Column(
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: ListView.builder(
              itemCount: context.supportedLocales.length,
              itemBuilder: (BuildContext context, int index) {
                return LanguageSelectableTile(
                  current: context.supportedLocales[index],
                  selected: _selected!,
                  onChange: (Locale? selected) {
                    setState(() {
                      if (selected != null) {
                        _selected = selected;
                      }
                    });
                  },
                );
              },
            ),
          ),
          TextButton(
            onPressed: () async {
              await context.setLocale(_selected!);
              if (context.mounted) {
                context.router.popUntil((route) => false);
                context.router.push(const MenuScreenRoute());
              }
            },
            child: Text(LocaleKeys.confirm.tr()),
          ),
        ],
      ),
    );
  }
}
