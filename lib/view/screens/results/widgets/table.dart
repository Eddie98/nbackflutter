import 'package:flutter/cupertino.dart';
import 'package:nbackflutter/constants/index.dart';
import 'package:nbackflutter/utils/index.dart';
import 'package:nbackflutter/view/widgets/index.dart';

class TableWidget extends StatelessWidget {
  const TableWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getPropScreenWidth(defaultHorPadding),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          _ColumnWidget([
            categoryText,
            allText,
            positionText,
            colorText,
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
