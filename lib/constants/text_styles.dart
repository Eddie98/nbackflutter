import 'package:flutter/material.dart';
import 'package:nbackflutter/utils/index.dart';

class TextStyles {
  static TextStyle mainDescriptionTS() => TextStyle(
        color: Colors.white,
        fontSize: getAdaptiveFontSize(17.0),
      );
  static TextStyle trainingFooterButtonsTS() => TextStyle(
        color: Colors.black,
        fontSize: getAdaptiveFontSize(15.0),
        fontWeight: FontWeight.w600,
      );
  static TextStyle allColorPositionTS() => TextStyle(
        color: Colors.white,
        fontSize: getAdaptiveFontSize(17.0),
        fontWeight: FontWeight.w600,
      );
  static TextStyle settingsPageTS() => TextStyle(
        color: Colors.white,
        fontSize: getAdaptiveFontSize(17.0),
        fontWeight: FontWeight.w500,
      );
}
