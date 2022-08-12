import 'package:flutter/material.dart';
import 'package:nbackflutter/routes.dart';
import 'package:nbackflutter/utils/index.dart';

import '../pages/settings/settings.dart';

class SettingsButton extends StatelessWidget {
  final bool isFromTrainingScreen;

  const SettingsButton({
    Key? key,
    this.isFromTrainingScreen = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (isFromTrainingScreen) {
          Navigator.of(context).pushReplacement(
            Routes.fadeThrough(
              (context) => SettingsPage(
                isFromTrainingScreen: isFromTrainingScreen,
              ),
            ),
          );
        } else {
          Navigator.of(context).push(
            Routes.fadeThrough(
              (context) => SettingsPage(
                isFromTrainingScreen: isFromTrainingScreen,
              ),
            ),
          );
        }
      },
      iconSize: getPropScreenWidth(26.0),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      icon: const Icon(Icons.settings),
    );
  }
}
