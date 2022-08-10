import 'package:flutter/material.dart';
import 'package:nbackflutter/utils/index.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      iconSize: getPropScreenWidth(26.0),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      icon: const Icon(Icons.settings),
    );
  }
}
