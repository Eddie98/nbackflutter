import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'bloc_observer.dart';
import 'constants/index.dart';
import 'routes.dart';
import 'view/pages/settings/bloc/settings_bloc.dart';
import 'view/pages/settings/settings_repository.dart';
import 'view/screens/training/bloc/training_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(const MyApp()),
    storage: storage,
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => SettingsRepository(),
      child: Builder(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => TrainingBloc(
                settingsRepo: context.read<SettingsRepository>(),
              ),
            ),
            BlocProvider(
              lazy: false,
              create: (context) => SettingsBloc(
                settingsRepo: context.read<SettingsRepository>(),
              ),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            scrollBehavior: DisableGlowScrollBehavior(),
            theme: ThemeData(
              splashFactory: InkRipple.splashFactory,
              primaryColor: AppColors.themeColor,
              appBarTheme: const AppBarTheme(
                backgroundColor: AppColors.themeColor,
              ),
              scaffoldBackgroundColor: AppColors.mainBlackColor,
            ),
            initialRoute: Routes.introdutionLink,
            onGenerateRoute: Routes.onGenerateRoute,
          ),
        );
      }),
    );
  }
}

class DisableGlowScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
