import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/presentation/state_management/login_bloc/login_cubit.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginCubit>();
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
      },
      child: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {},
                child: const Text('4'),
              ),
              OutlinedButton(
                onPressed: () {},
                child: const Text('5'),
              ),
              OutlinedButton(
                onPressed: () {},
                child: const Text('6'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
