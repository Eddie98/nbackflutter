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
    final correctAnswersClone = [...state.correctAnswers];
    final wrongAnswersClone = [...state.wrongAnswers];

    if (event is TrainingInitialEvent) emit(const TrainingProccess());

    if (state.colors.length > 2 && state.positions.length > 2) {
      if (event is TrainingColorBtnClickEvent) {
        if (checkLastAndTwoPosBackEquality(state.colors)) {
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
      }

      if (event is TrainingPositionBtnClickEvent) {
        if (checkLastAndTwoPosBackEquality(state.positions)) {
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
      }
    } else {
      if (event is TrainingColorBtnClickEvent) {
        wrongAnswersClone.add(colorSign);
        emit(state.copyWith(
          isColorBtnDisabled: true,
          wrongAnswers: wrongAnswersClone,
        ));
      }
      if (event is TrainingPositionBtnClickEvent) {
        wrongAnswersClone.add(positionSign);
        emit(state.copyWith(
          isPositionBtnDisabled: true,
          wrongAnswers: wrongAnswersClone,
        ));
      }
    }

    if (event is TrainingStartEvent) {
      final stateColors = [...state.colors];
      final statePositions = [...state.positions];

      if (event.isPause) {
        if (stateColors.length > 2 && statePositions.length > 2) {
          if (checkLastAndTwoPosBackEquality(stateColors) &&
              !isColorBtnClicked) {
            wrongAnswersClone.add(colorSign);
          }
          if (checkLastAndTwoPosBackEquality(statePositions) &&
              !isPositionBtnClicked) {
            wrongAnswersClone.add(positionSign);
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
        wrongAnswers: wrongAnswersClone,
      ));

      isColorBtnClicked = false;
      isPositionBtnClicked = false;
    }
  }
}
