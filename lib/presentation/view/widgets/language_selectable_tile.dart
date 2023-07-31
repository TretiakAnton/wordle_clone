import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wordle_clone/core/constants.dart';
import 'package:wordle_clone/data/entity/language.dart';

class LanguageSelectableTile extends StatelessWidget {
  const LanguageSelectableTile({
    Key? key,
    required this.current,
    required this.selected,
    required this.onChange,
  }) : super(key: key);
  final Language current;
  final Language selected;
  final Function(Language?) onChange;

  @override
  Widget build(BuildContext context) {
    return RadioListTile<Language>(
      title: Row(
        children: [
          Text(current.languageName()),
          SizedBox(
            width: horizontalPadding(context: context, pixels: 15),
          ),
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: current.icon(),
              height: 24,
              width: 24,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
      value: current,
      groupValue: selected,
      onChanged: (Language? value) => onChange(value),
    );
  }
}
