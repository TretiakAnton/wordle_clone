import 'package:flutter/material.dart';
import 'package:wordle_clone/wordle_app.dart';

class OrdinarySnackbar {
  void showSnackBar({
    required String label,
    EdgeInsetsGeometry? margin,
    Function()? onPop,
    Color color = Colors.red,
  }) {
    final snackBar = SnackBar(
      margin: margin ?? const EdgeInsets.only(
        bottom: 20,
        left: 10,
        right: 10,
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 5,
      dismissDirection: DismissDirection.down,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
      backgroundColor: color,
      content: Center(child: Text(label)),
    );

    materialAppKey.currentState?.hideCurrentSnackBar();
    materialAppKey.currentState
        ?.showSnackBar(snackBar)
        .closed
        .then((SnackBarClosedReason reason) {
      onPop != null ? onPop() : () {};
    });
  }
}