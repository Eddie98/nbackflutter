import 'package:flutter/material.dart';
import 'package:nbackflutter/constants/index.dart';
import 'package:nbackflutter/utils/index.dart';

class FooterButton extends StatelessWidget {
  final int index;
  final String text;
  final void Function()? onTap;

  const FooterButton({
    Key? key,
    required this.index,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: getPropScreenWidth(6.0)),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            fixedSize: Size(50, getPropScreenWidth(54.0)),
            textStyle: TextStyles.trainingFooterButtonsTS.copyWith(
              fontSize: getAdaptiveFontSize(15.0),
            ),
            primary: AppColors.themeColor,
          ),
          child: Text(text.toUpperCase()),
        ),
      ),
    );
  }
}
