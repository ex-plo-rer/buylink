import 'package:flutter/painting.dart';

class AppColors {
  AppColors._();

  static const primaryColor = Color(0xFF4167B2);
  static const secondaryColor = Color(0xFF707070);

  static const light = Color(0xFFFFFFFF);
  static const dark = Color(0xFF000000);
  static const grey = Color(0xFF333333);
  static const red = Color(0xFFD71D1D);
  static const redshade1 = Color (0xFFF8EEEE);
  static const grey1 = Color(0xFF232834);
  static const grey2 = Color(0xFF3A4150);
  static const grey3 = Color(0xFF4B5263);
  static const grey4 = Color(0xFF5C6475);
  static const grey5 = Color(0xFF757C8A);
  static const grey6 = Color(0xFFA6ACB9);
  static const grey7 = Color(0xFFCED2D9);
  static const grey8 = Color(0xFFE8EAED);
  static const grey9 = Color(0xFFF9FAFB);
  static const grey10 = Color(0xFFF4F4F6);
  static const shade1 = Color(0xFFDAEAFA);
  static const shade2 = Color(0xFFB9D3F6);
  static const shade3 = Color(0xFF8FB3E7);
  static const shade4 = Color(0xFF6E92D0);
  static const shade5 = Color(0xFF4167B2);
  static const shade6 = Color(0xFF2F4F98);
  static const shade7 = Color(0xFF223A80);
  static const shade8 = Color(0xFF152767);
  static const shade9 = Color(0xFF0C1A55);
  static const transparent = Color(0xff0000ffff);
  static const star = Color(0xFFFFB100);


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
      return AppColors.grey2;
    }
  }
}
