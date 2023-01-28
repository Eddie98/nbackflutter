import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nbackflutter/constants/index.dart';
import 'package:nbackflutter/routes.dart';
import 'package:nbackflutter/utils/index.dart';
import 'package:nbackflutter/view/widgets/index.dart';

import 'bloc/settings_bloc.dart';
import 'widgets/dialog.dart';
import 'widgets/list_item.dart';

class SettingsPage extends StatelessWidget {
  final bool isFromTrainingScreen;

  const SettingsPage({
    Key? key,
    required this.isFromTrainingScreen,
  }) : super(key: key);

  Future<bool> _backBtnHandle(BuildContext context) {
    Navigator.pop(context);
    if (isFromTrainingScreen) {
      Navigator.of(context).pushNamed(Routes.trainingLink);
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        SizeConfig().init(context);

        return WillPopScope(
          onWillPop: () => _backBtnHandle(context),
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              leading: ArrowBackBtnWidget(() => _backBtnHandle(context)),
              title: const Text(settingsText),
            ),
            body: BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                if (state is SettingsMainState) {
                  return Column(
                    children: [
                      ListItemWidget(
                        title: totalAttemptsText,
                        subTitle:
                            '${state.totalAttempts} $attemptsText. $clickToChangeText',
                        onTap: () => showAlertDialog(
                          context: context,
                          options: totalAttemptsOptions,
                          selectedOption: state.totalAttempts,
                          root: 0,
                        ),
                      ),
                      ListItemWidget(
                        title: intervalBetweenAttemptsText,
                        subTitle:
                            '${state.intervalBetweenAttempts} $secondsText $clickToChangeText',
                        onTap: () => showAlertDialog(
                          context: context,
                          options: intervalBetweenAttemptsOptions,
                          selectedOption: state.intervalBetweenAttempts,
                          root: 1,
                        ),
                      ),
                      ListItemWidget(
                        title: nBackValueText,
                        subTitle:
                            '${state.nBackValue} $itemsbackText. $clickToChangeText',
                        onTap: () => showAlertDialog(
                          context: context,
                          options: nBackValueOptions,
                          selectedOption: state.nBackValue,
                          root: 2,
                        ),
                      ),
                      ListTile(
                        onTap: () => context.read<SettingsBloc>().add(
                            SettingsChangeEvent(zenModeOption: !state.zenMode)),
                        title: Text(
                          zenModeText,
                          style: TextStyles.settingsPageTS(),
                        ),
                        trailing: CupertinoSwitch(
                          activeColor: AppColors.themeColor,
                          value: state.zenMode,
                          onChanged: (_) => context.read<SettingsBloc>().add(
                              SettingsChangeEvent(
                                  zenModeOption: !state.zenMode)),
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      },
    );
  }
}
