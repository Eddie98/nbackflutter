import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nbackflutter/constants/index.dart';

class SwitchListItemWidget extends StatelessWidget {
  final String title;
  final bool value;
  final VoidCallback onChanged;

  const SwitchListItemWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onChanged,
      title: Text(
        title,
        style: TextStyles.settingsPageTS(),
      ),
      trailing: CupertinoSwitch(
        activeColor: AppColors.themeColor,
        value: value,
        onChanged: (_) => onChanged(),
      ),
    );
  }
}
