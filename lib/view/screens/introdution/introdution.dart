import 'package:flutter/material.dart';
import 'package:nbackflutter/constants/index.dart';
import 'package:nbackflutter/routes.dart';

class IntrodutionScreen extends StatelessWidget {
  const IntrodutionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: true,
            expandedHeight: size.height * .25,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text(mainTitle),
              centerTitle: false,
              titlePadding: EdgeInsets.only(
                bottom: defaultHorPadding,
                left: defaultHorPadding,
              ),
              background: DecoratedBox(
                decoration: BoxDecoration(color: Colors.transparent),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultHorPadding,
                vertical: defaultHorPadding * 2,
              ),
              child: Text(
                mainDescription,
                style: TextStyles.mainDescriptionTS,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.trainingLink);
        },
        backgroundColor: AppColors.themeColor,
        child: const Icon(
          Icons.arrow_right_rounded,
          size: 44.0,
        ),
      ),
    );
  }
}
