import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/core/constants.dart';
import 'package:wordle_clone/core/navigation/app_router.dart';
import 'package:wordle_clone/generated/locale_keys.g.dart';
import 'package:wordle_clone/presentation/state_management/splash_bloc/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<SplashCubit>().initApp(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashCompleted) {
          final PageRouteInfo pushRoute =
              state.canSkipLogin ? const MenuScreenRoute() : LoginScreenRoute() as PageRouteInfo;
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => context.router.pushAndPopUntil(
              pushRoute,
              predicate: (_) => false,
            ),
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(LocaleKeys.welcome_to_wordle.tr()),
              SizedBox(
                height: verticalPadding(context: context, pixels: 20),
              ),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
