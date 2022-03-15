import 'package:flutter/material.dart';

class CircularContainer {
  double containerSize;
  List<Color> containerColors;
  double containerOpacity;
  Widget? containerChild;

  CircularContainer(
    this.containerSize,
    this.containerColors,
    this.containerOpacity,
    this.containerChild,
  );
}
