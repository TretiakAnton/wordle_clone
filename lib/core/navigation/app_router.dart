import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wordle_clone/core/navigation/routes.dart';
import 'package:wordle_clone/presentation/view/screens/login_screen.dart';
import 'package:wordle_clone/presentation/view/screens/menu_screen.dart';


part 'app_router.gr.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(
      page: LoginScreen,
      path: Routes.loginScreen,
      initial: true,
    ),
    AutoRoute(
      page: MenuScreen,
      path: Routes.menuScreen,
    ),
  ],
)
class AppRouter extends _$AppRouter {}