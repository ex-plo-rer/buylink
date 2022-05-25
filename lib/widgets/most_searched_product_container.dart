import 'package:buy_link/widgets/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../core/constants/colors.dart';
import '../core/constants/strings.dart';
import 'app_rating_bar.dart';

class MostSearchedProductContainer extends StatelessWidget {
  const MostSearchedProductContainer({
    Key? key,
    required this.productName,
    required this.productImage,
    required this.rating,
    required this.noOfSearches,
  }) : super(key: key);

  final String productName;
  final String productImage;
  final int rating;
  final int noOfSearches;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      height: 164,
      width: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(
        color: AppColors.grey1,
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            productImage,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Most searched product',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.grey8,
                ),
              ),
              AppRatingBar(
                itemPadding: 4,
                initialRating: rating.toDouble(),
                ignoreGestures: true,
                onRatingUpdate: (rating) {},
              ),
            ],
          ),
          const Spacing.mediumHeight(),
          Text(
            '$noOfSearches',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: AppColors.grey8,
            ),
          ),
          const Spacing.tinyHeight(),
          Text(
            productName,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.grey8,
            ),
          ),
        ],
      ),
    );
  }
}
