import 'package:flutter/material.dart';
import 'package:nbackflutter/constants/index.dart';
import 'package:nbackflutter/utils/index.dart';

void showAlertDialog({
  required BuildContext context,
  required List<int> options,
  required int selectedOption,
  required int root,
}) {
  final size = MediaQuery.of(context).size;
  final additionalText = root == 0
      ? attemptsText
      : root == 1
          ? secondsText
          : itemsbackText;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.almostBlackColor,
        title: Text(
          chooseOptionsText,
          textAlign: TextAlign.center,
          style: const TextStyle().copyWith(
            color: Colors.white,
          ),
        ),
        titlePadding: EdgeInsets.symmetric(
          vertical: getPropScreenWidth(defaultHorPadding),
        ),
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(options.length, (index) {
              final option = options[index];

              final isSelected = option == selectedOption;

              return ListTile(
                onTap: () {},
                minLeadingWidth: defaultHorPadding,
                title: Text(
                  '$option $additionalText',
                  style: const TextStyle().copyWith(
                    color: Colors.white,
                  ),
                ),
                leading: Icon(
                  isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: isSelected
                      ? AppColors.themeColor
                      : AppColors.mainGreyColor,
                ),
              );
            }),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              cancelText,
              style: TextStyles.allColorPositionTS().copyWith(
                color: AppColors.themeColor,
              ),
            ),
          ),
        ],
      );
    },
  );
}
