import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:priyo_quiz/constants/objects.dart';
import 'package:priyo_quiz/services/navigation/navigation_service.dart';
import 'package:priyo_quiz/services/shared_preference.dart';
import 'package:priyo_quiz/ui/dashboard/dashboard_screen.dart';
import 'package:priyo_quiz/utils/locator.dart';
import 'package:priyo_quiz/utils/size_config.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';

  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  _initSettings() {
    SharedPreferenceManager.instance.create();
    // networkConnectivity.initialise();
  }

  Future<void> _initPlatformState() async {
    try {
      if (Platform.isAndroid) {
        // _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        // _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
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

  void _startTimer() {
    Future.delayed(Duration(milliseconds: 1000)).then((_) {
      _checkUserStatus();
    });
  }

  Future<void> _checkUserStatus() async {
    // check user info here
    locator<NavigationService>().navigateTo(DashboardScreen.routeName, replace: true);
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
    return Center(
      child: Text("Splash Screen"),
    );
  }
}