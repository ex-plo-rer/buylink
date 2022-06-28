import 'package:buy_link/widgets/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import '../core/constants/colors.dart';
import '../core/constants/strings.dart';
import '../core/constants/svgs.dart';
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
      width: MediaQuery.of(context).size.width - 60,
      decoration: BoxDecoration(
        color: AppColors.grey1,
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          opacity: 0.6,
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

      // RatingBar.builder(
      //   itemSize: 20,
      //   initialRating: rating.toDouble(),
      //   minRating: 0,
      //   direction: Axis.horizontal,
      //   allowHalfRating: true,
      //   itemCount: 5,
      //   ignoreGestures: true,
      //   unratedColor: AppColors.grey7,
      //   itemPadding: EdgeInsets.symmetric(horizontal: 4),
      //   itemBuilder: (context, _) => SvgPicture.asset(
      //     AppSvgs.star,
      //     color: Colors.amber,
      //     //  width: ,
      //   ),
      //   onRatingUpdate: (rating){},
      // ),
              AppRatingBar(
                itemSize: 14,
                itemPadding: 1,
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
