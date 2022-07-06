import 'package:flutter/material.dart';

import '../core/constants/colors.dart';

class IconNTextContainer extends StatelessWidget {
  const IconNTextContainer(
      {Key? key,
      this.onTap,
      required this.text,
      this.containerColor = AppColors.light,
      this.textColor = AppColors.grey1,
      required this.icon,
      this.radius = 50,
      this.fontSize = 10,
      this.padding = 8})
      : super(key: key);
  final void Function()? onTap;
  final String text;
  final Color? containerColor;
  final Color? textColor;
  final Widget icon;
  final double radius;
  final double? fontSize;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: containerColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            // SvgPicture.asset(
            //   AppSvgs.text,
            //   color: icon,
            // ),
            Text(
              ' $text',
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
