import 'package:flutter/material.dart';
import 'package:nbackflutter/constants/index.dart';
import 'package:nbackflutter/utils/index.dart';

import '../bloc/training_bloc.dart';

class BoardWidget extends StatelessWidget {
  final TrainingProccess state;
  final double bodyHeight;
  final bool zenMode;
  final bool hints;

  const BoardWidget(
    this.state,
    this.bodyHeight, {
    Key? key,
    this.zenMode = false,
    this.hints = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const spacingsHeight = 18.0;
    const countersHeight = 23.0;
    late double itemHeight;

    if (zenMode) {
      itemHeight = (bodyHeight - (defaultHorPadding * 2)) / 3;
    } else {
      itemHeight = (bodyHeight -
              (defaultHorPadding * 2) -
              countersHeight -
              spacingsHeight) /
          3;
    }

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
          vertical: getPropScreenWidth(defaultHorPadding),
        ),
        children: List.generate(9, (index) {
          if (!state.isPause &&
              state.positions.isNotEmpty &&
              index == state.positions.last) {
            return _GridItemWidget(
              index,
              color: state.colors.last,
              hints: hints,
            );
          }
          return _GridItemWidget(
            index,
            hints: hints,
          );
        }),
      ),
    );
  }
}

class _GridItemWidget extends StatelessWidget {
  final int index;
  final bool hints;
  final Color? color;

  const _GridItemWidget(
    this.index, {
    this.color,
    required this.hints,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mainGreyColor,
      child: index == 4
          ? const _CrossWidget()
          : _ColorsWidget(index: hints ? index : null, color: color),
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
  final int? index;
  final Color? color;

  const _ColorsWidget({
    Key? key,
    this.index,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(getPropScreenWidth(3.0)),
      color: color,
      alignment: Alignment.center,
      child: index == null
          ? null
          : Text(
              index.toString(),
              style: TextStyles.boardIndexText(),
            ),
    );
  }
}
