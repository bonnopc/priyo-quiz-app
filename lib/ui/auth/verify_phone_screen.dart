import 'package:flutter/material.dart';
import 'package:priyo_quiz/utils/text.dart';

class VerifyPhoneScreen extends StatefulWidget {
  static const routeName = "/verify-phone-number";

  const VerifyPhoneScreen({ Key? key }) : super(key: key);

  @override
  _VerifyPhoneScreenState createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            child: xText(text: "VerifyPhoneScreen"),
          )
        ],
      ),
    );
  }
}