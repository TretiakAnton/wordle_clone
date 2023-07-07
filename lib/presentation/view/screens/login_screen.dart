import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/presentation/state_management/login_bloc/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController(text: 'qwe@qwe.com');
  TextEditingController passwordController = TextEditingController(text: 'test12');

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginCubit>();
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginCompleted) {
          WidgetsBinding.instance.addPostFrameCallback((_) => context.router.pushNamed('path'));
        }
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              TextFormField(
                controller: emailController,
              ),
              TextFormField(
                controller: passwordController,
              ),
              OutlinedButton(
                onPressed: () {
                  bloc.googleLogin(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
