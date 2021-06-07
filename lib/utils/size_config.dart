import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BlockConfiguration {
  static MediaQueryData _mediaQueryData = MediaQueryData();
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double screenMagnitude = 0;
  static double blockSizeHorizontal = 0;
  static double blockSizeVertical = 0;
  static double blockSizeMagnitude = 0;
  static Orientation orientation = Orientation.portrait;

  double getWidth() {
    return screenWidth;
  }

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    screenMagnitude = _mediaQueryData.size.shortestSide;
    orientation = _mediaQueryData.orientation;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    print("BLOCKS CONFIGURE");
    print(_mediaQueryData);
    print(screenHeight);
    print(screenWidth);
    print(screenMagnitude);
    print(blockSizeHorizontal);
    print(blockSizeVertical);
  }

  double size(double blocks) {
    return blockSizeHorizontal * blocks * getX();
  }

  num getX() {
    var deviceType = getDeviceType(_mediaQueryData.size);
    var value;
    switch (deviceType) {
      case DeviceScreenType.mobile:
        value = 0.26;
        break;
      default:
        value = 0.20;
        break;
    }
    return value;
  }
}

class ScalingConfiguration {
  static MediaQueryData _mediaQueryData = MediaQueryData();

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
  }

  double size(double size) {
    var deviceType = getDeviceType(_mediaQueryData.size);
    switch (deviceType) {
      case DeviceScreenType.mobile:
        return ScreenUtil().setSp(size);
      default:
        return ScreenUtil().setSp(size * 1.5);
    }
  }
}
