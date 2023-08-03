import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/generated/locale_keys.g.dart';
import 'package:wordle_clone/presentation/state_management/settings_bloc/settings_cubit.dart';
import 'package:wordle_clone/presentation/view/widgets/language_selectable_tile.dart';
import 'package:wordle_clone/presentation/view/widgets/setting_frame.dart';

class WordsLanguageScreen extends StatefulWidget {
  const WordsLanguageScreen({Key? key}) : super(key: key);

  @override
  State<WordsLanguageScreen> createState() => _WordsLanguageScreenState();
}

class _WordsLanguageScreenState extends State<WordsLanguageScreen> {
  late Locale _selected;

  @override
  initState() {
    super.initState();
    _selected = context.read<SettingsCubit>().selectedWordLanguage;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SettingsCubit>();
    return SettingsFrame(
      appbarTitle: LocaleKeys.words_language.tr(),
      child: Column(
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: ListView.builder(
              itemCount: bloc.availableWordLanguage.length,
              itemBuilder: (BuildContext context, int index) {
                return LanguageSelectableTile(
                  current: bloc.availableWordLanguage[index],
                  selected: _selected,
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
              await bloc.setWordsLanguage(_selected);
              if (context.mounted) {
                context.router.pop();
              }
            },
            child: Text(LocaleKeys.confirm.tr()),
          ),
        ],
      ),
    );
  }
}
