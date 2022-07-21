import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';

import '../core/constants/colors.dart';

class CompareTexts extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color? titleColor;
  final double? titleSize;
  final Color? subTitleColor;
  final double? subTitleSize;

  const CompareTexts({
    Key? key,
    required this.title,
    required this.subTitle,
    this.titleColor = AppColors.primaryColor,
    this.titleSize = 12,
    this.subTitleColor = AppColors.grey1,
    this.subTitleSize = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style: TextStyle(
              color: titleColor,
              fontSize: titleSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Spacing.tinyHeight(),
        RichText(
          text: TextSpan(
            text: subTitle,
            style: TextStyle(
              color: subTitleColor,
              fontSize: subTitleSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
