part of 'training_bloc.dart';

abstract class TrainingState extends Equatable {
  const TrainingState();

  @override
  List<Object> get props => [];
}

class TrainingInitial extends TrainingState {
  const TrainingInitial();
}

class TrainingProccess extends TrainingState {
  final int counter;
  final bool isPause;
  final bool isColorBtnDisabled;
  final bool isPositionBtnDisabled;
  final List<Color> colors;
  final List<int> positions;
  final int correctAnswers;
  final int wrongAnswers;

  const TrainingProccess({
    this.counter = 0,
    this.isPause = false,
    this.isColorBtnDisabled = false,
    this.isPositionBtnDisabled = false,
    this.colors = const [],
    this.positions = const [],
    this.correctAnswers = 0,
    this.wrongAnswers = 0,
  });

  TrainingProccess copyWith({
    int? counter,
    bool? isPause,
    bool? isColorBtnDisabled,
    bool? isPositionBtnDisabled,
    List<Color>? colors,
    List<int>? positions,
    int? correctAnswers,
    int? wrongAnswers,
  }) =>
      TrainingProccess(
        counter: counter ?? this.counter,
        isPause: isPause ?? this.isPause,
        isColorBtnDisabled: isColorBtnDisabled ?? this.isColorBtnDisabled,
        isPositionBtnDisabled:
            isPositionBtnDisabled ?? this.isPositionBtnDisabled,
        colors: colors ?? this.colors,
        positions: positions ?? this.positions,
        correctAnswers: correctAnswers ?? this.correctAnswers,
        wrongAnswers: wrongAnswers ?? this.wrongAnswers,
      );

  @override
  List<Object> get props => [
        counter,
        isPause,
        isColorBtnDisabled,
        isPositionBtnDisabled,
        colors,
        positions,
        correctAnswers,
        wrongAnswers,
      ];
}
