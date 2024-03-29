import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/core/constants.dart';
import 'package:wordle_clone/core/navigation/routes.dart';
import 'package:wordle_clone/generated/locale_keys.g.dart';
import 'package:wordle_clone/presentation/state_management/auth_bloc/auth_state.dart';
import 'package:wordle_clone/presentation/state_management/auth_bloc/login_cubit.dart';
import 'package:wordle_clone/presentation/view/widgets/input_widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController(); //(text: 'qwe@qwe.com');
  final TextEditingController passwordController = TextEditingController(); //(text: 'test12');

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginCubit>();
    return BlocConsumer<LoginCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthCompleted) {
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
                  EmailInput(
                    textEditingController: emailController,
                  ),
                  SizedBox(
                    height: verticalPadding(
                      context: context,
                      pixels: 20,
                    ),
                  ),
                  PasswordInput(
                    textEditingController: passwordController,
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
                        : Text(
                            LocaleKeys.login.tr(),
                            style:
                                Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).primaryColor),
                          ),
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
                      style: Theme.of(context).textTheme.bodySmall,
                      children: [
                        TextSpan(
                          text: LocaleKeys.create_it_now.tr(),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).primaryColor),
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
