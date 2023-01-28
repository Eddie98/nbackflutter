import 'package:flutter/material.dart';
import 'package:nbackflutter/utils/index.dart';

class ArrowBackBtnWidget extends StatelessWidget {
  final VoidCallback onTap;

  const ArrowBackBtnWidget(this.onTap, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      iconSize: getPropScreenWidth(26.0),
      splashRadius: getPropScreenWidth(26.0),
      icon: const Icon(Icons.arrow_back_ios),
    );
  }
}
