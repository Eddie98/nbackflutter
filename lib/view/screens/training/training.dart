import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nbackflutter/constants/index.dart';
import 'package:nbackflutter/view/widgets/sized_box.dart';

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
      const Duration(milliseconds: statePersistMilliSecondsDuration + 1000),
      (Timer timer) {
        if (mounted) timerCallback(timer.tick);
      },
    );

    super.initState();
  }

  void timerCallback(int tick) async {
    trainingBloc.add(TrainingStartEvent(tick, isPause: false));
    await Future.delayed(
      const Duration(milliseconds: statePersistMilliSecondsDuration),
    );
    trainingBloc.add(TrainingStartEvent(tick, isPause: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          iconSize: 32.0,
          icon: const Icon(Icons.close),
        ),
        title: const Text(trainingAppbarText),
      ),
      bottomNavigationBar: BottomAppBar(
        child: BlocBuilder<TrainingBloc, TrainingProccess>(
          builder: (context, state) {
            return Row(
              children: [
                FooterButton(
                  index: 0,
                  text: trainingFooterBtnPositionText,
                  onTap: state.isPositionBtnDisabled
                      ? null
                      : () => trainingBloc
                          .add(const TrainingPositionBtnClickEvent()),
                ),
                FooterButton(
                  index: 1,
                  text: trainingFooterBtnColorText,
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
                // TODO: Redirect to results screens
              },
              buildWhen: (oldState, newState) =>
                  newState.counter <= counterMaxLimit,
              builder: (context, state) {
                return Column(
                  children: [
                    sizedBoxHeight(22.0),
                    CountersRowWidget(state),
                    sizedBoxHeight(26.0),
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
