import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/constants/colors.dart';

class AppDialog2 extends StatelessWidget {
  const AppDialog2({
    Key? key,
    required this.title,
    required this.title2,
    required this.text1,
    required this.text2,
    this.onText1Pressed,
    this.onText2Pressed,
  }) : super(key: key);
  final String title;
  final String title2;
  final String text1;

  final void Function()? onText1Pressed;
  final String text2;
  final void Function()? onText2Pressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(children: <Widget>[ Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.grey1,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          )
      ),
        Spacing.smallWidth(),

        Text(
          title2,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.grey5,
            fontSize: 14,
            //fontWeight: FontWeight.w200,
          ),
        ),

      ]),

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
            style: const TextStyle(
              color: AppColors.primaryColor,
            ),
          ),
          onPressed: onText2Pressed,
        ),
      ],
    );
  }
}
