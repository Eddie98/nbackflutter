import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants/index.dart';
import 'routes.dart';
import 'view/screens/training/bloc/training_bloc.dart';

void main() {
  runApp(const MyApp());
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
          scaffoldBackgroundColor: Colors.black,
        ),
        routes: Routes.routesMap,
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
