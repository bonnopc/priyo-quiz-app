import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:priyo_quiz/constants/objects.dart';
import 'package:priyo_quiz/main.dart';
import 'package:priyo_quiz/utils/text.dart';

showSnackBar(String msg) {
  // var currentScaffoldMessengerKey = globalScaffoldMessengerKey.currentState;
  var currentScaffold = globalScaffoldKey.currentState;
  
  currentScaffold?.hideCurrentSnackBar(); // If there is a snackbar visible, hide it before the new one is shown.
  currentScaffold?.showSnackBar(SnackBar(
    backgroundColor: Colors.black87,
    content: xText(
      text: msg,
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: scale.size(16),
    ),
    duration: Duration(seconds: 2),
  ));
}
