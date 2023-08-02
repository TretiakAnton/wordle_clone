import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/core/constants.dart';
import 'package:wordle_clone/core/navigation/routes.dart';
import 'package:wordle_clone/generated/locale_keys.g.dart';
import 'package:wordle_clone/presentation/state_management/auth_bloc/login_cubit.dart';

Future<void> showLogOutDialog({
  required BuildContext context,
}) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return const Dialog(
        child: _LogOutDialog(),
      );
    },
  );
}

class _LogOutDialog extends StatelessWidget {
  const _LogOutDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(LocaleKeys.are_you_sure_you_want_to_log_out.tr()),
          SizedBox(
            height: verticalPadding(context: context, pixels: 15),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () async {
                  final isLogoutSuccess = await context.read<LoginCubit>().logOut();
                  if (isLogoutSuccess && context.mounted) {
                    context.router.replaceNamed(Routes.loginScreen);
                  }
                },
                child: Text(LocaleKeys.yes.tr()),
              ),
              TextButton(
                onPressed: () {
                  context.router.pop();
                },
                child: Text(LocaleKeys.no.tr()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
