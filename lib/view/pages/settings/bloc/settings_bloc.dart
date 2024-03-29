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

  void settingsChangeEventHandler(
    SettingsChangeEvent event,
    Emitter<SettingsState> emit,
  ) {
    final state = this.state;

    if (state is SettingsMainState) {
      emit(state.copyWith(
        totalAttempts: event.totalAttemptsOption,
        intervalBetweenAttempts: event.intervalBetweenAttemptsOption,
        nBackValue: event.nBackValueOption,
        dimension: event.dimensionOption,
        zenMode: event.zenModeOption,
        hints: event.hintsOption,
      ));
    }
  }

  @override
  SettingsMainState? fromJson(Map<String, dynamic> json) {
    try {
      _settingsRepo.totalAttempts = json['totalAttempts'];
      _settingsRepo.intervalBetweenAttempts = json['intervalBetweenAttempts'];
      _settingsRepo.nBackValue = json['nBackValue'];
      _settingsRepo.dimension = json['dimension'];
      _settingsRepo.zenMode = json['zenMode'];
      _settingsRepo.hints = json['hints'];

      return SettingsMainState(
        totalAttempts: json['totalAttempts'],
        intervalBetweenAttempts: json['intervalBetweenAttempts'],
        nBackValue: json['nBackValue'],
        dimension: json['dimension'],
        zenMode: json['zenMode'],
        hints: json['hints'],
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
      _settingsRepo.dimension = state.dimension;
      _settingsRepo.zenMode = state.zenMode;
      _settingsRepo.hints = state.hints;

      return state.toMap();
    }
    return null;
  }
}
