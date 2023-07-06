import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';


part 'app_router.gr.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(
      page: LoginScreen,
      path: Routes.loginScreen,
      initial: true,
    ),
    AutoRoute(
      page: HomeScreen,
      path: Routes.homeScreen,
    ),
  ],
)
class AppRouter extends _$AppRouter {}