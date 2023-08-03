import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/core/constants.dart';
import 'package:wordle_clone/core/navigation/app_router.dart';
import 'package:wordle_clone/generated/locale_keys.g.dart';
import 'package:wordle_clone/presentation/state_management/auth_bloc/auth_state.dart';
import 'package:wordle_clone/presentation/state_management/auth_bloc/registration_cubit.dart';
import 'package:wordle_clone/presentation/view/widgets/input_widgets.dart';

class RegistrationScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

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
              child: Form(
                key: _formKey,
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
                      focusNode: _passwordFocus,
                    ),
                    SizedBox(
                      height: verticalPadding(
                        context: context,
                        pixels: 20,
                      ),
                    ),
                    InputWidget(
                      textEditingController: confirmPasswordController,
                      focusNode: _confirmPasswordFocus,
                      labelText: LocaleKeys.confirm_password.tr(),
                      prefixIcon: const Icon(Icons.lock),
                      validator: (value) {
                        if ((passwordController.text != confirmPasswordController.text) &&
                            (!_passwordFocus.hasFocus && !_confirmPasswordFocus.hasFocus) &&
                            (confirmPasswordController.text != '')) {
                          return LocaleKeys.passwords_do_not_match.tr();
                        }
                        return null;
                      },
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
                        await Future.delayed(const Duration(milliseconds: 100));
                        if (_formKey.currentState?.validate() ?? false) {
                          await bloc.emailPasswordLogin(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        }
                      },
                      child: state is AuthInProgress
                          ? const CircularProgressIndicator()
                          : Text(
                              LocaleKeys.register.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Theme.of(context).primaryColor),
                            ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
