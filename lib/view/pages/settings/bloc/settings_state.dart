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

  const SettingsMainState({
    this.totalAttempts = 25,
    this.intervalBetweenAttempts = 2,
    this.nBackValue = 2,
  });

  Map<String, dynamic> toMap() {
    return {
      'totalAttempts': totalAttempts,
      'intervalBetweenAttempts': intervalBetweenAttempts,
      'nBackValue': nBackValue,
    };
  }

  SettingsMainState copyWith({
    int? totalAttempts,
    int? intervalBetweenAttempts,
    int? nBackValue,
  }) =>
      SettingsMainState(
        totalAttempts: totalAttempts ?? this.totalAttempts,
        intervalBetweenAttempts:
            intervalBetweenAttempts ?? this.intervalBetweenAttempts,
        nBackValue: nBackValue ?? this.nBackValue,
      );
}
