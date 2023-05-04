import 'package:flutter/material.dart';

class ScrollState with ChangeNotifier {
  bool _isScrolling = false;

  bool get isScrolling => _isScrolling;

  void updateScrolling(bool value) {
    _isScrolling = value;
    notifyListeners();
  }
}