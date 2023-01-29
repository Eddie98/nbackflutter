import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:nbackflutter/constants/app_constants.dart';

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
        zenMode: event.zenModeOption,
      ));
    }
  }

  @override
  SettingsMainState? fromJson(Map<String, dynamic> json) {
    try {
      _settingsRepo.totalAttempts = json['totalAttempts'];
      _settingsRepo.intervalBetweenAttempts = json['intervalBetweenAttempts'];
      _settingsRepo.nBackValue = json['nBackValue'];
      _settingsRepo.zenMode = json['zenMode'];

      return SettingsMainState(
        totalAttempts: json['totalAttempts'],
        intervalBetweenAttempts: json['intervalBetweenAttempts'],
        nBackValue: json['nBackValue'],
        zenMode: json['zenMode'],
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
      _settingsRepo.zenMode = state.zenMode;

      return state.toMap();
    }
    return null;
  }
}
