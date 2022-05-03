import 'package:flutter/material.dart';

import '../core/constants/colors.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    Key? key,
    required this.title,
    required this.text1,
    required this.text2,
    this.onText1Pressed,
    this.onText2Pressed,
  }) : super(key: key);
  final String title;
  final String text1;
  final void Function()? onText1Pressed;
  final String text2;
  final void Function()? onText2Pressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColors.grey1,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: <Widget>[
        TextButton(
          child: Text(
            text1,
            style: const TextStyle(
              color: AppColors.primaryColor,
            ),
          ),
          onPressed: onText1Pressed,
        ),
        Container(
          height: 24,
          width: 2,
          color: AppColors.shade2,
        ),
        TextButton(
          child: Text(
            text2,
            style: TextStyle(
              color: AppColors.primaryColor,
            ),
          ),
          onPressed: onText2Pressed,
        ),
      ],
    );
  }
}
