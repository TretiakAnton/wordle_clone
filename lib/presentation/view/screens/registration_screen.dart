import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/core/constants.dart';
import 'package:wordle_clone/core/navigation/app_router.dart';
import 'package:wordle_clone/generated/locale_keys.g.dart';
import 'package:wordle_clone/presentation/state_management/auth_bloc/auth_state.dart';
import 'package:wordle_clone/presentation/state_management/auth_bloc/registration_cubit.dart';

class RegistrationScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegistrationCubit>();
    return BlocConsumer<RegistrationCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthCompleted) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => context.router.pushAndPopUntil(
              const MenuScreenRoute(),
              predicate: (route) => route.isFirst,
            ),
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding(context: context, pixels: 20),
                vertical: verticalPadding(context: context, pixels: 20),
              ),
              child: Column(
                children: [
                  const Spacer(),
                  TextFormField(
                    controller: emailController,
                  ),
                  SizedBox(
                    height: verticalPadding(
                      context: context,
                      pixels: 20,
                    ),
                  ),
                  TextFormField(
                    controller: passwordController,
                  ),
                  SizedBox(
                    height: verticalPadding(
                      context: context,
                      pixels: 40,
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      await bloc.emailPasswordLogin(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    },
                    child: state is AuthInProgress
                        ? const CircularProgressIndicator()
                        : Text(LocaleKeys.register.tr()),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
