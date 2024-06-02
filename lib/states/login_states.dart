import 'package:flutter/material.dart';

class LoginStates extends ValueNotifier<bool> {
  LoginStates() :super(true);

  changeVisibility() {
    if(value) {
      value = false;
    } else {
      value = true;
    }
  }
}