// ignore_for_file: unnecessary_overrides

import 'package:bloc/bloc.dart';
import 'package:nbackflutter/utils/index.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    cprint('onEvent', color: 0);
    cprint('${bloc.runtimeType} $event', color: 1);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    // cprint('onTransition', color: 0);
    // cprint('${bloc.runtimeType} $transition', color: 1);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is! Bloc) {
      cprint('onChange', color: 0);
      cprint('${bloc.runtimeType} $change', color: 1);
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    cprint('onError', color: 0);
    cprint('${bloc.runtimeType} $error $stackTrace', color: 1);
  }
}
