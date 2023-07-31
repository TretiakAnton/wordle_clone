import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/core/constants.dart';
import 'package:wordle_clone/core/navigation/routes.dart';
import 'package:wordle_clone/generated/locale_keys.g.dart';
import 'package:wordle_clone/presentation/state_management/login_bloc/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController(text: 'qwe@qwe.com');
  final TextEditingController passwordController = TextEditingController(text: 'test12');

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginCubit>();
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginCompleted) {
          WidgetsBinding.instance.addPostFrameCallback((_) => context.router.replaceNamed(Routes.menuScreen));
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
                    child: state is LoginInProgress ? const CircularProgressIndicator() : Text(LocaleKeys.login.tr()),
                  ),
                  SizedBox(
                    height: verticalPadding(
                      context: context,
                      pixels: 20,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: LocaleKeys.dont_have_an_account.tr(),
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: LocaleKeys.create_it_now.tr(),
                          style: const TextStyle(color: Colors.deepPurple),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => context.router.pushNamed(Routes.registrationScreen),
                        ),
                      ],
                    ),
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
