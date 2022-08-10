import 'package:flutter/material.dart';
import 'package:nbackflutter/constants/app_constants.dart';

import '../bloc/training_bloc.dart';

class BoardWidget extends StatelessWidget {
  final TrainingProccess state;

  const BoardWidget(
    this.state, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // TODO: aspect ratio exact
    final double itemHeight = size.height / 3.2;
    final double itemWidth = size.width / 2;

    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1.0,
        childAspectRatio: itemWidth / itemHeight,
        padding: const EdgeInsets.symmetric(
          horizontal: defaultHorPadding,
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
      color: const Color.fromRGBO(224, 224, 224, 1),
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
              color: const Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
          Positioned(
            child: Transform.rotate(
              angle: -45.0,
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: const Color.fromRGBO(0, 0, 0, 1),
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
      margin: const EdgeInsets.all(6.0),
      color: color,
    );
  }
}
