import 'package:dominant_color_detector/dominant_color_detector.dart';
import 'package:flutter/material.dart';

mixin PhotoCubitMixin {
  Color getColorFromDominateResults({required List<DominantColorStat> dominateColor, required Color lastColor}) {
    for (final item in dominateColor) {
      if (item.color.color != Colors.white && item.color.color != Colors.black && item.color.color != lastColor) {
        return item.color.color;
      }
    }
    return lastColor;
  }
}
