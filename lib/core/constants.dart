import 'package:flutter/cupertino.dart';

///keys for hive for boxes for 4,5,6 letters words
String hiveKey4LettersEn = '4lettersEn';
String hiveKey5LettersEn = '5lettersEn';
String hiveKey6LettersEn = '6lettersEn';
String hiveKey4LettersUa = '4lettersUa';
String hiveKey5LettersUa = '5lettersUa';
String hiveKey6LettersUa = '6lettersUa';

double verticalPadding({
  required BuildContext context,
  required double pixels,
}) {
  final screenWidth = MediaQuery.of(context).size.height;
  final result = screenWidth * pixels * _onePxHeightCoefficient;
  return result;
}

double horizontalPadding({
  required BuildContext context,
  required double pixels,
}) {
  final screenWidth = MediaQuery.of(context).size.width;
  final result = screenWidth * pixels * _onePxWidthCoefficient;
  return result;
}

///1px of total height from iphone 14
double _onePxHeightCoefficient = .00118;

///1px of total width from iphone 14
double _onePxWidthCoefficient = .0026;
