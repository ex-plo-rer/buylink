import 'package:flutter/material.dart';

import '../core/constants/colors.dart';

class AppProgressBar extends StatelessWidget {
  const AppProgressBar({
    Key? key,
    this.backgroundColor = AppColors.grey8,
    this.fillColor = AppColors.primaryColor,
    this.minHeight = 8,
    this.value,
  }) : super(key: key);
  final Color? backgroundColor;
  final Color? fillColor;
  final double? minHeight;
  final double? value;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: LinearProgressIndicator(
        backgroundColor: backgroundColor,
        color: fillColor,
        minHeight: minHeight,
        value: value,
      ),
    );
  }
}
