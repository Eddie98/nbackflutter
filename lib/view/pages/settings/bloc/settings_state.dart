part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsMainState extends SettingsState {
  final int totalAttempts;
  final int intervalBetweenAttempts;
  final int nBackValue;
  final int dimension;
  final bool zenMode;
  final bool hints;

  const SettingsMainState({
    this.totalAttempts = defaultTotalAttempts,
    this.intervalBetweenAttempts = defaultIntervalBetweenAttempts,
    this.nBackValue = defaultNBackValue,
    this.dimension = defaultDimension,
    this.zenMode = defaultZenMode,
    this.hints = defaultHints,
  });

  Map<String, dynamic> toMap() => {
        'totalAttempts': totalAttempts,
        'intervalBetweenAttempts': intervalBetweenAttempts,
        'nBackValue': nBackValue,
        'dimension': dimension,
        'zenMode': zenMode,
        'hints': hints,
      };

  SettingsMainState copyWith({
    int? totalAttempts,
    int? intervalBetweenAttempts,
    int? nBackValue,
    int? dimension,
    bool? zenMode,
    bool? hints,
  }) {
    return SettingsMainState(
      totalAttempts: totalAttempts ?? this.totalAttempts,
      intervalBetweenAttempts:
          intervalBetweenAttempts ?? this.intervalBetweenAttempts,
      nBackValue: nBackValue ?? this.nBackValue,
      dimension: dimension ?? this.dimension,
      zenMode: zenMode ?? this.zenMode,
      hints: hints ?? this.hints,
    );
  }

  @override
  List<Object> get props => [
        totalAttempts,
        intervalBetweenAttempts,
        nBackValue,
        dimension,
        zenMode,
        hints,
      ];
}
