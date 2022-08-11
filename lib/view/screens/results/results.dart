import 'package:flutter/material.dart';
import 'package:nbackflutter/constants/index.dart';
import 'package:nbackflutter/routes.dart';
import 'package:nbackflutter/utils/index.dart';
import 'package:nbackflutter/view/widgets/index.dart';

import 'widgets/table.dart';

class ResultsScreen extends StatelessWidget {
  final List<List<String>> listOfCorrectWrongs;

  const ResultsScreen(this.listOfCorrectWrongs, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final correctAnswers = listOfCorrectWrongs.first;
    final wrongAnswers = listOfCorrectWrongs.last;

    final value =
        correctAnswers.length / (correctAnswers.length + wrongAnswers.length);
    final int percent = (value * 100).round();
    final percentString = '$percent%';

    late String comment;

    if (percent > 30 && percent < 50) {
      comment = resultsNotGoodEnoughCanMore;
    } else if (percent > 50 && percent < 70) {
      comment = resultsNotbadCanMore;
    } else if (percent > 70 && percent < 90) {
      comment = resultsGoodButMore;
    } else if (percent > 90) {
      comment = resultsExcellent;
    } else {
      comment = resultsTryMore;
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () =>
              Navigator.of(context).pushReplacementNamed(Routes.trainingLink),
          iconSize: getPropScreenWidth(26.0),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(trainingAppbarText),
      ),
      body: Center(
        child: Column(
          children: [
            sizedBoxHeight(42.0),
            Text(
              resultsYourResults,
              style: TextStyles.allColorPositionTS().copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
            sizedBoxHeight(12.0),
            Text(
              percentString,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: getAdaptiveFontSize(26.0),
                color: Colors.white,
              ),
            ),
            sizedBoxHeight(28.0),
            Text(
              comment,
              style: TextStyles.allColorPositionTS().copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
            TableWidget(
              correctAll: correctAnswers.length,
              correctColors: correctAnswers.where((e) => e == colorSign).length,
              correctPositions:
                  correctAnswers.where((e) => e == positionSign).length,
              wrongAll: wrongAnswers.length,
              wrongColors: wrongAnswers.where((e) => e == colorSign).length,
              wrongPositions:
                  wrongAnswers.where((e) => e == positionSign).length,
            ),
          ],
        ),
      ),
    );
  }
}
