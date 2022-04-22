import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';

import '../core/constants/colors.dart';

class AppLinearProgress extends StatelessWidget {
  const AppLinearProgress({
    Key? key,
    required this.current,
    required this.total,
    this.minHeight = 8,
    this.value,
  }) : super(key: key);
  final int current;
  final int total;
  final double? minHeight;
  final double? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('$current of $total'),
        const Spacing.height(4),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            backgroundColor: AppColors.grey8,
            color: AppColors.primaryColor,
            minHeight: minHeight,
            value: value,
          ),
        ),
      ],
    );
  }
}
