import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:nbackflutter/constants/index.dart';
import 'package:nbackflutter/routes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:seo_renderer/seo_renderer.dart';

import 'view/pages/settings/bloc/settings_bloc.dart';
import 'view/pages/settings/settings_repository.dart';
import 'view/screens/training/bloc/training_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(const MyApp()),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => SettingsRepository(),
      child: Builder(
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                lazy: false,
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
            child: RobotDetector(
              debug: false,
              child: FlutterWebFrame(
                maximumSize: const Size(defaultWebFrame, double.infinity),
                enabled: true,
                backgroundColor: AppColors.mainBlackColor.withOpacity(.8),
                clipBehavior: Clip.hardEdge,
                builder: (_) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    scrollBehavior: DisableGlowScrollBehavior(),
                    navigatorObservers: [seoRouteObserver],
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
                  );
                },
              ),
            ),
          );
        },
      ),
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
