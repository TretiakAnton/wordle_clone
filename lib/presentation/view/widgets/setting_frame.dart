import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wordle_clone/core/constants.dart';

class SettingsFrame extends StatelessWidget {
  const SettingsFrame({Key? key, required this.child, this.appbarTitle}) : super(key: key);
  final Widget child;
  final String? appbarTitle;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _SettingAppBar(
          title: appbarTitle,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding(context: context, pixels: 10),
            vertical: verticalPadding(context: context, pixels: 20),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _SettingAppBar extends StatelessWidget with PreferredSizeWidget {
  const _SettingAppBar({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => context.router.pop(),
      ),
      centerTitle: true,
      title: Text(
        title ?? '',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
