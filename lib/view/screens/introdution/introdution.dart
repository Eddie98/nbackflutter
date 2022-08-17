import 'package:flutter/material.dart';
import 'package:nbackflutter/constants/index.dart';
import 'package:nbackflutter/routes.dart';
import 'package:nbackflutter/utils/index.dart';
import 'package:nbackflutter/view/widgets/index.dart';

class IntrodutionScreen extends StatelessWidget {
  const IntrodutionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: size.height * .24,
            automaticallyImplyLeading: false,
            elevation: 0,
            actions: [
              const SettingsButton(isFromTrainingScreen: false),
              sizedBoxWidth(defaultHorPadding),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(mainTitle),
              centerTitle: false,
              titlePadding: EdgeInsets.only(
                bottom: getPropScreenWidth(defaultHorPadding),
                left: getPropScreenWidth(defaultHorPadding),
              ),
              background: const DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.mainBlackColor,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getPropScreenWidth(defaultHorPadding),
                vertical: getPropScreenWidth(defaultHorPadding) * 2,
              ),
              child: Text(
                mainDescription,
                style: TextStyles.mainDescriptionTS(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.trainingLink);
        },
        backgroundColor: AppColors.themeColor,
        child: Icon(
          Icons.arrow_right_rounded,
          size: getPropScreenWidth(44.0),
        ),
      ),
    );
  }
}
