import 'package:flutter/material.dart';

// ignore: camel_case_types
class SliderProvider with ChangeNotifier {
  int _current = 0;
  int get current => _current;

  void setIndex(index) {
    _current = index;
    notifyListeners();
  }
}
