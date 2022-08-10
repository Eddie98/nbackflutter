import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/material.dart';

// makes print() colorful // 1 - red, 2 - green, 3 - blue
cprint(dynamic msg, {int? color = 2}) {
  ansiColorDisabled = false;
  AnsiPen pen = AnsiPen();
  pen.white();
  switch (color) {
    case 0:
      pen.rgb(r: 1.0, g: 0.6, b: 0.2);
      break;
    case 1:
      pen.rgb(r: 0.6, g: 1.0, b: 0.2);
      break;
    default:
      pen.rgb(r: 0.2, g: 0.6, b: 1.0);
  }

  debugPrint(pen(msg.toString()));
}
