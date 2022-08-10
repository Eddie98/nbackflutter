import 'package:flutter/material.dart';
import 'package:nbackflutter/constants/index.dart';

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
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(50, 66),
            textStyle: TextStyles.trainingFooterButtonsTS,
            primary: AppColors.themeColor,
          ),
          child: Text(text.toUpperCase()),
        ),
      ),
    );
  }
}
