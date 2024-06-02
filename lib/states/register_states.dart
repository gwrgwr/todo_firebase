import 'package:flutter/material.dart';

class RegisterStates extends ValueNotifier<bool> {
  RegisterStates() : super(true);

  changeVisibility() {
    if (value) {
      value = false;
    } else {
      value = true;
    }
  }
}
