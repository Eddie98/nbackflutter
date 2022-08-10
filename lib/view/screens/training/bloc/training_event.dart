part of 'training_bloc.dart';

abstract class TrainingEvent extends Equatable {
  const TrainingEvent();

  @override
  List<Object> get props => [];
}

class TrainingInitialEvent extends TrainingEvent {
  const TrainingInitialEvent();
}

class TrainingStartEvent extends TrainingEvent {
  final int counter;
  final bool isPause;

  const TrainingStartEvent(this.counter, {this.isPause = false});

  @override
  List<Object> get props => [counter, isPause];
}

class TrainingColorBtnClickEvent extends TrainingEvent {
  const TrainingColorBtnClickEvent();
}

class TrainingPositionBtnClickEvent extends TrainingEvent {
  const TrainingPositionBtnClickEvent();
}
