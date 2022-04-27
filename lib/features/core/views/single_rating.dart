import 'package:flutter/material.dart';

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
        const Icon(
          Icons.star_outline,
          size: 10,
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
            fillColor: AppColors.dark,
            value: ratingValue,
            minHeight: 4,
          ),
        ),
      ],
    );
  }
}
