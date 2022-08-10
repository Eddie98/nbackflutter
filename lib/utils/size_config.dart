import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    orientation = _mediaQueryData!.orientation;
  }
}

double getAdaptiveFontSize(double fontSize) {
  double screenWidth = SizeConfig.screenWidth!;
  // 360.0 is medium screen width
  return (fontSize / 360.0) * screenWidth;
}

// Get the proportionate height as per screen size
double getPropScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth!;
  // 360 is the layout width that designer use
  return (inputWidth / 360.0) * screenWidth;
}
