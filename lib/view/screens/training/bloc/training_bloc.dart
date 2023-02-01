import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nbackflutter/constants/index.dart';

import '../../../pages/settings/settings_repository.dart';

part 'training_event.dart';
part 'training_state.dart';

class TrainingBloc extends Bloc<TrainingEvent, TrainingState> {
  final SettingsRepository _settingsRepo;

  bool isColorBtnClicked = false;
  bool isPositionBtnClicked = false;

  TrainingBloc({
    required SettingsRepository settingsRepo,
  })  : _settingsRepo = settingsRepo,
        super(const TrainingProccess()) {
    on<TrainingInitialEvent>(
      trainingInitialEventHandler,
      transformer: sequential(),
    );

    on<TrainingColorBtnClickEvent>(
      trainingColorBtnClickEventHandler,
      transformer: sequential(),
    );
    on<TrainingPositionBtnClickEvent>(
      trainingPositionBtnClickEventHandler,
      transformer: sequential(),
    );
    on<TrainingStartEvent>(
      trainingStartEventHandler,
      transformer: sequential(),
    );
  }

  bool checkLastAndNPosBackEquality(List list) =>
      list.last == list.reversed.elementAt(_settingsRepo.nBackValue);

  void trainingInitialEventHandler(
    TrainingInitialEvent event,
    Emitter<TrainingState> emit,
  ) =>
      emit(const TrainingProccess());

  void trainingColorBtnClickEventHandler(
    TrainingColorBtnClickEvent event,
    Emitter<TrainingState> emit,
  ) {
    final state = this.state;

    if (state is TrainingProccess) {
      final correctAnswersClone = [...state.correctAnswers];
      final wrongAnswersClone = [...state.wrongAnswers];

      if (state.colors.length > _settingsRepo.nBackValue) {
        if (checkLastAndNPosBackEquality(state.colors)) {
          correctAnswersClone.add(colorSign);

          emit(state.copyWith(
            isColorBtnDisabled: true,
            correctAnswers: correctAnswersClone,
          ));
        } else {
          wrongAnswersClone.add(colorSign);

          emit(state.copyWith(
            isColorBtnDisabled: true,
            wrongAnswers: wrongAnswersClone,
          ));
        }
        isColorBtnClicked = true;
      } else {
        wrongAnswersClone.add(colorSign);
        emit(state.copyWith(
          isColorBtnDisabled: true,
          wrongAnswers: wrongAnswersClone,
        ));
        isColorBtnClicked = true;
      }
    }
  }

  void trainingPositionBtnClickEventHandler(
    TrainingPositionBtnClickEvent event,
    Emitter<TrainingState> emit,
  ) {
    final state = this.state;

    if (state is TrainingProccess) {
      final correctAnswersClone = [...state.correctAnswers];
      final wrongAnswersClone = [...state.wrongAnswers];

      if (state.positions.length > _settingsRepo.nBackValue) {
        if (checkLastAndNPosBackEquality(state.positions)) {
          correctAnswersClone.add(positionSign);

          emit(state.copyWith(
            isPositionBtnDisabled: true,
            correctAnswers: correctAnswersClone,
          ));
        } else {
          wrongAnswersClone.add(positionSign);

          emit(state.copyWith(
            isPositionBtnDisabled: true,
            wrongAnswers: wrongAnswersClone,
          ));
        }
        isPositionBtnClicked = true;
      } else {
        wrongAnswersClone.add(positionSign);
        emit(state.copyWith(
          isPositionBtnDisabled: true,
          wrongAnswers: wrongAnswersClone,
        ));
        isPositionBtnClicked = true;
      }
    }
  }

  void trainingStartEventHandler(
    TrainingStartEvent event,
    Emitter<TrainingState> emit,
  ) {
    final state = this.state;

    if (state is TrainingProccess) {
      final wrongAnswersClone = [...state.wrongAnswers];

      final stateColors = [...state.colors];
      final statePositions = [...state.positions];

      if (!event.isPause) {
        if (stateColors.length > _settingsRepo.nBackValue &&
            statePositions.length > _settingsRepo.nBackValue) {
          if (checkLastAndNPosBackEquality(stateColors) && !isColorBtnClicked) {
            wrongAnswersClone.add(colorSign);
          }
          if (checkLastAndNPosBackEquality(statePositions) &&
              !isPositionBtnClicked) {
            wrongAnswersClone.add(positionSign);
          }
        }

        final constColors = [...listOfColorsForRandomSelection];
        final constPositions = [...listOfPositionsForRandomSelection];

        final randomColor = (constColors..shuffle()).first;
        final randomPosition = (constPositions..shuffle()).first;

        stateColors.add(randomColor);
        statePositions.add(randomPosition);
      }

      emit(state.copyWith(
        counter: event.counter,
        colors: stateColors,
        positions: statePositions,
        isPause: event.isPause,
        isColorBtnDisabled: event.isPause && isColorBtnClicked,
        isPositionBtnDisabled: event.isPause && isPositionBtnClicked,
        wrongAnswers: wrongAnswersClone,
      ));

      if (!event.isPause) {
        isColorBtnClicked = false;
        isPositionBtnClicked = false;
      }
    }
  }
}
