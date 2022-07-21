import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/utilities/extensions/strings.dart';
import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/features/core/notifiers/product_details_notifier.dart';
import 'package:buy_link/widgets/circular_progress.dart';
import 'package:buy_link/widgets/compare_texts.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/strings.dart';
import '../../../services/navigation_service.dart';

class ProductDetailsMoreView extends ConsumerWidget {
  const ProductDetailsMoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final productDetailsNotifier = ref.watch(productDetailsNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.dark,
          //size: 14//change your color here
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
            child: productDetailsNotifier.state.isLoading
                ? Padding(
                    padding: EdgeInsets.only(
                        top: (MediaQuery.of(context).size.height / 2) - 150),
                    child: const CircularProgress(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacing.smallHeight(),
                      const Spacing.smallHeight(),
                      CompareTexts(
                        title: 'Brand:',
                        subTitle: productDetailsNotifier.productAttr.brand
                                .isNullOrEmpty()
                            ? 'N/A'
                            : productDetailsNotifier.productAttr.brand,
                        titleColor: AppColors.grey1,
                        titleSize: 14,
                        subTitleColor: AppColors.grey4,
                        subTitleSize: 14,
                      ),
                      const Spacing.height(12),
                      CompareTexts(
                        title: 'Model:',
                        subTitle: productDetailsNotifier.productAttr.model
                                .isNullOrEmpty()
                            ? 'N/A'
                            : productDetailsNotifier.productAttr.model,
                        titleColor: AppColors.grey1,
                        titleSize: 14,
                        subTitleColor: AppColors.grey4,
                        subTitleSize: 14,
                      ),
                      const Spacing.height(12),
                      CompareTexts(
                        title: 'Color:',
                        subTitle: productDetailsNotifier.productAttr.color
                                .isNullOrEmpty()
                            ? 'N/A'
                            : productDetailsNotifier.productAttr.color,
                        titleColor: AppColors.grey1,
                        titleSize: 14,
                        subTitleColor: AppColors.grey4,
                        subTitleSize: 14,
                      ),
                      const Spacing.height(12),
                      CompareTexts(
                        title: 'Material:',
                        subTitle: productDetailsNotifier.productAttr.material
                                .isNullOrEmpty()
                            ? 'N/A'
                            : productDetailsNotifier.productAttr.material,
                        // : 'N/A',
                        titleColor: AppColors.grey1,
                        titleSize: 14,
                        subTitleColor: AppColors.grey4,
                        subTitleSize: 14,
                      ),
                      const Spacing.height(12),
                      CompareTexts(
                        title: 'Care:',
                        subTitle: productDetailsNotifier.productAttr.care
                                .isNullOrEmpty()
                            ? 'N/A'
                            : productDetailsNotifier.productAttr.care,
                        titleColor: AppColors.grey1,
                        titleSize: 14,
                        subTitleColor: AppColors.grey4,
                        subTitleSize: 14,
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
