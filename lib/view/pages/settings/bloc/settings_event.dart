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
  final int? dimensionOption;
  final bool? zenModeOption;
  final bool? hintsOption;

  const SettingsChangeEvent({
    this.totalAttemptsOption,
    this.intervalBetweenAttemptsOption,
    this.nBackValueOption,
    this.dimensionOption,
    this.zenModeOption,
    this.hintsOption,
  });

  @override
  List<Object?> get props => [
        totalAttemptsOption,
        intervalBetweenAttemptsOption,
        nBackValueOption,
        dimensionOption,
        zenModeOption,
        hintsOption,
      ];
}
