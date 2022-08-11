import 'package:flutter/cupertino.dart';
import 'package:nbackflutter/constants/index.dart';
import 'package:nbackflutter/utils/index.dart';
import 'package:nbackflutter/view/widgets/index.dart';

class TableWidget extends StatelessWidget {
  final int correctAll;
  final int correctColors;
  final int correctPositions;
  final int wrongAll;
  final int wrongColors;
  final int wrongPositions;

  const TableWidget({
    Key? key,
    required this.correctAll,
    required this.correctColors,
    required this.correctPositions,
    required this.wrongAll,
    required this.wrongColors,
    required this.wrongPositions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getPropScreenWidth(defaultHorPadding * 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const _ColumnWidget([
            categoryText,
            allText,
            positionText,
            colorText,
          ]),
          _ColumnWidget([
            correctText,
            correctAll.toString(),
            correctPositions.toString(),
            correctColors.toString(),
          ]),
          _ColumnWidget([
            wrongText,
            wrongAll.toString(),
            wrongPositions.toString(),
            wrongColors.toString(),
          ]),
        ],
      ),
    );
  }
}

class _ColumnWidget extends StatelessWidget {
  final List<String> list;

  const _ColumnWidget(this.list, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(list.length, (index) {
        return Column(
          children: [
            sizedBoxHeight(10.0),
            Text(
              list[index],
              style: TextStyles.allColorPositionTS(),
            ),
          ],
        );
      }),
    );
  }
}
