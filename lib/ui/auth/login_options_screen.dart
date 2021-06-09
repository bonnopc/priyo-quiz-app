import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:priyo_quiz/constants/colors.dart';
import 'package:priyo_quiz/constants/objects.dart';
import 'package:priyo_quiz/constants/resources.dart';
import 'package:priyo_quiz/services/firebase_auth.dart';
import 'package:priyo_quiz/services/navigation/navigation_service.dart';
import 'package:priyo_quiz/ui/auth/cubit/authentication_cubit.dart';
import 'package:priyo_quiz/ui/auth/verify_phone_screen.dart';
import 'package:priyo_quiz/ui/dashboard/dashboard_screen.dart';
import 'package:priyo_quiz/utils/appbar.dart';
import 'package:priyo_quiz/utils/button.dart';
import 'package:priyo_quiz/utils/loader.dart';
import 'package:priyo_quiz/utils/locator.dart';
import 'package:priyo_quiz/utils/margin.dart';
import 'package:priyo_quiz/utils/navigation.dart';
import 'package:priyo_quiz/utils/snackbar.dart';
import 'package:priyo_quiz/utils/text.dart';

class LoginOptionsScreen extends StatelessWidget {
  static const routeName = "/login-options";

  const LoginOptionsScreen({ Key? key }) : super(key: key);

  // void _authWithFirebase(SocialLoginType type){
  //   FirebaseAuthService().handleSignIn(type).then((value) => {
  //     if(value != null){
  //       print("Login success $value")
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationCubit>(
      create: (ctx) => AuthenticationCubit(),
      child: Scaffold(
        backgroundColor: ColorsX.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: blocks.size(30),
            ),
            child: BlocConsumer<AuthenticationCubit,AuthenticationState>(
              listener: (_,state) {
                if(state is AuthenticationSuccess){
                  if(state.user?.userData?.isMobileVerified == true){
                    Navigator.pushNamedAndRemoveUntil(
                      context, DashboardScreen.routeName, (route) => false);
                  } else {
                    Navigator.pushNamedAndRemoveUntil(
                      context, VerifyPhoneScreen.routeName, (route) => false);
                  }
                  
                } else if (state is AuthenticationError){
                  showSnackBar("Something went wrong!");
                }
              },
              builder: (ctx,state) {
                if(state is AuthenticationLoading){
                  return Center(
                    child: LoadingIndicator(),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Res.logo_square, width: scale.size(60)),
                    xText(
                      text: "Priyo Quiz",
                      fontSize: scale.size(18),
                      color: ColorsX.primaryRed,
                      fontWeight: FontWeight.w600
                    ),
                    margin(y: 80),
                    // xButton(
                    //   label: "Login with Facebook",
                    //   icon: SvgPicture.asset(Res.ic_fb, 
                    //     height: scale.size(24)),
                    //   color: ColorsX.facebook,
                    //   onPressed: (){
                    //     print("Login with facebook!!!");
                    //   }
                    // ),
                    // margin(y: 20),
                    xButton(
                      label: "Login with Google",
                      icon: Image.asset(Res.ic_google),
                      color: ColorsX.white,
                      textColor: ColorsX.textBlack,
                      width: double.infinity,
                      hasBorder: true,
                      strokeColor: ColorsX.textHint,
                      onPressed: (){
                        ctx.read<AuthenticationCubit>()
                          .handleSocialLogin(SocialLoginType.google);
                      }
                    )
                  ],
                );
              })
          )
        )
    ));
  }
}