import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';

import '../core/constants/colors.dart';
import '../core/constants/strings.dart';

class CompareTexts extends StatelessWidget {
  final String title;
  final String subTitle;

  const CompareTexts({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.primaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacing.tinyHeight(),
        Text(
          subTitle,
          style: const TextStyle(
            color: AppColors.grey1,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
