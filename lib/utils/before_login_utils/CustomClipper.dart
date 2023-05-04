
import 'package:flutter/material.dart';

class CustomClipPath extends CustomClipper<Path> {
  var radius = 5.0;
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    Path path0 = Path();
    path0.moveTo(w/6,0);
    path0.lineTo(0,h/2);
    path0.lineTo(w/6,h);
    path0.lineTo(w,h);
    path0.lineTo(w,0);
    path0.lineTo(w/6,0);
    path0.close();
    return path0;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
