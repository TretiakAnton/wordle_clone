import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle_clone/domain/model/guess_options.dart';
import 'package:wordle_clone/presentation/state_management/settings_bloc/settings_cubit.dart';

class LettersField extends StatelessWidget {
  final Function(String) onChange;
  final double defaultBoxSize;
  final double selectedBoxSize;
  final BoxDecoration? defaultDecoration;
  final int codeLength;
  final TextStyle? textStyle;
  final double margin;
  final BoxDecoration? selectedDecoration;
  final bool enabled;
  final bool autoFocus;
  final MainAxisAlignment alignment;
  final TextEditingController textController;
  final List<GuessOptions>? guesses;

  LettersField({
    super.key,
    required this.onChange,
    required this.defaultBoxSize,
    required this.guesses,
    this.defaultDecoration,
    selectedBoxSize,
    this.codeLength = 5,
    this.textStyle,
    this.margin = 10.0,
    this.selectedDecoration,
    this.enabled = true,
    this.autoFocus = false,
    this.alignment = MainAxisAlignment.spaceBetween,
    textController,
  })  : textController = textController ?? TextEditingController(),
        selectedBoxSize = selectedBoxSize ?? defaultBoxSize;

  List<Widget> getField(BuildContext context) {
    final List<Widget> result = <Widget>[];
    for (int i = 1; i <= codeLength; i++) {
      result.add(
        Flexible(
          fit: FlexFit.loose,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              textController.text.length <= i - 1
                  ? Align(
                      alignment: Alignment.center,
                      child: Container(
                          height: defaultBoxSize,
                          width: defaultBoxSize,
                          decoration: defaultDecoration ??
                              textFieldDecoration(selected: false, guessResult: guesses?[i - 1], context: context)),
                    )
                  : Container(),
              textController.text.length >= i
                  ? Container(
                      decoration: selectedDecoration ??
                          textFieldDecoration(selected: true, guessResult: guesses?[i - 1], context: context),
                      width: selectedBoxSize,
                      height: selectedBoxSize,
                      child: Center(
                        child: Text(
                          textController.text[i - 1],
                          style: textStyle,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: defaultBoxSize >= selectedBoxSize ? defaultBoxSize : selectedBoxSize,
            child: Row(
              mainAxisAlignment: alignment,
              children: getField(context),
            ),
          ),
          _DefaultTextField(
            codeLength: codeLength,
            enabled: enabled,
            autoFocus: autoFocus,
            textController: textController,
            onChange: onChange,
          ),
        ],
      ),
    );
  }

  Widget defaultTextField() {
    return Opacity(
      opacity: 0.0,
      child: TextField(
        maxLength: codeLength,
        showCursor: false,
        enableSuggestions: false,
        autocorrect: false,
        enabled: enabled,
        autofocus: autoFocus,
        enableIMEPersonalizedLearning: false,
        enableInteractiveSelection: false,
        style: const TextStyle(color: Colors.transparent),
        decoration: const InputDecoration(
            fillColor: Colors.transparent,
            counterStyle: TextStyle(color: Colors.transparent),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            filled: true),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Zа-яА-ЯґҐєЄіІїЇ]+$')),
        ],
        keyboardType: TextInputType.text,
        controller: textController,
        onChanged: onChange,
      ),
    );
  }

  BoxDecoration textFieldDecoration({
    required bool selected,
    required GuessOptions? guessResult,
    required BuildContext context,
  }) {
    return BoxDecoration(
      border: Border.all(color: selected ? Theme.of(context).secondaryHeaderColor : Theme.of(context).canvasColor),
      borderRadius: BorderRadius.circular(10.0),
      color: _chooseBackgroundColor(guessResult: guessResult),
    );
  }

  Color _chooseBackgroundColor({required GuessOptions? guessResult}) {
    if (guessResult == null) {
      return Colors.white;
    } else if (guessResult == GuessOptions.rightLetterRightPosition) {
      return Colors.green;
    } else if (guessResult == GuessOptions.rightLetterWrongPosition) {
      return Colors.yellow;
    } else {
      return Colors.grey;
    }
  }
}

class _DefaultTextField extends StatelessWidget {
  const _DefaultTextField({
    Key? key,
    required this.codeLength,
    required this.enabled,
    required this.autoFocus,
    required this.textController,
    required this.onChange,
  }) : super(key: key);
  final int? codeLength;
  final bool? enabled;
  final bool autoFocus;
  final TextEditingController? textController;
  final Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    bool isEn = context.read<SettingsCubit>().selectedWordLanguage.languageCode == 'en';
    return Opacity(
      opacity: 0.0,
      child: TextField(
        maxLength: codeLength,
        showCursor: false,
        enableSuggestions: false,
        autocorrect: false,
        enabled: enabled,
        autofocus: autoFocus,
        enableIMEPersonalizedLearning: false,
        enableInteractiveSelection: false,
        style: const TextStyle(color: Colors.transparent),
        decoration: const InputDecoration(
            fillColor: Colors.transparent,
            counterStyle: TextStyle(color: Colors.transparent),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            filled: true),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(isEn ? RegExp(r'^[a-zA-Z]+$') : RegExp(r'^[а-яА-ЯґҐєЄіІїЇ]+$')),
        ],
        keyboardType: TextInputType.text,
        controller: textController,
        onChanged: onChange,
      ),
    );
  }
}
