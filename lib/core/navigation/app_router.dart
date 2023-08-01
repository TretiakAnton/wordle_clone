import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wordle_clone/core/navigation/routes.dart';
import 'package:wordle_clone/presentation/view/screens/game_screen.dart';
import 'package:wordle_clone/presentation/view/screens/login_screen.dart';
import 'package:wordle_clone/presentation/view/screens/menu_screen.dart';
import 'package:wordle_clone/presentation/view/screens/registration_screen.dart';
import 'package:wordle_clone/presentation/view/screens/settings/interface_language_screen.dart';
import 'package:wordle_clone/presentation/view/screens/settings/words_language_screen.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(
      page: LoginScreen,
      path: Routes.loginScreen,
      initial: true,
    ),
    AutoRoute(
      page: RegistrationScreen,
      path: Routes.registrationScreen,
    ),
    AutoRoute(
      page: MenuScreen,
      path: Routes.menuScreen,
    ),
    AutoRoute(
      page: GameScreen,
      path: Routes.gameScreen,
    ),
    AutoRoute(
      page: WordsLanguageScreen,
      path: Routes.wordsLanguageScreen,
    ),
    AutoRoute(
      page: InterfaceLanguageScreen,
      path: Routes.interfaceLanguageScreen,
    ),
  ],
)
class AppRouter extends _$AppRouter {}
