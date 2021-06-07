import 'package:flutter/material.dart';
import 'package:priyo_quiz/constants/objects.dart';

Widget xText({
  final String? text,
  final Color? color,
  final double? fontSize,
  final double? letterSpacing,
  final FontWeight? fontWeight,
  final TextOverflow? overflow,
  final TextAlign? textAlign,
  final TextDecoration? textDecoration,
  final bool? softWrap,
  final int? maxLine,
  final double? lineHeight
}) {
  return Text(
    "$text",
    overflow: overflow,
    textAlign: textAlign,
    softWrap: softWrap ?? null,
    maxLines: maxLine ?? null,
    style: TextStyle(
      color: color,
      fontSize: fontSize ?? scale.size(14),
      fontWeight: fontWeight ?? FontWeight.w400,
      letterSpacing: letterSpacing ?? null,
      decoration: textDecoration ?? null,
      height: lineHeight ?? null
    ),
  );
}

