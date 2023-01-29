import 'package:flutter/material.dart';
import 'package:nbackflutter/utils/index.dart';

class TextStyles {
  static TextStyle mainDescriptionTS() => TextStyle(
        color: Colors.white,
        fontSize: getAdaptiveFontSize(19.0),
      );
  static TextStyle trainingFooterButtonsTS() => TextStyle(
        color: Colors.black,
        fontSize: getAdaptiveFontSize(17.0),
        fontWeight: FontWeight.w600,
      );
  static TextStyle allColorPositionTS() => TextStyle(
        color: Colors.white,
        fontSize: getAdaptiveFontSize(19.0),
        fontWeight: FontWeight.w600,
      );
  static TextStyle settingsPageTS() => TextStyle(
        color: Colors.white,
        fontSize: getAdaptiveFontSize(19.0),
        fontWeight: FontWeight.w500,
      );
  static TextStyle boardIndexText() => TextStyle(
        color: Colors.black45,
        fontSize: getAdaptiveFontSize(30.0),
        fontWeight: FontWeight.w500,
      );
}
