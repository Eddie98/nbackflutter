import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nbackflutter/constants/index.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    final width = _mediaQueryData!.size.width;
    final webWidth = getWebScreenWidth(context);

    screenWidth = kIsWeb
        ? width <= webWidth
            ? width
            : webWidth
        : width;
    screenHeight = _mediaQueryData!.size.height;
    orientation = _mediaQueryData!.orientation;
  }
}

double getAdaptiveFontSize(double fontSize) {
  double screenWidth = SizeConfig.screenWidth!;
  // 360.0 is medium screen width
  return (fontSize / screenWidth) * screenWidth;
}

// Get the proportionate height as per screen size
double getPropScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth!;
  // 360 is the layout width that designer use
  return (inputWidth / screenWidth) * screenWidth;
}

double getWebScreenWidth(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;

  if (screenWidth > defaultWebFrame) return defaultWebFrame;
  return screenWidth;
}
