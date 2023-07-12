import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/core/constants.dart';
import 'package:wordle_clone/core/navigation/routes.dart';
import 'package:wordle_clone/presentation/state_management/game_bloc/game_cubit.dart';
import 'package:wordle_clone/presentation/state_management/menu_bloc/menu_cubit.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MenuCubit>();
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<MenuCubit, MenuState>(
          builder: (context, state) {
            if (state is MenuInitial) {
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => bloc.checkWords());
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                OutlinedButton(
                  onPressed: () {
                    bloc.numberOfLetters = 4;
                  },
                  style: OutlinedButton.styleFrom(
                      backgroundColor:
                          bloc.isSelected(4) ? Colors.grey : Colors.blue),
                  child: const Text('4 letters'),
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
                      backgroundColor:
                          bloc.isSelected(4) ? Colors.grey : Colors.blue),
                  child: const Text('5 letters'),
                ),
                SizedBox(
                  height: verticalPadding(
                    context: context,
                    pixels: 20,
                  ),
                ),
                OutlinedButton(
                  onPressed: () => bloc.numberOfLetters = 6,
                  style: OutlinedButton.styleFrom(
                      backgroundColor:
                          bloc.isSelected(4) ? Colors.grey : Colors.blue),
                  child: const Text('6 letters'),
                ),
                const Spacer(),
                OutlinedButton(
                  onPressed: () {
                    if (state is GameCompleted) {
                      context.router.pushNamed(Routes.gameScreen);
                    }
                  },
                  child: state is GameCompleted
                      ? const Text('Start')
                      : const CircularProgressIndicator(),
                ),
                SizedBox(
                  height: verticalPadding(
                    context: context,
                    pixels: 50,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
