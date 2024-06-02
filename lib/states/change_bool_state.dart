import 'package:flutter/material.dart';

class ChangeBoolState extends ValueNotifier<bool> {
  ChangeBoolState() :super(true);

  void change() {
    if(value) {
      value = false;
    } else {
      value = true;
    }
  }
}