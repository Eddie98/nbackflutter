import 'package:flutter/widgets.dart';

import 'view/screens/introdution/introdution.dart';
import 'view/screens/results/results.dart';
import 'view/screens/training/training.dart';

class Routes {
  static const String introdutionLink = '/';
  static const String trainingLink = '/training';
  static const String resultsLink = '/results';

  static Route<T> fadeThrough<T>(
    WidgetBuilder page, {
    RouteSettings? settings,
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
    return fadeThrough((context) {
      if (settings.name == introdutionLink) {
        return const IntrodutionScreen();
      }
      if (settings.name == trainingLink) {
        return const TrainingScreen();
      }
      if (settings.name == resultsLink) {
        return ResultsScreen(settings.arguments as List<List<String>>);
      }
      return const IntrodutionScreen();
    }, settings: settings);
  }
}
