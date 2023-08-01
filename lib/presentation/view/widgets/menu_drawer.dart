import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wordle_clone/core/navigation/routes.dart';
import 'package:wordle_clone/generated/locale_keys.g.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: SizedBox(),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(LocaleKeys.language.tr()),
            onTap: () {
              context.router.pushNamed(Routes.interfaceLanguageScreen);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(LocaleKeys.words_language.tr()),
            onTap: () {
              context.router.pushNamed(Routes.wordsLanguageScreen);
            },
          ),
        ],
      ),
    );
  }
}