import 'package:flutter/material.dart';
import 'package:nbackflutter/constants/index.dart';
import 'package:nbackflutter/routes.dart';
import 'package:nbackflutter/utils/index.dart';
import 'package:nbackflutter/view/widgets/index.dart';
import 'package:seo_renderer/seo_renderer.dart';

class IntrodutionScreen extends StatelessWidget {
  const IntrodutionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: AppColors.mainBlackColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: mediaQuery.size.height * .24,
            automaticallyImplyLeading: false,
            elevation: 0,
            actions: [
              const SettingsButton(isFromTrainingScreen: false),
              sizedBoxWidth(defaultHorPadding),
            ],
            flexibleSpace: LayoutBuilder(builder: (context, constraints) {
              final isCollapsed = constraints.biggest.height <=
                  mediaQuery.padding.top + kToolbarHeight + defaultHorPadding;

              return FlexibleSpaceBar(
                title: Container(
                  height: kToolbarHeight,
                  alignment:
                      isCollapsed ? Alignment.centerLeft : Alignment.bottomLeft,
                  child: const TextRenderer(
                    style: TextRendererStyle.header1,
                    text: mainTitle,
                    child: Text(mainTitle),
                  ),
                ),
                titlePadding: EdgeInsetsDirectional.only(
                  bottom:
                      isCollapsed ? 0.0 : getPropScreenWidth(defaultHorPadding),
                  start: getPropScreenWidth(defaultHorPadding),
                ),
                centerTitle: false,
                background: const DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.mainBlackColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.mainBlackColor,
                        blurRadius: 0.0,
                        spreadRadius: 1.0,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getPropScreenWidth(defaultHorPadding),
                vertical: getPropScreenWidth(defaultHorPadding) * 2,
              ),
              child: TextRenderer(
                style: TextRendererStyle.paragraph,
                text: mainDescription,
                child: Text(
                  mainDescription,
                  style: TextStyles.mainDescriptionTS(),
                ),
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
        child: Center(
          child: Icon(
            Icons.arrow_right_rounded,
            size: getPropScreenWidth(44.0),
          ),
        ),
      ),
    );
  }
}
