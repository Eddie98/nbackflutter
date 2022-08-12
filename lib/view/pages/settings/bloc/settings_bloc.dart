import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  final SettingsRepository _settingsRepo;

  SettingsBloc({
    required SettingsRepository settingsRepo,
  })  : _settingsRepo = settingsRepo,
        super(const SettingsMainState()) {
    on<SettingsChangeEvent>(settingsChangeEventHandler);
  }

  void settingsChangeEventHandler(event, emit) {
    final state = this.state;

    if (state is SettingsMainState) {
      emit(state.copyWith(
        totalAttempts: event.totalAttemptsOption,
        intervalBetweenAttempts: event.intervalBetweenAttemptsOption,
        nBackValue: event.nBackValueOption,
      ));
    }
  }

  @override
  SettingsMainState? fromJson(Map<String, dynamic> json) {
    try {
      _settingsRepo.totalAttempts = json['totalAttempts'];
      _settingsRepo.intervalBetweenAttempts = json['intervalBetweenAttempts'];
      _settingsRepo.nBackValue = json['nBackValue'];

      return SettingsMainState(
        totalAttempts: json['totalAttempts'],
        intervalBetweenAttempts: json['intervalBetweenAttempts'],
        nBackValue: json['nBackValue'],
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(state) {
    if (state is SettingsMainState) {
      _settingsRepo.totalAttempts = state.totalAttempts;
      _settingsRepo.intervalBetweenAttempts = state.intervalBetweenAttempts;
      _settingsRepo.nBackValue = state.nBackValue;

      return state.toMap();
    }
    return null;
  }
}
