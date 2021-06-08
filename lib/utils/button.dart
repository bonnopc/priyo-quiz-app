import 'package:flutter/material.dart';
import 'package:priyo_quiz/constants/colors.dart';
import 'package:priyo_quiz/constants/objects.dart';
import 'package:priyo_quiz/utils/margin.dart';
import 'package:priyo_quiz/utils/text.dart';

Widget xButton(
    {final String? label,
    final GestureTapCallback? onPressed,
    final bool hasBorder = false,
    final double? width,
    final double? height,
    final double radius = 40,
    final double? fontSize,
    final FontWeight? fontWeight,
    final double? iconSize,
    final Color? color,
    final Color? textColor,
    final Color? iconColor,
    final Color? strokeColor,
    final MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    final EdgeInsets? padding,
    final bool isDisabled = false,
    final Widget? child,
    final Widget? icon}) {
  return Container(
    decoration: hasBorder
        ? BoxDecoration(
            border: strokeColor == null ? null : Border.all(color: strokeColor),
            borderRadius: BorderRadius.circular(radius),
          )
        : null,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Material(
          color: isDisabled ? ColorsX.dimWhite : color ?? ColorsX.primaryRed,
          child: InkWell(
            onTap: onPressed,
            child: Container(
              height: height ?? blocks.size(50),
              width: width ?? blocks.size(150),
              padding: padding,
              child: Center(
                child: child ?? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: mainAxisAlignment,
                  children: [
                    icon != null ? 
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: blocks.size(10)
                      ),
                      child: icon,
                    ) : Container(),
                    margin(x: icon != null ? 14 : 0),
                    xText(
                      text: label != null ? label.toUpperCase() : "",
                      color: isDisabled ? ColorsX.lightGrey : textColor ?? Colors.white,
                      fontWeight: fontWeight ?? FontWeight.w600,
                      fontSize: scale.size(fontSize ?? 14),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          )),
    ),
  );
}
