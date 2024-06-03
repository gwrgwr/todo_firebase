import 'package:flutter/material.dart';

class MySnackbar {
  static SnackBar mySnackBar() {
    return const SnackBar(
      
      behavior: SnackBarBehavior.floating,
      content: Text(
        'Os campos são obrigatórios!',
      ),
    );
  }
}
