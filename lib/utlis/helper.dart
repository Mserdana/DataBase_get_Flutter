import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin Helper {
  void showSnackBar(
      {required BuildContext context,
      required String content,
      bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        behavior: SnackBarBehavior.floating,
        backgroundColor: error ? Colors.red : Colors.green,
      ),
    );
  }
}
