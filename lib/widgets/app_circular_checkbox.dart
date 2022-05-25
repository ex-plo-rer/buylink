import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/constants/colors.dart';

class AppCCheckBox extends StatelessWidget {
  final String text;
  final bool checked;
  final Function onChanged;
  final Color activeColor;
  final Color checkColor;


  const AppCCheckBox({
    Key? key,
    required this.text,
    required this.checked,
    required this.onChanged,
    this.activeColor = AppColors.grey,
    this.checkColor = AppColors.grey6,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          shape: CircleBorder(),
          value: checked,
          onChanged: (v) => onChanged(),
          activeColor: activeColor,
          checkColor: checkColor,

          //),
        ),
        const Spacing.smallWidth(),
        Text(
          text,
          style: const TextStyle(
            color: AppColors.grey2,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
