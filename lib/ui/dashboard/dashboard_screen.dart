import 'package:flutter/material.dart';
import 'package:priyo_quiz/utils/text.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = "/dashboard";

  const DashboardScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: xText(text: "Hello, User! It's your Dashboard!!"),
    ));
  }
}