import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nbackflutter/constants/index.dart';

part 'training_event.dart';
part 'training_state.dart';

class TrainingBloc extends Bloc<TrainingEvent, TrainingProccess> {
  bool isColorBtnClicked = false;
  bool isPositionBtnClicked = false;

  TrainingBloc() : super(const TrainingProccess()) {
    on<TrainingEvent>(trainingEventHandler);
  }

  bool checkLastAndTwoPosBackEquality(List list) =>
      list.last == list.reversed.elementAt(2);

  void trainingEventHandler(event, emit) {
    if (event is TrainingInitialEvent) emit(const TrainingProccess());

    if (state.colors.length > 2 && state.positions.length > 2) {
      if (event is TrainingColorBtnClickEvent) {
        if (checkLastAndTwoPosBackEquality(state.colors)) {
          emit(state.copyWith(
            isColorBtnDisabled: true,
            correctAnswers: state.correctAnswers + 1,
          ));
        } else {
          emit(state.copyWith(
            isColorBtnDisabled: true,
            wrongAnswers: state.wrongAnswers + 1,
          ));
        }
        isColorBtnClicked = true;
      }

      if (event is TrainingPositionBtnClickEvent) {
        if (checkLastAndTwoPosBackEquality(state.positions)) {
          emit(state.copyWith(
            isPositionBtnDisabled: true,
            correctAnswers: state.correctAnswers + 1,
          ));
        } else {
          emit(state.copyWith(
            isPositionBtnDisabled: true,
            wrongAnswers: state.wrongAnswers + 1,
          ));
        }
        isPositionBtnClicked = true;
      }
    } else {
      if (event is TrainingColorBtnClickEvent) {
        emit(state.copyWith(
          isColorBtnDisabled: true,
          wrongAnswers: state.wrongAnswers + 1,
        ));
      }
      if (event is TrainingPositionBtnClickEvent) {
        emit(state.copyWith(
          isPositionBtnDisabled: true,
          wrongAnswers: state.wrongAnswers + 1,
        ));
      }
    }

    if (event is TrainingStartEvent) {
      final stateColors = [...state.colors];
      final statePositions = [...state.positions];

      int wrongAnswersIncrement = 0;

      if (event.isPause) {
        if (stateColors.length > 2 && statePositions.length > 2) {
          if (checkLastAndTwoPosBackEquality(stateColors) &&
              !isColorBtnClicked) {
            wrongAnswersIncrement += 1;
          }
          if (checkLastAndTwoPosBackEquality(statePositions) &&
              !isPositionBtnClicked) {
            wrongAnswersIncrement += 1;
          }
        }
      }

      if (!event.isPause) {
        final constColors = [...listOfColorsForRandomSelection];
        final constPositions = [...listOfPositionsForRandomSelection];

        final randomColor = (constColors.toList()..shuffle()).first;
        final randomPosition = (constPositions.toList()..shuffle()).first;

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
        wrongAnswers: state.wrongAnswers + wrongAnswersIncrement,
      ));

      isColorBtnClicked = false;
      isPositionBtnClicked = false;
    }
  }
}
