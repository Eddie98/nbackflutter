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
  final bool zenMode;
  final bool hints;

  const SettingsMainState({
    this.totalAttempts = defaultTotalAttempts,
    this.intervalBetweenAttempts = defaultIntervalBetweenAttempts,
    this.nBackValue = defaultNBackValue,
    this.zenMode = defaultZenMode,
    this.hints = defaultHints,
  });

  Map<String, dynamic> toMap() => {
        'totalAttempts': totalAttempts,
        'intervalBetweenAttempts': intervalBetweenAttempts,
        'nBackValue': nBackValue,
        'zenMode': zenMode,
        'hints': hints,
      };

  SettingsMainState copyWith({
    int? totalAttempts,
    int? intervalBetweenAttempts,
    int? nBackValue,
    bool? zenMode,
    bool? hints,
  }) {
    return SettingsMainState(
      totalAttempts: totalAttempts ?? this.totalAttempts,
      intervalBetweenAttempts:
          intervalBetweenAttempts ?? this.intervalBetweenAttempts,
      nBackValue: nBackValue ?? this.nBackValue,
      zenMode: zenMode ?? this.zenMode,
      hints: hints ?? this.hints,
    );
  }

  @override
  List<Object> get props => [
        totalAttempts,
        intervalBetweenAttempts,
        nBackValue,
        zenMode,
        hints,
      ];
}
