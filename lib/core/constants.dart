import 'package:flutter/cupertino.dart';

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
