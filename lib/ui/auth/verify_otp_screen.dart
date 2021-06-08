import 'package:flutter/material.dart';
import 'package:priyo_quiz/utils/text.dart';

class VerifyOtpScreen extends StatefulWidget {
  static const routeName = "/verify-otp";

  const VerifyOtpScreen({ Key? key }) : super(key: key);

  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            child: xText(text: "VerifyOtpScreen"),
          )
        ],
      ),
    );
  }
}