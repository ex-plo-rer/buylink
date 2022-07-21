import 'package:buy_link/core/utilities/extensions/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/constants/colors.dart';
import '../core/constants/svgs.dart';

class DistanceContainer extends StatelessWidget {
  const DistanceContainer({
    Key? key,
    this.onDistanceTapped,
    required this.distance,
    this.containerColor = AppColors.light,
    this.textColor = AppColors.grey1,
    this.iconColor = AppColors.dark,
  }) : super(key: key);
  final void Function()? onDistanceTapped;
  final String distance;
  final Color? containerColor;
  final Color? textColor;
  final Color? iconColor;

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
            SvgPicture.asset(
              AppSvgs.distance,
              color: iconColor,
            ),
            Text(
              // ' $distance km',
              ' ${''.extractDouble(double.parse(distance))} km',
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
