import 'package:flutter/material.dart';

import '../core/constants/colors.dart';

class CustomisedText extends StatelessWidget {
  const CustomisedText({
    Key? key,
    this.height = 56,
    required this.text,
    this.fontSize = 24,
    this.verticalPadding = 10,
  }) : super(key: key);
  final double? height;
  final String text;
  final double? fontSize;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.only(top: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.shade1,
      ),
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: 10,
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          text,
          textAlign: TextAlign.justify,
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
