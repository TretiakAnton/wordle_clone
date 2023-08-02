import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/core/constants.dart';
import 'package:wordle_clone/generated/locale_keys.g.dart';
import 'package:wordle_clone/presentation/state_management/settings_bloc/settings_cubit.dart';

class ColorSchemeScreen extends StatefulWidget {
  const ColorSchemeScreen({Key? key}) : super(key: key);

  @override
  State<ColorSchemeScreen> createState() => _ColorSchemeScreenState();
}

class _ColorSchemeScreenState extends State<ColorSchemeScreen> {
  bool? _isLight;

 /* @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _isLight = Theme.of(context).brightness == Brightness.light);
  }*/

  @override
  Widget build(BuildContext context) {
     _isLight = _isLight ?? Theme.of(context).brightness == Brightness.light;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(LocaleKeys.choose_color_scheme.tr()),
              SizedBox(
                height: verticalPadding(context: context, pixels: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(LocaleKeys.dark.tr()),
                  Switch.adaptive(
                    value: _isLight!,
                    onChanged: (bool newValue) async {
                      await context.read<SettingsCubit>().setTheme(newValue ? ThemeMode.light : ThemeMode.dark);
                      setState(() {
                        _isLight = newValue;
                      });
                    },
                  ),
                  Text(LocaleKeys.light.tr()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
