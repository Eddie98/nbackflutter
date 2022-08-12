import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsMainState> {
  final SettingsRepository _settingsRepo;

  SettingsBloc({
    required SettingsRepository settingsRepo,
  })  : _settingsRepo = settingsRepo,
        super(const SettingsMainState()) {
    on<SettingsEvent>(settingsEventHandler);
  }

  void settingsEventHandler(event, emit) {
    if (event is SettingsChangeEvent) {
      //  emit(state.copyWith());
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
  Map<String, dynamic>? toJson(state) => state.toMap();
}
