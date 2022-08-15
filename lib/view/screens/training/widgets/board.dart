import 'package:flutter/material.dart';
import 'package:nbackflutter/constants/app_colors.dart';
import 'package:nbackflutter/constants/app_constants.dart';
import 'package:nbackflutter/utils/index.dart';

import '../bloc/training_bloc.dart';

class BoardWidget extends StatelessWidget {
  final TrainingProccess state;
  final double bodyHeight;

  const BoardWidget(
    this.state,
    this.bodyHeight, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const spacingsHeight = 66.0; // bottom spacing absent - 26.0 - if overflow.
    const countersHeight = 23.0;
    final itemHeight = (bodyHeight - spacingsHeight - countersHeight) / 3;

    return Expanded(
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: itemHeight,
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: getPropScreenWidth(defaultHorPadding),
        ),
        children: List.generate(9, (index) {
          if (!state.isPause &&
              state.positions.isNotEmpty &&
              index == state.positions.last) {
            return _GridItemWidget(index, color: state.colors.last);
          }
          return _GridItemWidget(index);
        }),
      ),
    );
  }
}

class _GridItemWidget extends StatelessWidget {
  final int index;
  final Color? color;

  const _GridItemWidget(
    this.index, {
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mainGreyColor,
      child: index == 4 ? const _CrossWidget() : _ColorsWidget(color: color),
    );
  }
}

class _CrossWidget extends StatelessWidget {
  const _CrossWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Transform.rotate(
            angle: 45.0,
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: AppColors.mainBlackColor,
            ),
          ),
          Positioned(
            child: Transform.rotate(
              angle: -45.0,
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: AppColors.mainBlackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ColorsWidget extends StatelessWidget {
  final Color? color;

  const _ColorsWidget({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(getPropScreenWidth(3.0)),
      color: color,
    );
  }
}
