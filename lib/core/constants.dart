import 'package:flutter/cupertino.dart';

///keys for hive for boxes for 4,5,6 letters words
String hiveKey4Letters = '4letters';
String hiveKey5Letters = '5letters';
String hiveKey6Letters = '6letters';

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
