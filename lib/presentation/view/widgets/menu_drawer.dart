import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wordle_clone/core/navigation/routes.dart';

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
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            onTap: () {
              context.router.pushNamed(Routes.interfaceLanguageScreen);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Words language'),
            onTap: () {
              context.router.pushNamed(Routes.wordsLanguageScreen);
            },
          ),
        ],
      ),
    );
  }
}
