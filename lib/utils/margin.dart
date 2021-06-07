import 'package:flutter/material.dart';
import 'package:priyo_quiz/constants/objects.dart';

Widget margin({double x = 0, double y = 0}) {
  return SizedBox(
    width: blocks.size(x),
    height: blocks.size(y),
  );
}