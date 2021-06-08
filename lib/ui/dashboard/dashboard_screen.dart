import 'package:flutter/material.dart';
import 'package:priyo_quiz/constants/colors.dart';
import 'package:priyo_quiz/constants/objects.dart';
import 'package:priyo_quiz/ui/auth/data/models/user.dart';
import 'package:priyo_quiz/ui/auth/data/user_info.dart';
import 'package:priyo_quiz/ui/auth/login_options_screen.dart';
import 'package:priyo_quiz/ui/auth/verify_phone_screen.dart';
import 'package:priyo_quiz/utils/appbar.dart';
import 'package:priyo_quiz/utils/button.dart';
import 'package:priyo_quiz/utils/loader.dart';
import 'package:priyo_quiz/utils/locator.dart';
import 'package:priyo_quiz/utils/margin.dart';
import 'package:priyo_quiz/utils/text.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = "/dashboard";

  const DashboardScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: pqAppbar(context, "Dashboard", false),
      body: StreamBuilder(
        stream: userInfo.userDetails,
        builder: (ctx, AsyncSnapshot<UserProfile> snapshot){
          print("snapshot.data ===> ${snapshot.data}");
          if(snapshot.hasData && snapshot.data != null){
            return _buildDashboard(snapshot.data,context);
          }

          return Center(child: LoadingIndicator());
        },
      )
    );
  }

  Widget _buildDashboard(UserProfile? user,BuildContext ctx){
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          xText(
            text: "Hello, ${user?.userData?.profile?.name}",
          ),
          xText(
            text: "Welcome to Priyo Quiz!".toUpperCase(),
            fontSize: scale.size(18)
          ),
          margin(y: 100),
          xButton(
            label: "Verify Phone",
            color: ColorsX.dimWhite,
            textColor: ColorsX.textBlack,
            onPressed: (){
              Navigator.pushNamed(ctx, VerifyPhoneScreen.routeName);
            }
          ),
          margin(y: 15),
          xButton(
            label: "Logout",
            icon: Icon(Icons.logout_outlined),
            color: ColorsX.dimWhite,
            textColor: ColorsX.textBlack,
            onPressed: (){
              Navigator.pushNamedAndRemoveUntil(ctx, 
                LoginOptionsScreen.routeName, (route) => false);
              userInfo.logout();
            }
          )
        ],
    ));
  }
}