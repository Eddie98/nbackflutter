import 'package:flutter/material.dart';
import 'package:nbackflutter/constants/index.dart';
import 'package:nbackflutter/view/screens/training/bloc/training_bloc.dart';

class CountersRowWidget extends StatelessWidget {
  final TrainingProccess state;

  const CountersRowWidget(this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _CounterWidget(
          allText,
          state.counter,
          TextStyles.allColorPositionTS().copyWith(
            color: const Color.fromRGBO(224, 224, 224, 1),
          ),
        ),
        _CounterWidget(
          correctText,
          state.correctAnswers.length,
          TextStyles.allColorPositionTS().copyWith(
            color: const Color.fromRGBO(76, 175, 80, 1),
          ),
        ),
        _CounterWidget(
          wrongText,
          state.wrongAnswers.length,
          TextStyles.allColorPositionTS().copyWith(
            color: const Color.fromRGBO(244, 67, 54, 1),
          ),
        ),
      ],
    );
  }
}

class _CounterWidget extends StatelessWidget {
  final String text;
  final int counterInt;
  final TextStyle textStyle;

  const _CounterWidget(
    this.text,
    this.counterInt,
    this.textStyle, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: textStyle,
        children: [
          TextSpan(text: text),
          TextSpan(text: ' $counterInt'),
        ],
      ),
    );
  }
}
