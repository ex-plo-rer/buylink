import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/constants/colors.dart';
import '../core/constants/svgs.dart';

class IconNTextContainer extends StatelessWidget {
  const IconNTextContainer({
    Key? key,
    this.onDistanceTapped,
    required this.text,
    this.containerColor = AppColors.light,
    this.textColor = AppColors.grey1,
    required this.icon,
  }) : super(key: key);
  final void Function()? onDistanceTapped;
  final String text;
  final Color? containerColor;
  final Color? textColor;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDistanceTapped,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
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
              ' $text km',
              style: TextStyle(
                color: textColor,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
