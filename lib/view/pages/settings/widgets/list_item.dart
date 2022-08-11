import 'package:flutter/material.dart';
import 'package:nbackflutter/constants/index.dart';

class ListItemWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback onTap;

  const ListItemWidget({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: TextStyles.settingsPageTS(),
      ),
      subtitle: Text(
        subTitle,
        style: TextStyles.settingsPageTS().copyWith(
          color: AppColors.mainGreyColor,
          fontSize: TextStyles.settingsPageTS().fontSize! - 2,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
