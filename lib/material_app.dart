import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/core/navigation/app_router.dart';
import 'package:wordle_clone/core/style/themes.dart';
import 'package:wordle_clone/presentation/state_management/settings_bloc/settings_cubit.dart';

final GlobalKey<ScaffoldMessengerState> materialAppKey = GlobalKey<ScaffoldMessengerState>();

class MaterialWordleApp extends StatefulWidget {
  const MaterialWordleApp({Key? key}) : super(key: key);

  @override
  State<MaterialWordleApp> createState() => _MaterialWordleAppState();
}

class _MaterialWordleAppState extends State<MaterialWordleApp> {
  final _appRouter = AppRouter();
  ThemeMode? _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = context.read<SettingsCubit>().theme;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is SettingsColorThemeChanged) {
          setState(() {
            _themeMode = state.themeMode;
          });
        }
      },
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: materialAppKey,
        theme: WordleTheme.lightThemeData,
        darkTheme: WordleTheme.darkThemeData,
        themeMode: _themeMode ?? ThemeMode.system,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
    );
  }
}
