import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/material_app.dart';
import 'package:wordle_clone/presentation/state_management/game_bloc/game_cubit.dart';
import 'package:wordle_clone/presentation/state_management/menu_bloc/menu_cubit.dart';
import 'package:wordle_clone/presentation/state_management/settings_bloc/settings_cubit.dart';
import 'package:wordle_clone/presentation/state_management/splash_bloc/splash_cubit.dart';
import 'presentation/state_management/auth_bloc/login_cubit.dart';
import 'presentation/state_management/auth_bloc/registration_cubit.dart';

class WordleApp extends StatefulWidget {
  const WordleApp({Key? key}) : super(key: key);

  @override
  State<WordleApp> createState() => _WordleAppState();
}

class _WordleAppState extends State<WordleApp> {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
        BlocProvider<RegistrationCubit>(create: (context) => RegistrationCubit()),
        BlocProvider<MenuCubit>(create: (context) => MenuCubit()),
        BlocProvider<GameCubit>(create: (context) => GameCubit()),
        BlocProvider<SettingsCubit>(create: (context) => SettingsCubit()),
        BlocProvider<SplashCubit>(create: (context) => SplashCubit()),
      ],
      child: const MaterialWordleApp(),
    );
  }
}
