import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nbackflutter/constants/index.dart';
import 'package:nbackflutter/routes.dart';
import 'package:nbackflutter/utils/index.dart';
import 'package:nbackflutter/view/screens/training/widgets/history_row.dart';
import 'package:nbackflutter/view/widgets/index.dart';

import '../../pages/settings/settings_repository.dart';
import 'bloc/training_bloc.dart';
import 'widgets/board.dart';
import 'widgets/counters_row.dart';
import 'widgets/footer_button.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({Key? key}) : super(key: key);

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  late final TrainingBloc trainingBloc;
  late final SettingsRepository settingsRepo;

  late bool isSingleDimension;

  @override
  void initState() {
    trainingBloc = context.read<TrainingBloc>();
    settingsRepo = context.read<SettingsRepository>();

    isSingleDimension = settingsRepo.dimension == 1;

    trainingBloc.add(const TrainingInitialEvent());
    Future.delayed(const Duration(seconds: initialSecondsDelay), () {
      timerCallback(1);
      Timer.periodic(
        Duration(seconds: settingsRepo.intervalBetweenAttempts),
        (Timer timer) {
          final tick = timer.tick + 1;
          if (mounted && tick <= settingsRepo.totalAttempts + 1) {
            timerCallback(tick);
          }
        },
      );
    });

    super.initState();
  }

  void timerCallback(int tick) async {
    final isNotLastTick = tick <= settingsRepo.totalAttempts;

    trainingBloc.add(TrainingStartEvent(tick, isPause: false));
    if (isNotLastTick) {
      await Future.delayed(
        Duration(seconds: settingsRepo.intervalBetweenAttempts - 1),
      );
      trainingBloc.add(TrainingStartEvent(tick, isPause: true));
    }
  }

  Future<bool> _backBtnHandle(BuildContext context) {
    trainingBloc.add(const TrainingInitialEvent());
    Navigator.pop(context);
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: AppColors.themeColor,
          ),
        ),
        SafeArea(
          minimum: defaultTargetPlatform == TargetPlatform.iOS
              ? EdgeInsets.only(
                  bottom: getPropScreenWidth(24.0),
                )
              : EdgeInsets.zero,
          child: WillPopScope(
            onWillPop: () => _backBtnHandle(context),
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                leading: ArrowBackBtnWidget(() => _backBtnHandle(context)),
                actions: [
                  const SettingsButton(isFromTrainingScreen: true),
                  sizedBoxWidth(defaultHorPadding),
                ],
                title: Row(
                  children: [
                    if (!settingsRepo.hints)
                      Text(trainingAppbarText(settingsRepo.nBackValue))
                    else
                      HistoryRow(
                        nBackValue: settingsRepo.nBackValue,
                        isSingleDimension: isSingleDimension,
                      ),
                  ],
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                elevation: 0.0,
                child: BlocBuilder<TrainingBloc, TrainingState>(
                  builder: (context, state) {
                    if (state is TrainingProccess) {
                      return Row(
                        children: [
                          FooterButton(
                            index: 0,
                            text: positionText,
                            onTap: state.isPositionBtnDisabled
                                ? null
                                : () {
                                    trainingBloc.add(
                                        const TrainingPositionBtnClickEvent());
                                  },
                          ),
                          Visibility(
                            visible: !isSingleDimension,
                            child: FooterButton(
                              index: 1,
                              text: colorText,
                              onTap: state.isColorBtnDisabled
                                  ? null
                                  : () {
                                      trainingBloc.add(
                                          const TrainingColorBtnClickEvent());
                                    },
                            ),
                          ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              body: LayoutBuilder(
                builder: (context, constraints) {
                  return BlocConsumer<TrainingBloc, TrainingState>(
                    listenWhen: (oldState, newState) {
                      if (newState is TrainingProccess) {
                        return newState.counter > settingsRepo.totalAttempts;
                      }
                      return true;
                    },
                    listener: (context, state) {
                      if (state is TrainingProccess) {
                        Navigator.of(context).pushReplacementNamed(
                          Routes.resultsLink,
                          arguments: [state.correctAnswers, state.wrongAnswers],
                        );
                        trainingBloc.add(const TrainingInitialEvent());
                      }
                    },
                    buildWhen: (oldState, newState) {
                      if (newState is TrainingProccess) {
                        return newState.counter <= settingsRepo.totalAttempts;
                      }
                      return true;
                    },
                    builder: (context, state) {
                      if (state is TrainingProccess) {
                        return Column(
                          children: [
                            if (!settingsRepo.zenMode) ...[
                              sizedBoxHeight(18.0),
                              CountersRowWidget(state),
                            ],
                            BoardWidget(
                              state,
                              constraints.maxHeight,
                              zenMode: settingsRepo.zenMode,
                              hints: settingsRepo.hints,
                              isSingleDimension: isSingleDimension,
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
