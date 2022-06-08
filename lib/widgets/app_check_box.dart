import 'package:buy_link/widgets/spacing.dart';
import 'package:buy_link/widgets/text_with_rich.dart';
import 'package:flutter/material.dart';
import '../core/constants/colors.dart';

class AppCheckBox extends StatelessWidget {
  final String text;
  final bool checked;
  final void Function(bool?)? onChanged;
  final Color activeColor;
  final Color checkColor;
  final OutlinedBorder? shape;

  AppCheckBox({
    Key? key,
    required this.text,
    required this.checked,
    required this.onChanged,
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(1.0)),
    ),
    this.activeColor = AppColors.primaryColor,
    this.checkColor = AppColors.light,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacing.tinyWidth(),
        SizedBox(
          height: 12.0,
          width: 12.0,
          child: Checkbox(
            value: checked,
            onChanged: onChanged,
            activeColor: activeColor,
            checkColor: checkColor,
            shape: shape,
          ),
        ),
        const Spacing.mediumWidth(),
        Text(
          text,
          style: const TextStyle(
            color: AppColors.grey5,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
