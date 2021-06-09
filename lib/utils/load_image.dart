import 'package:priyo_quiz/constants/objects.dart';
import 'package:flutter/material.dart';

Widget loadImage({
  required double height,
  required double width,
  BoxFit? boxFit,
  required String url,
  Alignment? alignment,
}) {
  return Container(
    height: blocks.size(height),
    width: blocks.size(width),
    decoration: BoxDecoration(
      image: DecorationImage(
        fit: boxFit ?? BoxFit.cover,
        alignment: alignment ?? Alignment.center,
        image: NetworkImage(url),
      ),
    ),
  );
}

Widget resImage({
  required double height,
  required String path,
}) {
  return Container(
    height: blocks.size(height),
    decoration: BoxDecoration(image: DecorationImage(image: AssetImage(path))),
  );
}
