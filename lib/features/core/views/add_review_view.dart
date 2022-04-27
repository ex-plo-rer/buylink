import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/constants/images.dart';
import 'package:buy_link/core/constants/svgs.dart';
import 'package:buy_link/features/core/notifiers/home_notifier.dart';
import 'package:buy_link/features/core/views/single_rating.dart';
import 'package:buy_link/widgets/app_button.dart';
import 'package:buy_link/widgets/app_progress_bar.dart';
import 'package:buy_link/widgets/app_text_field.dart';
import 'package:buy_link/widgets/category_container.dart';
import 'package:buy_link/widgets/compare_texts.dart';
import 'package:buy_link/widgets/compare_texts_2.dart';
import 'package:buy_link/widgets/iconNtext_container.dart';
import 'package:buy_link/widgets/product_container.dart';
import 'package:buy_link/widgets/product_image_container.dart';
import 'package:buy_link/widgets/review_text_field.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/strings.dart';

class AddReviewView extends ConsumerWidget {
  AddReviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          'Add Review',
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
              const Text(
                'Your reviews are public and would only include your name',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.grey2,
                  fontSize: 12,
                ),
              ),
              const Spacing.bigHeight(),
              const Divider(thickness: 2),
              const Text(
                'Your overall rating of the store',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.grey2,
                  fontSize: 12,
                ),
              ),
              const Spacing.smallHeight(),
              RatingBar.builder(
                itemSize: 30,
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                itemBuilder: (context, _) => SvgPicture.asset(
                  AppSvgs.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              const Divider(thickness: 2),
              const Spacing.bigHeight(),
              const ReviewTextField(
                title: 'Title of your review',
                noOfChar: 300,
              ),
              const Spacing.height(20),
              const ReviewTextField(
                title: 'Title of your review',
                noOfChar: 300,
                maxLine: 9,
              ),
              const Spacing.height(40),
              const AppButton(
                text: 'Post Review',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
