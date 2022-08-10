import 'package:flutter/material.dart';
import 'package:nbackflutter/constants/index.dart';
import 'package:nbackflutter/routes.dart';
import 'package:nbackflutter/utils/index.dart';
import 'package:nbackflutter/view/widgets/index.dart';

import 'widgets/table.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

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
              '25%',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: getAdaptiveFontSize(26.0),
                color: Colors.white,
              ),
            ),
            sizedBoxHeight(28.0),
            Text(
              resultsTryMore,
              style: TextStyles.allColorPositionTS().copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
            const TableWidget(),
          ],
        ),
      ),
    );
  }
}
