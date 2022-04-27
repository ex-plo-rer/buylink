import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/constants/colors.dart';
import '../core/constants/svgs.dart';

class FavoriteContainer extends StatelessWidget {
  const FavoriteContainer({
    Key? key,
    this.onFavoriteTapped,
    required this.favIcon,
    this.containerColor = AppColors.light,
    this.radius = 50,
    this.height,
    this.width,
    this.padding = 10,
    this.hasBorder = false,
  }) : super(key: key);
  final void Function()? onFavoriteTapped;
  final Widget favIcon;
  final Color? containerColor;
  final double radius;
  final double? height;
  final double? width;
  final double padding;
  final bool hasBorder;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onFavoriteTapped,
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: containerColor,
          border: hasBorder ? Border.all(color: AppColors.primaryColor) : null,
        ),
        child: SizedBox(
          width: 20,
          height: 18,
          child: favIcon,
        ),
      ),
    );
  }
}
