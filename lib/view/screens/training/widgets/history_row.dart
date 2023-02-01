import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nbackflutter/constants/app_constants.dart';
import 'package:nbackflutter/utils/index.dart';
import 'package:nbackflutter/view/screens/training/bloc/training_bloc.dart';
import 'package:nbackflutter/view/widgets/index.dart';

class HistoryRow extends StatelessWidget {
  const HistoryRow({
    super.key,
    required this.nBackValue,
    required this.isSingleDimension,
  });

  final int nBackValue;
  final bool isSingleDimension;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainingBloc, TrainingState>(
      builder: (context, state) {
        if (state is TrainingProccess) {
          final slicedPositions = state.positions.reversed.take(nBackValue + 1);
          final slicedColors = state.colors.reversed.take(nBackValue + 1);

          return Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  slicedPositions.length,
                  (index) {
                    final position = slicedPositions.elementAt(index);
                    final color = slicedColors.elementAt(index);

                    return Row(
                      children: [
                        sizedBoxWidth(12.0),
                        Container(
                          width: getPropScreenWidth(kToolbarHeight / 3),
                          height: getPropScreenWidth(kToolbarHeight / 3),
                          color:
                              isSingleDimension ? singleDimensionColor : color,
                        ),
                        sizedBoxWidth(4.0),
                        Text(position.toString()),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
