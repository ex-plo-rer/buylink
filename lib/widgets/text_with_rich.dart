import 'package:flutter/material.dart';

class TextWithRich extends StatelessWidget {
  final String firstText;
  final String secondText;
  final void Function()? onTapText;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? firstColor;
  final Color? secondColor;
  final MainAxisAlignment mainAxisAlignment;

  const TextWithRich({
    Key? key,
    required this.firstText,
    required this.secondText,
    this.onTapText,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.w600,
    this.firstColor,
    this.secondColor,
    this.mainAxisAlignment = MainAxisAlignment.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Text(
          '$firstText ',
          style: TextStyle(
            fontWeight: fontWeight,
            fontSize: fontSize,
            color: firstColor,
          ),
        ),
        GestureDetector(
          onTap: onTapText,
          child: Text(
            secondText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: secondColor,
              fontSize: fontSize,
            ),
          ),
        )
      ],
    );
  }
}
