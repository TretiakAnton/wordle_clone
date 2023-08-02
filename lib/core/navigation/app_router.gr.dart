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
    SplashScreenRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SplashScreen(),
      );
    },
    LoginScreenRoute.name: (routeData) {
      final args = routeData.argsAs<LoginScreenRouteArgs>(
          orElse: () => const LoginScreenRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: LoginScreen(key: args.key),
      );
    },
    RegistrationScreenRoute.name: (routeData) {
      final args = routeData.argsAs<RegistrationScreenRouteArgs>(
          orElse: () => const RegistrationScreenRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: RegistrationScreen(key: args.key),
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
    WordsLanguageScreenRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const WordsLanguageScreen(),
      );
    },
    InterfaceLanguageScreenRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const InterfaceLanguageScreen(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/splash_screen',
          fullMatch: true,
        ),
        RouteConfig(
          SplashScreenRoute.name,
          path: '/splash_screen',
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
        RouteConfig(
          WordsLanguageScreenRoute.name,
          path: '/words_language_screen',
        ),
        RouteConfig(
          InterfaceLanguageScreenRoute.name,
          path: '/interface_language_screen',
        ),
      ];
}

/// generated route for
/// [SplashScreen]
class SplashScreenRoute extends PageRouteInfo<void> {
  const SplashScreenRoute()
      : super(
          SplashScreenRoute.name,
          path: '/splash_screen',
        );

  static const String name = 'SplashScreenRoute';
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
class RegistrationScreenRoute
    extends PageRouteInfo<RegistrationScreenRouteArgs> {
  RegistrationScreenRoute({Key? key})
      : super(
          RegistrationScreenRoute.name,
          path: '/registration_screen',
          args: RegistrationScreenRouteArgs(key: key),
        );

  static const String name = 'RegistrationScreenRoute';
}

class RegistrationScreenRouteArgs {
  const RegistrationScreenRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'RegistrationScreenRouteArgs{key: $key}';
  }
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

/// generated route for
/// [WordsLanguageScreen]
class WordsLanguageScreenRoute extends PageRouteInfo<void> {
  const WordsLanguageScreenRoute()
      : super(
          WordsLanguageScreenRoute.name,
          path: '/words_language_screen',
        );

  static const String name = 'WordsLanguageScreenRoute';
}

/// generated route for
/// [InterfaceLanguageScreen]
class InterfaceLanguageScreenRoute extends PageRouteInfo<void> {
  const InterfaceLanguageScreenRoute()
      : super(
          InterfaceLanguageScreenRoute.name,
          path: '/interface_language_screen',
        );

  static const String name = 'InterfaceLanguageScreenRoute';
}
