import 'package:flutter/material.dart';

enum BaseColor {
  white,
  black,
  red,
  green,
  yellow,
  purple,
  violet,
  brown,
  maroon;

  static BaseColor? getEnumFromLabel(String colorLabel) {
    for (final color in BaseColor.values) {
      if (color.name == colorLabel.toLowerCase().trim()) {
        return color;
      }
    }
    return null;
  }

  Color? getFromLabel(String colorLabel) {
    for (final color in BaseColor.values) {
      if (color.name == colorLabel.toLowerCase().trim()) {
        return color.getColorFromEnum();
      }
    }
    return null;
  }

  Color getColorFromEnum() => switch (this) {
    BaseColor.white => Colors.white,

    BaseColor.black => Colors.black,

    BaseColor.red => Colors.red,

    BaseColor.green => Colors.green,

    BaseColor.yellow => Colors.yellow,

    BaseColor.purple => Colors.purple,

    BaseColor.violet => Colors.purpleAccent,

    BaseColor.brown => Colors.brown,

    BaseColor.maroon => Color(0xFF550000),
  };
}
