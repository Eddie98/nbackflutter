import 'package:flutter/material.dart';
import 'package:nbackflutter/constants/index.dart';
import 'package:nbackflutter/utils/index.dart';
import 'package:nbackflutter/view/widgets/index.dart';

import 'widgets/list_item.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: ArrowBackBtnWidget(
          () => Navigator.of(context).pop(),
        ),
        title: const Text(settingsText),
      ),
      body: Column(
        children: [
          ListItemWidget(
            title: totalAttemptsText,
            subTitle: '25 $attemptsText. $clickToChangeText',
            onTap: () {},
          ),
          ListItemWidget(
            title: intervalBetweenAttemptsText,
            subTitle: '2 $secondsText. $clickToChangeText',
            onTap: () {},
          ),
          ListItemWidget(
            title: nBackValueText,
            subTitle: '2 $itemsbackText. $clickToChangeText',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
