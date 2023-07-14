import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  LettersField({
    super.key,
    required this.onChange,
    required this.defaultBoxSize,
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

  List<Widget> getField() {
    final List<Widget> result = <Widget>[];
    for (int i = 1; i <= codeLength; i++) {
      result.add(Padding(
        padding: EdgeInsets.symmetric(
          horizontal: margin,
        ),
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
                            textFieldDecoration(selected: false)),
                  )
                : Container(),
            textController.text.length >= i
                ? Container(
                    decoration: selectedDecoration ??
                        textFieldDecoration(selected: true),
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
      ));
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
            height: defaultBoxSize >= selectedBoxSize
                ? defaultBoxSize
                : selectedBoxSize,
            child: Row(
              mainAxisAlignment: alignment,
              children: getField(),
            ),
          ),
          defaultTextField(),
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
          FilteringTextInputFormatter.allow(RegExp(r'^[a-z]+$'))
        ],
        keyboardType: TextInputType.text,
        controller: textController,
        onChanged: onChange,
      ),
    );
  }

  BoxDecoration textFieldDecoration({required bool selected}) {
    return BoxDecoration(
      border: Border.all(color: selected ? Colors.black : Colors.grey),
      borderRadius: BorderRadius.circular(10.0),
    );
  }
}
