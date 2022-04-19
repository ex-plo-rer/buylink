import 'package:flutter/painting.dart';

class AppColors {
  AppColors._();

  static const primaryColor = Color(0xFF4167B2);
  static const secondaryColor = Color(0xFF707070);

  static const light = Color(0xFFFFFFFF);
  static const dark = Color(0xFF000000);
  static const grey = Color(0xFF333333);
  static const lightGrey1 = Color(0xFFE0E0E0);
  static const lightGrey2 = Color(0xFFB0B0B0);
  static const transparent = Color(0xff0000ffff);

  static const defaultShadow = BoxShadow(
    color: Color(0xFFEEEEEE),
    spreadRadius: 10,
    blurRadius: 10,
  );

  static Color getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      return Color(int.parse('ff$hexColor', radix: 16));
    } else {
      return AppColors.lightGrey2;
    }
  }
}
