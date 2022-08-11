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
  final List<String> correctAnswers;
  final List<String> wrongAnswers;

  const TrainingProccess({
    this.counter = 0,
    this.isPause = false,
    this.isColorBtnDisabled = false,
    this.isPositionBtnDisabled = false,
    this.colors = const [],
    this.positions = const [],
    this.correctAnswers = const [],
    this.wrongAnswers = const [],
  });

  TrainingProccess copyWith({
    int? counter,
    bool? isPause,
    bool? isColorBtnDisabled,
    bool? isPositionBtnDisabled,
    List<Color>? colors,
    List<int>? positions,
    List<String>? correctAnswers,
    List<String>? wrongAnswers,
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
