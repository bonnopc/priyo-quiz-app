import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:priyo_quiz/constants/colors.dart';
import 'package:priyo_quiz/constants/objects.dart';
import 'package:priyo_quiz/constants/sharedpref_keys.dart';
import 'package:priyo_quiz/services/shared_preference.dart';
import 'package:priyo_quiz/ui/auth/cubit/authentication_cubit.dart';
import 'package:priyo_quiz/ui/dashboard/dashboard_screen.dart';
import 'package:priyo_quiz/utils/button.dart';
import 'package:priyo_quiz/utils/loader.dart';
import 'package:priyo_quiz/utils/locator.dart';
import 'package:priyo_quiz/utils/margin.dart';
import 'package:priyo_quiz/utils/snackbar.dart';

class VerifyPhoneScreen extends StatefulWidget {
  static const routeName = "/verify-phone-number";

  const VerifyPhoneScreen({ Key? key }) : super(key: key);

  @override
  _VerifyPhoneScreenState createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  final textController = TextEditingController();
  final otpController = TextEditingController();
  bool isCreatedOtp = false;
  late FocusNode otpFocusNode;

  @override
  void initState() {
    logToken();
    super.initState();
    
    otpFocusNode = FocusNode();
  }

  void logToken() async {
    final _token = await SharedPreferenceManager.instance.getString(SharedPrefKeys.ACCESS_TOKEN);
    log(_token);
  }

  @override
  void dispose() {
    textController.dispose();
    otpController.dispose();
    otpFocusNode.dispose();
    super.dispose();
  }

  bool isValidInput(){
    final _phoneNo = textController.text;
    final _otp = otpController.text;
    // print("phoneNo.length >= 10 ${phoneNo.length >= 10}");
    if(!isCreatedOtp) return _phoneNo.length >= 10;
    else return isCreatedOtp && _phoneNo.length >= 10 && _otp.length == 6;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationCubit>(
      create: (ctx) => AuthenticationCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: blocks.size(20)
          ),
          child: Align(
            alignment: Alignment.center,
            child: BlocConsumer<AuthenticationCubit,AuthenticationState>(
              listener: (_,state){
                if(state is CreateOtpError){
                  showSnackBar("Something went wrong!");
                } else if(state is CreateOtpSuccess){
                  setState(() {
                    isCreatedOtp = true;
                  });
                  otpFocusNode.requestFocus();
                  showSnackBar("You will have an OTP on your phone very soon!");
                } else if(state is VerifyOtpSuccess){
                  showSnackBar("Your mobile number is now verified!");
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    DashboardScreen.routeName, (route) => false);
                }
              },
              builder: (ctx,state) {
                if(state is CreateOtpLoading){
                  Center(child: LoadingIndicator());
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: textController,
                      decoration: InputDecoration(
                        labelText: "Enter your mobile number",
                        prefixText: "+880"
                      ),
                      keyboardType: TextInputType.number,
                      autofocus: true,
                    ),
                    margin(y: 20),
                    isCreatedOtp ?
                    TextFormField(
                      focusNode: otpFocusNode,
                      controller: otpController,
                      decoration: InputDecoration(
                        labelText: "Enter your 6 digits OTP",
                      ),
                      keyboardType: TextInputType.number,
                    ) : SizedBox.shrink(),
                    isCreatedOtp ? margin(y: 20) : SizedBox.shrink(),
                    xButton(
                      label: "Submit",
                      width: double.infinity,
                      color: ColorsX.primaryOrange,
                      onPressed: (){
                        if(!isValidInput()){
                          showSnackBar("Please enter a valid mobile number");
                        } else {
                          ctx.read<AuthenticationCubit>().createOtpOrVerify(
                            phoneNo: textController.text,
                            otp: otpController.text
                          );
                        }
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