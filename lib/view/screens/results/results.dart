import 'package:flutter/material.dart';
import 'package:nbackflutter/constants/index.dart';
import 'package:nbackflutter/routes.dart';
import 'package:nbackflutter/utils/index.dart';

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
      body: Container(),
    );
  }
}
