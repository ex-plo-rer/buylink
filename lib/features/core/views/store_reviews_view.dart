import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/constants/images.dart';
import 'package:buy_link/core/constants/svgs.dart';
import 'package:buy_link/core/routes.dart';
import 'package:buy_link/features/core/notifiers/home_notifier.dart';
import 'package:buy_link/features/core/views/single_rating.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/app_button.dart';
import 'package:buy_link/widgets/app_progress_bar.dart';
import 'package:buy_link/widgets/app_text_field.dart';
import 'package:buy_link/widgets/category_container.dart';
import 'package:buy_link/widgets/compare_texts.dart';
import 'package:buy_link/widgets/compare_texts_2.dart';
import 'package:buy_link/widgets/iconNtext_container.dart';
import 'package:buy_link/widgets/product_container.dart';
import 'package:buy_link/widgets/product_image_container.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/strings.dart';

class StoreReviewsView extends ConsumerWidget {
  StoreReviewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.dark, //change your color here
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            size: 12,
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.transparent,
        title: const Text(
          'Atinuke Stores',
          style: TextStyle(
            color: AppColors.dark,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            // vertical: 16,
            horizontal: 20,
          ),
          child: Column(
            children: [
              Container(
                height: 128,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  color: AppColors.shade1,
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '4.6',
                            style: TextStyle(
                              fontSize: 44,
                              color: AppColors.grey1,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          // const Spacing.tinyHeight(),
                          const Text(
                            'Based on 54 reviews',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.grey5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacing.tinyHeight(),
                          RatingBar.builder(
                            itemSize: 15,
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 0.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SingleRating(
                            starNumber: '5',
                            noOfRatings: '40',
                            ratingValue: 0.8,
                          ),
                          Spacing.smallHeight(),
                          SingleRating(
                            starNumber: '4',
                            noOfRatings: '10',
                            ratingValue: 0.6,
                          ),
                          Spacing.smallHeight(),
                          SingleRating(
                            starNumber: '3',
                            noOfRatings: '04',
                            ratingValue: 0.3,
                          ),
                          Spacing.smallHeight(),
                          SingleRating(
                            starNumber: '2',
                            noOfRatings: '00',
                            ratingValue: 0.0,
                          ),
                          Spacing.smallHeight(),
                          SingleRating(
                            starNumber: '1',
                            noOfRatings: '00',
                            ratingValue: 0.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacing.bigHeight(),
              const Divider(thickness: 2),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => ref
                          .read(navigationServiceProvider)
                          .navigateToNamed(Routes.addReview),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.chat,
                            size: 16,
                          ),
                          const Text(
                            ' Add Review',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.grey1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 12,
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 2),
              const Spacing.mediumHeight(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const IconNTextContainer(
                    text: 'All',
                    containerColor: AppColors.shade1,
                    icon: Icon(
                      Icons.star_outline,
                      size: 12,
                    ),
                    radius: 6,
                    fontSize: 14,
                  ),
                  const IconNTextContainer(
                    text: '5',
                    containerColor: AppColors.shade1,
                    icon: Icon(
                      Icons.star_outline,
                      size: 12,
                    ),
                    radius: 6,
                    fontSize: 14,
                  ),
                  const IconNTextContainer(
                    text: '4',
                    containerColor: AppColors.shade1,
                    icon: Icon(
                      Icons.star_outline,
                      size: 12,
                    ),
                    radius: 6,
                    fontSize: 14,
                  ),
                  const IconNTextContainer(
                    text: '3',
                    containerColor: AppColors.shade1,
                    icon: Icon(
                      Icons.star_outline,
                      size: 12,
                    ),
                    radius: 6,
                    fontSize: 14,
                  ),
                  const IconNTextContainer(
                    text: '2',
                    containerColor: AppColors.shade1,
                    icon: Icon(
                      Icons.star_outline,
                      size: 12,
                    ),
                    radius: 6,
                    fontSize: 14,
                  ),
                  const IconNTextContainer(
                    text: '1',
                    containerColor: AppColors.shade1,
                    icon: Icon(
                      Icons.star_outline,
                      size: 12,
                    ),
                    radius: 6,
                    fontSize: 14,
                  ),
                  Container(),
                ],
              ),
              const Spacing.mediumHeight(),
              Expanded(
                child: ListView.separated(
                  itemCount: 4,
                  separatorBuilder: (context, index) =>
                      const Spacing.bigHeight(),
                  itemBuilder: (context, index) => Container(
                    height: 208,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.grey8,
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(radius: 16),
                                Spacing.tinyWidth(),
                                Text(
                                  'Ayodeji',
                                  style: TextStyle(
                                    color: AppColors.grey1,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '22/04/21',
                                  style: TextStyle(
                                    color: AppColors.grey5,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Spacing.tinyWidth(),
                                RatingBar.builder(
                                  itemSize: 12,
                                  initialRating: 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 0.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            'Love this app. I lost my vision three years ago and was told that this app is very useful. I use it almost daily on the go in at home. Everything works pretty seamless except for the color reader which can be kind of an accurate at times. It would be amazing if you guys can add Love this app. I lost my vision three years ago and was told that this app is very useful. I use it almost daily on the go in at home. Everything works pretty seamless except for the color reader which can be kindLove this app. I lost my vision three years ago and was toldLove this app. I lost my vision three years ago and was told',
                            overflow: TextOverflow.fade,
                            maxLines: 10,
                            style: TextStyle(
                              color: AppColors.grey5,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'See more',
                            style: TextStyle(
                              color: AppColors.grey5,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
