import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:priyo_quiz/constants/colors.dart';
import 'package:priyo_quiz/constants/objects.dart';
import 'package:priyo_quiz/constants/sharedpref_keys.dart';
import 'package:priyo_quiz/services/navigation/navigation_service.dart';
import 'package:priyo_quiz/services/shared_preference.dart';
import 'package:priyo_quiz/ui/auth/cubit/authentication_cubit.dart';
import 'package:priyo_quiz/ui/auth/data/models/user.dart';
import 'package:priyo_quiz/ui/auth/data/user_info.dart';
import 'package:priyo_quiz/ui/auth/login_options_screen.dart';
import 'package:priyo_quiz/ui/dashboard/dashboard_screen.dart';
import 'package:priyo_quiz/utils/locator.dart';
import 'package:priyo_quiz/utils/size_config.dart';
import 'package:priyo_quiz/utils/text.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';

  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  _initSettings() {
    SharedPreferenceManager.instance.create();
    // networkConnectivity.initialise();
  }

  Future<void> _initPlatformState() async {
    try {
      if (Platform.isAndroid) {
        _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      print("'Error:': 'Failed to get platform info.'");
    }
  }

  void _initPlatformAndSettings(){
    _initSettings();
    _initPlatformState();
  }

  void _setBlockConfig() {
    blocks.init(context);
    scale.init(context);
    ScreenUtil.init(
      BoxConstraints(
        maxHeight: BlockConfiguration.screenHeight,
        maxWidth: BlockConfiguration.screenWidth
      ),
    );
  }

  _readAndroidBuildData(AndroidDeviceInfo data) {
    userInfo.deviceId = data.androidId;
    userInfo.deviceType = "android";
  }

  _readIosDeviceInfo(IosDeviceInfo data) {
    userInfo.deviceId = data.identifierForVendor;
    userInfo.deviceType = "ios";
  }

  void _startTimer() {
    Future.delayed(Duration(milliseconds: 1000)).then((_) {
      _checkUserStatus();
    });
  }

  Future<void> _checkUserStatus() async {
    // check user info 
    final prefs = SharedPreferenceManager.instance;
    final bool _hasUserInfo = await prefs.contains(SharedPrefKeys.USER);

    if(_hasUserInfo){
      final _userInfo = await prefs.getString(SharedPrefKeys.USER);
      userInfo.setUserStream(UserProfile.fromJson(json.decode(_userInfo)));
      
      locator<NavigationService>().navigateTo(DashboardScreen.routeName, replace: true);
    }
    else locator<NavigationService>().navigateTo(LoginOptionsScreen.routeName, replace: true);
  }

  @override
  void initState() {
    _initPlatformAndSettings();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _setBlockConfig();
    _startTimer();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsX.primaryOrange,
      body: Center(
        child: xText(
          text: "Splash Screen",
          color: ColorsX.white
        ),
      ),
    );
  }
}