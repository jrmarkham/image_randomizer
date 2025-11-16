import 'package:dominant_color_detector/dominant_color_detector.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:random_photo/src/globals/enum.dart';

mixin PhotoCubitMixin {


  Color getColorFromDominateResults (List<DominantColorStat> dominateColor) {


   for (final item in dominateColor) {
     if (item.color.color != Colors.white &&
         item.color.color != Colors.black) {
       return item.color.color;
     }
   }

   // create random color
   return Colors.green;

  }


}