import 'package:flutter/material.dart';

class MySnackbar {
  static SnackBar mySnackBar({required String text}) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(
        text,
      ),
    );
  }
}
