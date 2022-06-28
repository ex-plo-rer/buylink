import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/constants/colors.dart';
import '../core/constants/svgs.dart';

class IconNTextContainer2 extends StatelessWidget {
  const IconNTextContainer2(
      {Key? key,
        this.onDistanceTapped,
        required this.text,
        this.containerColor = AppColors.light,
        this.textColor = AppColors.grey1,
        required this.icon,
        this.radius = 50,
        this.fontSize = 10,
        this.padding = 8})
      : super(key: key);
  final void Function()? onDistanceTapped;
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
      onTap: onDistanceTapped,
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
            SizedBox(width: 1),
            Text(
              ' $text',
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
            // SvgPicture.asset(
            //   AppSvgs.text,
            //   color: icon,
            // ),

          ],
        ),
      ),
    );
  }
}