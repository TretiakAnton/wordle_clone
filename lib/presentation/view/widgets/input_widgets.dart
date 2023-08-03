import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wordle_clone/generated/locale_keys.g.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({
    Key? key,
    required this.textEditingController,
  }) : super(key: key);
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return InputWidget(
      textEditingController: textEditingController,
      prefixIcon: const Icon(Icons.mail),
      hintText: LocaleKeys.hint.tr(args: [(LocaleKeys.email.tr().toLowerCase())]),
      labelText: LocaleKeys.email.tr(),
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    Key? key,
    required this.textEditingController,
    this.focusNode,
  }) : super(key: key);
  final TextEditingController textEditingController;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return InputWidget(
      textEditingController: textEditingController,
      prefixIcon: const Icon(Icons.lock),
      hintText: LocaleKeys.hint.tr(args: [(LocaleKeys.password.tr().toLowerCase())]),
      labelText: LocaleKeys.password.tr(),
      focusNode: focusNode,
    );
  }
}

class InputWidget extends StatelessWidget {
  final TextEditingController textEditingController;

  final int? maxLength;
  final String? hintText;
  final String? labelText;
  final Color? hintColor;
  final double? hintSize;
  final String? initialValue;
  final FontWeight? hintFontWeight;
  final TextInputType? textInputType;
  final List<String>? autofillHints;
  final bool obscureText;
  final bool enabled;
  final bool autofocus;
  final FocusNode? focusNode;
  final int? maxLines;
  final int? errorMaxLines;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final InputBorder? inputBorder;
  final GestureTapCallback? onTap;

  final double? hintLetterSpace;
  final Color? fillColor;
  final EdgeInsets? contentPadding;
  final TextInputAction? textInputAction;
  final TextStyle? inputtextsStyle;

  final Function(String)? onChanged;

  final FormFieldValidator<String>? validator;

  final List<TextInputFormatter>? inputFormatters;

  const InputWidget({
    required this.textEditingController,
    this.obscureText = false,
    this.maxLength,
    this.hintText,
    this.labelText,
    this.hintColor,
    this.hintSize = 14,
    this.hintFontWeight,
    this.hintLetterSpace = 1,
    this.fillColor = Colors.transparent,
    this.contentPadding,
    this.initialValue,
    this.autofillHints,
    this.textInputType,
    this.suffixIcon,
    this.prefixIcon,
    this.inputBorder,
    this.validator,
    this.maxLines,
    this.errorMaxLines,
    this.enabled = true,
    this.autofocus = false,
    this.focusNode,
    this.onTap,
    this.textInputAction,
    this.inputtextsStyle,
    this.onChanged,
    this.inputFormatters,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      autofocus: autofocus,
      focusNode: focusNode,
      expands: false,
      keyboardType: textInputType,
      autofillHints: autofillHints,
      controller: textEditingController,
      maxLength: maxLength,
      validator: validator,
      initialValue: initialValue,
      enabled: enabled,
      onTap: onTap,
      onChanged: onChanged,
      textInputAction: textInputAction,
      style: inputtextsStyle ?? Theme.of(context).textTheme.bodyMedium,
      maxLines: maxLines,
      decoration: InputDecoration(
        suffixIcon: suffixIcon != null
            ? Align(
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: suffixIcon,
              )
            : null,
        prefixIcon: prefixIcon != null
            ? Align(
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: prefixIcon,
              )
            : null,
        errorMaxLines: errorMaxLines ?? 2,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: hintColor,
              fontSize: hintSize,
              fontWeight: hintFontWeight,
              letterSpacing: hintLetterSpace,
            ),
        filled: true,
        fillColor: fillColor,
        contentPadding: contentPadding,
        labelText: labelText,
      ),
    );
  }
}
