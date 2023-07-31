import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/core/constants.dart';
import 'package:wordle_clone/data/entity/language.dart';
import 'package:wordle_clone/presentation/state_management/seetings_bloc/settings_cubit.dart';
import 'package:wordle_clone/presentation/view/widgets/language_selectable_tile.dart';

class InterfaceLanguageScreen extends StatefulWidget {
  const InterfaceLanguageScreen({Key? key}) : super(key: key);

  @override
  State<InterfaceLanguageScreen> createState() => _InterfaceLanguageScreenState();
}

class _InterfaceLanguageScreenState extends State<InterfaceLanguageScreen> {
  late Language _selected;

  @override
  void initState() {
    _selected = context.read<SettingsCubit>().selectedInterfaceLanguage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SettingsCubit>();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding(context: context, pixels: 10),
            vertical: verticalPadding(context: context, pixels: 20),
          ),
          child: Column(
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: ListView.builder(
                  itemCount: bloc.availableInterfaceLanguage.length,
                  itemBuilder: (BuildContext context, int index) {
                    return LanguageSelectableTile(
                      current: bloc.availableInterfaceLanguage[index],
                      selected: _selected,
                      onChange: (Language? selected) {
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
                  await bloc.setInterfaceLanguage(_selected);
                  if (context.mounted) {
                    await context.setLocale(_selected.locale);
                  }
                  if (context.mounted) {
                    context.router.pop();
                  }
                },
                child: const Text('Confirm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
