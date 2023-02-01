import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nbackflutter/constants/index.dart';
import 'package:nbackflutter/utils/index.dart';

import '../bloc/settings_bloc.dart';

void showAlertDialog({
  required BuildContext context,
  required List<int> options,
  required int selectedOption,
  required int root,
}) {
  late String additionalText;

  if (root == 0) {
    additionalText = attemptsText;
  } else if (root == 1) {
    additionalText = secondsText;
  } else if (root == 2) {
    additionalText = itemsbackText;
  } else if (root == 3) {
    additionalText = dimensionsText;
  }

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
          width: getWebScreenWidth(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(options.length, (index) {
              final option = options[index];

              final isSelected = option == selectedOption;

              return ListTile(
                onTap: () {
                  late final SettingsChangeEvent event;

                  if (root == 0) {
                    event = SettingsChangeEvent(totalAttemptsOption: option);
                  } else if (root == 1) {
                    event = SettingsChangeEvent(
                      intervalBetweenAttemptsOption: option,
                    );
                  } else if (root == 2) {
                    event = SettingsChangeEvent(nBackValueOption: option);
                  } else if (root == 3) {
                    event = SettingsChangeEvent(dimensionOption: option);
                  }

                  context.read<SettingsBloc>().add(event);
                  Navigator.pop(context);
                },
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
