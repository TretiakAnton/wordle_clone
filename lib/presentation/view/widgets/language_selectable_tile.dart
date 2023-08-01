import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wordle_clone/core/constants.dart';
import 'package:wordle_clone/generated/locale_keys.g.dart';

class LanguageSelectableTile extends StatelessWidget {
  const LanguageSelectableTile({
    Key? key,
    required this.current,
    required this.selected,
    required this.onChange,
  }) : super(key: key);
  final Locale current;
  final Locale selected;
  final Function(Locale?) onChange;

  @override
  Widget build(BuildContext context) {
    return RadioListTile<Locale>(
      title: Row(
        children: [
          Text(_languageName(locale: current)),
          SizedBox(
            width: horizontalPadding(context: context, pixels: 15),
          ),
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: _icon(locale: current),
              height: 24,
              width: 24,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
      value: current,
      groupValue: selected,
      onChanged: (Locale? value) => onChange(value),
    );
  }

  String _languageName({required Locale locale}) {
    switch (locale.countryCode) {
      case 'GB':
        return LocaleKeys.english.tr();
      case 'UA':
        return LocaleKeys.ukrainian.tr();
      default:
        return '';
    }
  }

  String _icon({required Locale locale}) {
    return 'https://flagcdn.com/w320/${locale.countryCode?.toLowerCase()}.png';
  }
}
