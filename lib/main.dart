import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_observer.dart';
import 'constants/index.dart';
import 'routes.dart';
import 'view/screens/training/bloc/training_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrainingBloc(),
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
  }
}

class DisableGlowScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
