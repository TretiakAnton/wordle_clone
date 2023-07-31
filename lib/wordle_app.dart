import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/core/navigation/app_router.dart';
import 'package:wordle_clone/presentation/state_management/game_bloc/game_cubit.dart';
import 'package:wordle_clone/presentation/state_management/login_bloc/login_cubit.dart';
import 'package:wordle_clone/presentation/state_management/menu_bloc/menu_cubit.dart';
import 'package:wordle_clone/presentation/state_management/seetings_bloc/settings_cubit.dart';
import 'presentation/state_management/registration_bloc/registration_cubit.dart';

final GlobalKey<ScaffoldMessengerState> materialAppKey = GlobalKey<ScaffoldMessengerState>();

class WordleApp extends StatelessWidget {
  WordleApp({Key? key}) : super(key: key);
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
        BlocProvider<RegistrationCubit>(create: (context) => RegistrationCubit()),
        BlocProvider<MenuCubit>(create: (context) => MenuCubit()),
        BlocProvider<GameCubit>(create: (context) => GameCubit()),
        BlocProvider<SettingsCubit>(create: (context) => SettingsCubit()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: materialAppKey,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
    );
  }
}
