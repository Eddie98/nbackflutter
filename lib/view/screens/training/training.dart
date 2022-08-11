import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nbackflutter/constants/index.dart';
import 'package:nbackflutter/routes.dart';
import 'package:nbackflutter/utils/index.dart';
import 'package:nbackflutter/view/widgets/index.dart';

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

  @override
  void initState() {
    trainingBloc = context.read<TrainingBloc>();

    trainingBloc.add(const TrainingInitialEvent());
    Timer.periodic(
      const Duration(seconds: statePersistSecondsDuration + 1),
      (Timer timer) {
        if (mounted && timer.tick <= counterMaxLimit + 1) {
          timerCallback(timer.tick);
        }
      },
    );

    super.initState();
  }

  void timerCallback(int tick) async {
    trainingBloc.add(TrainingStartEvent(tick, isPause: false));
    await Future.delayed(
      const Duration(seconds: statePersistSecondsDuration),
    );
    trainingBloc.add(TrainingStartEvent(tick, isPause: true));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          iconSize: getPropScreenWidth(26.0),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          const SettingsButton(),
          sizedBoxWidth(defaultHorPadding),
        ],
        title: const Text(trainingAppbarText),
      ),
      bottomNavigationBar: BottomAppBar(
        child: BlocBuilder<TrainingBloc, TrainingProccess>(
          builder: (context, state) {
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
                      : () =>
                          trainingBloc.add(const TrainingColorBtnClickEvent()),
                ),
              ],
            );
          },
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return BlocConsumer<TrainingBloc, TrainingProccess>(
              listenWhen: (oldState, newState) =>
                  newState.counter > counterMaxLimit,
              listener: (context, state) {
                Navigator.of(context).pushReplacementNamed(
                  Routes.resultsLink,
                  arguments: [state.correctAnswers, state.wrongAnswers],
                );
              },
              buildWhen: (oldState, newState) =>
                  newState.counter <= counterMaxLimit,
              builder: (context, state) {
                return Column(
                  children: [
                    sizedBoxHeight(18.0),
                    CountersRowWidget(state),
                    sizedBoxHeight(22.0),
                    BoardWidget(state, constraints.maxHeight),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
