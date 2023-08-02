import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/core/constants.dart';
import 'package:wordle_clone/core/navigation/routes.dart';
import 'package:wordle_clone/generated/locale_keys.g.dart';
import 'package:wordle_clone/presentation/state_management/menu_bloc/menu_cubit.dart';
import 'package:wordle_clone/presentation/state_management/settings_bloc/settings_cubit.dart';
import 'package:wordle_clone/presentation/view/widgets/menu_drawer.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MenuCubit>();
    return SafeArea(
      child: GestureDetector(
        onTap: () => bloc.numberOfLetters = null,
        child: Scaffold(
          appBar: AppBar(),
          drawer: const MenuDrawer(),
          body: BlocConsumer<MenuCubit, MenuState>(
            listener: (context, state) {
              if (state is MenuInitial) {
                bloc.checkWords();
              }
            },
            builder: (context, state) {
              return Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Text(
                            _menuTitle(context.watch<SettingsCubit>().selectedWordLanguage),
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          SizedBox(
                            height: verticalPadding(
                              context: context,
                              pixels: 20,
                            ),
                          ),
                          _selectableButton(
                            onPressed: () {
                              bloc.numberOfLetters = 4;
                            },
                            isSelected: bloc.isSelected(4),
                            title: LocaleKeys.letter.plural(4),
                            context: context,
                          ),
                          SizedBox(
                            height: verticalPadding(
                              context: context,
                              pixels: 20,
                            ),
                          ),
                          _selectableButton(
                            onPressed: () {
                              bloc.numberOfLetters = 5;
                            },
                            isSelected: bloc.isSelected(5),
                            title: LocaleKeys.letter.plural(5),
                            context: context,
                          ),
                          SizedBox(
                            height: verticalPadding(
                              context: context,
                              pixels: 20,
                            ),
                          ),
                          Visibility(
                            visible: context.watch<SettingsCubit>().selectedWordLanguage.languageCode == 'en',
                            child: _selectableButton(
                              onPressed: () {
                                bloc.numberOfLetters = 6;
                              },
                              isSelected: bloc.isSelected(6),
                              title: LocaleKeys.letter.plural(6),
                              context: context,
                            ),
                          ),
                          const Spacer(),
                          Visibility(
                            visible: (bloc.isSelected(4) || bloc.isSelected(5) || bloc.isSelected(6)),
                            child: OutlinedButton(
                              onPressed: () {
                                if (bloc.isWordsLoaded) {
                                  context.router.pushNamed(Routes.gameScreen);
                                }
                              },
                              child: bloc.isWordsLoaded
                                  ? Text(LocaleKeys.start.tr())
                                  : Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(LocaleKeys.wait_until_game_is_loaded.tr()),
                                        SizedBox(
                                          width: horizontalPadding(context: context, pixels: 10),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                          child: CircularProgressIndicator(),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: verticalPadding(
                              context: context,
                              pixels: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _selectableButton({
    required VoidCallback onPressed,
    required String title,
    required bool isSelected,
    required BuildContext context,
  }) {
    return OutlinedButton(
      onPressed: () => onPressed(),
      style: OutlinedButton.styleFrom(
        backgroundColor: isSelected ? Theme.of(context).secondaryHeaderColor : Theme.of(context).hoverColor,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  String _menuTitle(Locale locale) {
    final result =
        '${locale.languageCode == 'en' ? LocaleKeys.english.tr() : LocaleKeys.ukrainian.tr()} ${LocaleKeys.version.tr()}';
    return result;
  }
}
