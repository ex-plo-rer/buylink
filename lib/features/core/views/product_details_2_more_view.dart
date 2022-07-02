import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/constants/images.dart';
import 'package:buy_link/core/constants/svgs.dart';
import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/features/core/notifiers/home_notifier.dart';
import 'package:buy_link/features/core/notifiers/product_details_notifier.dart';
import 'package:buy_link/widgets/app_button.dart';
import 'package:buy_link/widgets/app_text_field.dart';
import 'package:buy_link/widgets/category_container.dart';
import 'package:buy_link/widgets/circular_progress.dart';
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
import '../../../services/navigation_service.dart';
import '../notifiers/product_details_2_notifier.dart';

class ProductDetails2MoreView extends ConsumerWidget {
  ProductDetails2MoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final productDetails2Notifier = ref.watch(productDetails2NotifierProvider);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.dark, //change your color here
        ),
        leading: IconButton(
          onPressed: () {
            ref.read(navigationServiceProvider).navigateBack();
          },
          icon: const Icon(Icons.arrow_back_ios_outlined,
              size: 15, color: AppColors.grey2),
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
            child: productDetails2Notifier.state.isLoading
                ? const CircularProgress()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spacing.smallHeight(),
                      Spacing.smallHeight(),
                      CompareTexts(
                        title: 'Brand:',
                        subTitle: productDetails2Notifier.productAttr.brand,
                        titleColor: AppColors.grey1,
                        titleSize: 14,
                      ),
                      const Spacing.height(12),
                      CompareTexts(
                        title: 'Model:',
                        subTitle: productDetails2Notifier.productAttr.model,
                        titleColor: AppColors.grey1,
                        titleSize: 14,
                      ),
                      const Spacing.height(12),
                      CompareTexts(
                        title: 'Color:',
                        subTitle: productDetails2Notifier.productAttr.color,
                        titleColor: AppColors.grey1,
                        titleSize: 14,
                      ),
                      const Spacing.height(12),
                      const CompareTexts(
                        title: 'Styling:',
                        subTitle: 'High stretch,5-pocket styling',
                        titleColor: AppColors.grey1,
                        titleSize: 14,
                      ),
                      const Spacing.height(12),
                      CompareTexts(
                        title: 'Material:',
                        subTitle: productDetails2Notifier.productAttr.material,
                        titleColor: AppColors.grey1,
                        titleSize: 14,
                      ),
                      const Spacing.height(12),
                      CompareTexts(
                        title: 'Care:',
                        subTitle: productDetails2Notifier.productAttr.care,
                        titleColor: AppColors.grey1,
                        titleSize: 14,
                      ),
                      const Spacing.height(12),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
