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
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const LoginScreen(),
      );
    },
    MenuScreenRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const MenuScreen(),
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
          MenuScreenRoute.name,
          path: '/menu_screen',
        ),
      ];
}

/// generated route for
/// [LoginScreen]
class LoginScreenRoute extends PageRouteInfo<void> {
  const LoginScreenRoute()
      : super(
          LoginScreenRoute.name,
          path: '/login_screen',
        );

  static const String name = 'LoginScreenRoute';
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
