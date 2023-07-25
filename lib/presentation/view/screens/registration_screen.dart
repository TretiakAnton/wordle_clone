import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/core/constants.dart';
import 'package:wordle_clone/core/navigation/routes.dart';
import 'package:wordle_clone/presentation/state_management/registration_screen/registration_cubit.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController emailController = TextEditingController(text: 'qwe@qwe.com');
  TextEditingController passwordController = TextEditingController(text: 'test12');

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegistrationCubit>();
    return BlocListener<RegistrationCubit, RegistrationState>(
      listener: (context, state) {
        if (state is RegistrationCompleted) {
          WidgetsBinding.instance.addPostFrameCallback((_) => context.router.replaceNamed(Routes.menuScreen));
        }
      },
      child: SafeArea(
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
                  onPressed: () {
                    bloc.emailPasswordLogin(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                  },
                  child: const Text('Register'),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
