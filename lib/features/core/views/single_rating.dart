import 'package:buy_link/core/constants/svgs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/colors.dart';
import '../../../widgets/app_progress_bar.dart';

class SingleRating extends StatelessWidget {
  const SingleRating({
    Key? key,
    required this.starNumber,
    required this.noOfRatings,
    required this.ratingValue,
  }) : super(key: key);

  final String starNumber;
  final String noOfRatings;
  final double? ratingValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          '$starNumber ',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.grey2,
          ),
        ),
        SvgPicture.asset(
          AppSvgs.starFilled,
          width: 10,
          height: 10,
        ),
        Text(
          ' ($noOfRatings) ',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.grey2,
          ),
        ),
        Expanded(
          child: AppProgressBar(
            fillColor: AppColors.yellow,
            value: ratingValue,
            minHeight: 4,
          ),
        ),
      ],
    );
  }
}
