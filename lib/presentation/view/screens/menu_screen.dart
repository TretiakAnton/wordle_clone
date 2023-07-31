import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/core/constants.dart';
import 'package:wordle_clone/core/navigation/routes.dart';
import 'package:wordle_clone/generated/locale_keys.g.dart';
import 'package:wordle_clone/presentation/state_management/menu_bloc/menu_cubit.dart';
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
                          //Text(state.toString()),
                          const Spacer(),
                          OutlinedButton(
                            onPressed: () {
                              bloc.numberOfLetters = 4;
                            },
                            style: OutlinedButton.styleFrom(
                                backgroundColor: bloc.isSelected(4) ? Colors.blue : Colors.grey),
                            child: Text(LocaleKeys.letter.plural(4)),
                          ),
                          SizedBox(
                            height: verticalPadding(
                              context: context,
                              pixels: 20,
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () => bloc.numberOfLetters = 5,
                            style: OutlinedButton.styleFrom(
                                backgroundColor: bloc.isSelected(5) ? Colors.blue : Colors.grey),
                            child: Text(LocaleKeys.letter.plural(5)),
                          ),
                          SizedBox(
                            height: verticalPadding(
                              context: context,
                              pixels: 20,
                            ),
                          ),
                          Visibility(
                            visible: context.locale.languageCode == 'en',
                            child: OutlinedButton(
                              onPressed: () => bloc.numberOfLetters = 6,
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: bloc.isSelected(6) ? Colors.blue : Colors.grey),
                              child: Text(LocaleKeys.letter.plural(6)),
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
                                  ? const Text('Start')
                                  : Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text('Wait until game is loaded'),
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
}
