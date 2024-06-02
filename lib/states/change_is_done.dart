import 'package:flutter/material.dart';

class ChangeIsDone extends ValueNotifier<bool> {
  ChangeIsDone() :super(false);

  void change() {
    if (value) {
      value = false;
    } else {
      value = true;
    }
  }
}