import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nbackflutter/utils/index.dart';
import 'package:nbackflutter/view/screens/training/bloc/training_bloc.dart';
import 'package:nbackflutter/view/widgets/index.dart';

class HistoryRow extends StatelessWidget {
  const HistoryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainingBloc, TrainingState>(
      builder: (context, state) {
        if (state is TrainingProccess) {
          return Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  state.positions.length,
                  (index) {
                    final position = state.positions.reversed.elementAt(index);
                    final color = state.colors.reversed.elementAt(index);

                    return Row(
                      children: [
                        sizedBoxWidth(12.0),
                        Container(
                          width: getPropScreenWidth(kToolbarHeight / 3),
                          height: getPropScreenWidth(kToolbarHeight / 3),
                          color: color,
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
