import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/constants/images.dart';
import 'package:buy_link/core/constants/svgs.dart';
import 'package:buy_link/features/core/notifiers/home_notifier.dart';
import 'package:buy_link/widgets/app_button.dart';
import 'package:buy_link/widgets/app_text_field.dart';
import 'package:buy_link/widgets/category_container.dart';
import 'package:buy_link/widgets/compare_texts.dart';
import 'package:buy_link/widgets/compare_texts_2.dart';
import 'package:buy_link/widgets/product_container.dart';
import 'package:buy_link/widgets/product_image_container.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/strings.dart';

class ProductDetailsMoreView extends ConsumerWidget {
  ProductDetailsMoreView({Key? key}) : super(key: key);

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
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.transparent,
        title: const Text(
          AppStrings.productDetails,
          style: TextStyle(
            color: AppColors.dark,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              // vertical: 16,
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CompareTexts(
                  title: 'Brand:',
                  subTitle: 'Levi',
                  titleColor: AppColors.grey1,
                  titleSize: 14,
                ),
                Spacing.height(12),
                CompareTexts(
                  title: 'Model:',
                  subTitle: 'Melinda',
                  titleColor: AppColors.grey1,
                  titleSize: 14,
                ),
                Spacing.height(12),
                CompareTexts(
                  title: 'Color:',
                  subTitle: 'Blue',
                  titleColor: AppColors.grey1,
                  titleSize: 14,
                ),
                Spacing.height(12),
                CompareTexts(
                  title: 'Styling:',
                  subTitle: 'High stretch,5-pocket styling',
                  titleColor: AppColors.grey1,
                  titleSize: 14,
                ),
                Spacing.height(12),
                CompareTexts(
                  title: 'Material:',
                  subTitle:
                      '61% cotton, 19% polyester, 19% TENCEL™ lyocell, 1% elastane,denim',
                  titleColor: AppColors.grey1,
                  titleSize: 14,
                ),
                Spacing.height(12),
                CompareTexts(
                  title: 'Care:',
                  subTitle:
                      'Wash your jeans once every 10 wears at most; this increases their lifespan and saves natural resources.When you eventually launder your jeans, wash and dry them inside out with like colors; liquid detergent is recommended',
                  titleColor: AppColors.grey1,
                  titleSize: 14,
                ),
                Spacing.height(12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
