import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/constants/colors.dart';
import '../core/constants/strings.dart';

class AppButton2 extends StatelessWidget {
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color borderColor;
  final String text;
  final Color? textColor;
  final double borderRadius;
  final double? width;
  final double? height;
  final double? fontSize;
  final bool isLoading;
  final bool hasIcon;
  final Widget? icon;
  final String prevIcon;

  const AppButton2(
      {Key? key,
      this.onPressed,
      this.backgroundColor = AppColors.transparent,
      required this.text,
      this.textColor = AppColors.light,
      this.borderRadius = 8,
      this.width = double.maxFinite,
      this.height = 56,
      this.fontSize = 16,
      this.isLoading = false,
      this.hasIcon = false,
      this.icon,
      this.borderColor = AppColors.transparent,
      this.prevIcon = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      // Wrap with SizedBox whenever you want a specific width or height.
      disabledColor: AppColors.grey6,
      child: SizedBox(
        width: width,
        height: height,
        child: OutlinedButton.icon(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            side: BorderSide(color: borderColor),
            backgroundColor: backgroundColor,
          ),
          label: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Text(
              isLoading ? AppStrings.loading : text,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w700,
                fontSize: fontSize,
              ),
            ),
            SvgPicture.asset(prevIcon)
          ]),
          icon: hasIcon ? icon! : Container(),
        ),
      ),
    );
  }
}
