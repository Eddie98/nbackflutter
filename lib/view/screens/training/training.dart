import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nbackflutter/constants/index.dart';
import 'package:nbackflutter/routes.dart';
import 'package:nbackflutter/utils/index.dart';
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
  late TrainingBloc trainingBloc;
  late SettingsRepository settingsRepo;

  @override
  void initState() {
    trainingBloc = context.read<TrainingBloc>();
    settingsRepo = context.read<SettingsRepository>();

    trainingBloc.add(const TrainingInitialEvent());
    Timer.periodic(
      Duration(seconds: settingsRepo.intervalBetweenAttempts),
      (Timer timer) {
        if (mounted && timer.tick <= settingsRepo.totalAttempts + 1) {
          timerCallback(timer.tick);
        }
      },
    );

    super.initState();
  }

  void timerCallback(int tick) async {
    trainingBloc.add(TrainingStartEvent(tick, isPause: false));
    await Future.delayed(
      Duration(seconds: settingsRepo.intervalBetweenAttempts - 1),
    );
    trainingBloc.add(TrainingStartEvent(tick, isPause: true));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: ArrowBackBtnWidget(
          () => Navigator.pop(context),
        ),
        actions: [
          const SettingsButton(isFromTrainingScreen: true),
          sizedBoxWidth(defaultHorPadding),
        ],
        title: Text(trainingAppbarText(settingsRepo.nBackValue)),
      ),
      bottomNavigationBar: BottomAppBar(
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
                        : () => trainingBloc
                            .add(const TrainingPositionBtnClickEvent()),
                  ),
                  FooterButton(
                    index: 1,
                    text: colorText,
                    onTap: state.isColorBtnDisabled
                        ? null
                        : () => trainingBloc
                            .add(const TrainingColorBtnClickEvent()),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
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
                      sizedBoxHeight(18.0),
                      CountersRowWidget(state),
                      sizedBoxHeight(22.0),
                      BoardWidget(state, constraints.maxHeight),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            );
          },
        ),
      ),
    );
  }
}
