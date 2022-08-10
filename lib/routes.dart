import 'package:flutter/widgets.dart';

import 'view/screens/introdution/introdution.dart';
import 'view/screens/results/results.dart';
import 'view/screens/training/training.dart';

class Routes {
  static const String introdutionLink = '/';
  static const String trainingLink = '/training';
  static const String resultsLink = '/results';

  static Map<String, WidgetBuilder> routesMap = {
    introdutionLink: (context) => const IntrodutionScreen(),
    trainingLink: (context) => const TrainingScreen(),
    resultsLink: (context) => const ResultsScreen(),
  };

  static Route<T> fadeThrough<T>(
    RouteSettings settings,
    WidgetBuilder page, {
    int duration = 300,
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: Duration(milliseconds: duration),
      pageBuilder: (context, animation, secondaryAnimation) => page(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    return fadeThrough(settings, (context) {
      for (var entry in routesMap.entries) {
        if (settings.name == entry.key) return entry.value(context);
      }
      return const SizedBox.shrink();
    });
  }
}
