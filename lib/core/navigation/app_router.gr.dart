// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    LoginScreenRoute.name: (routeData) {
      final args = routeData.argsAs<LoginScreenRouteArgs>(
          orElse: () => const LoginScreenRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: LoginScreen(key: args.key),
      );
    },
    RegistrationScreenRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const RegistrationScreen(),
      );
    },
    MenuScreenRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const MenuScreen(),
      );
    },
    GameScreenRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const GameScreen(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/login_screen',
          fullMatch: true,
        ),
        RouteConfig(
          LoginScreenRoute.name,
          path: '/login_screen',
        ),
        RouteConfig(
          RegistrationScreenRoute.name,
          path: '/registration_screen',
        ),
        RouteConfig(
          MenuScreenRoute.name,
          path: '/menu_screen',
        ),
        RouteConfig(
          GameScreenRoute.name,
          path: '/game_screen',
        ),
      ];
}

/// generated route for
/// [LoginScreen]
class LoginScreenRoute extends PageRouteInfo<LoginScreenRouteArgs> {
  LoginScreenRoute({Key? key})
      : super(
          LoginScreenRoute.name,
          path: '/login_screen',
          args: LoginScreenRouteArgs(key: key),
        );

  static const String name = 'LoginScreenRoute';
}

class LoginScreenRouteArgs {
  const LoginScreenRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'LoginScreenRouteArgs{key: $key}';
  }
}

/// generated route for
/// [RegistrationScreen]
class RegistrationScreenRoute extends PageRouteInfo<void> {
  const RegistrationScreenRoute()
      : super(
          RegistrationScreenRoute.name,
          path: '/registration_screen',
        );

  static const String name = 'RegistrationScreenRoute';
}

/// generated route for
/// [MenuScreen]
class MenuScreenRoute extends PageRouteInfo<void> {
  const MenuScreenRoute()
      : super(
          MenuScreenRoute.name,
          path: '/menu_screen',
        );

  static const String name = 'MenuScreenRoute';
}

/// generated route for
/// [GameScreen]
class GameScreenRoute extends PageRouteInfo<void> {
  const GameScreenRoute()
      : super(
          GameScreenRoute.name,
          path: '/game_screen',
        );

  static const String name = 'GameScreenRoute';
}
