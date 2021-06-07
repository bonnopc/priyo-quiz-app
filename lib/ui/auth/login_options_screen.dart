import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:priyo_quiz/constants/colors.dart';
import 'package:priyo_quiz/constants/objects.dart';
import 'package:priyo_quiz/constants/resources.dart';
import 'package:priyo_quiz/utils/appbar.dart';
import 'package:priyo_quiz/utils/button.dart';
import 'package:priyo_quiz/utils/margin.dart';
import 'package:priyo_quiz/utils/text.dart';

class LoginOptionsScreen extends StatelessWidget {
  static const routeName = "/login-options";

  const LoginOptionsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsX.primaryOrange,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: blocks.size(30),
            right: blocks.size(30),
            top: blocks.size(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                Res.img_man_perspective),
              margin(y: 30),
              xButton(
                label: "Login with Facebook",
                icon: SvgPicture.asset(Res.ic_fb, 
                  height: scale.size(24)),
                color: ColorsX.facebook,
                onPressed: (){
                  print("Login with facebook!!!");
                }
              ),
              margin(y: 20),
              xButton(
                label: "Login with Google",
                icon: Image.asset(Res.ic_google),
                color: ColorsX.white,
                textColor: ColorsX.textBlack,
                onPressed: (){
                  print("Login with google!!!");
                }
              )
            ],
          )
        )
      )
    );
  }
}