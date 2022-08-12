part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class SettingsChangeEvent extends SettingsEvent {
  final int? totalAttemptsOption;
  final int? intervalBetweenAttemptsOption;
  final int? nBackValueOption;

  const SettingsChangeEvent({
    this.totalAttemptsOption,
    this.intervalBetweenAttemptsOption,
    this.nBackValueOption,
  });

  @override
  List<Object?> get props => [
        totalAttemptsOption,
        intervalBetweenAttemptsOption,
        nBackValueOption,
      ];
}
