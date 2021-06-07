import 'package:flutter/material.dart';
import 'package:priyo_quiz/constants/colors.dart';
import 'package:priyo_quiz/utils/appbar.dart';
import 'package:priyo_quiz/utils/button.dart';
import 'package:priyo_quiz/utils/text.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = "/dashboard";

  const DashboardScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: pqAppbar(context, "Dashboard", false),
        body: Center(
          child: xText(text: "Hello"),
        ),
        bottomNavigationBar: SafeArea(child: Container(
          color: ColorsX.primaryRed,
          child: xButton(
            label: "Bottom"
          ),
        )),
      );
  }
}