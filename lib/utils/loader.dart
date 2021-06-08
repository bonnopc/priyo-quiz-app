import 'package:flutter/material.dart';
import 'package:priyo_quiz/constants/colors.dart';
import 'package:priyo_quiz/constants/objects.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  final Color color;

  LoadingIndicator({
    Key? key, 
    this.size = 24.0, 
    this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      height: scale.size(size),
      width: scale.size(size),
      child: new CircularProgressIndicator(
        backgroundColor: ColorsX.primaryRed,
        valueColor: new AlwaysStoppedAnimation<Color>(color),
        value: null,
        strokeWidth: 3.0,
      ),
    );
  }
}