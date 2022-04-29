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

class CompareView extends ConsumerWidget {
  bool haveProductToCompare = true;

  CompareView({Key? key}) : super(key: key);

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
          AppStrings.compare,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppTextField(
                hintText: 'Search for another product to compare',
                prefixIcon: Icon(Icons.search_outlined),
                hasBorder: false,
                isSearch: true,
                fillColor: AppColors.grey8,
                hasPrefixIcon: true,
              ),
              const Spacing.height(12),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Expanded(
                            child: const Padding(
                              padding: const EdgeInsets.only(right: 6.0),
                              child: ProductImageContainer(
                                productImage: 'productImage',
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 6.0),
                              // TODO: Check if there is a product to compare with.
                              child: haveProductToCompare
                                  ? const ProductImageContainer(
                                      productImage: 'productImage',
                                    )
                                  : const SizedBox(
                                      height: 160,
                                      child: Center(
                                        child: Text(
                                          'Search to add another product to compare',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                      const Spacing.bigHeight(),
                      CompareTexts2(
                        title: 'Name',
                        subTitle1: 'Levi Jean Trousers',
                        subTitle2: 'Adidas Jean Trousers',
                        haveProductToCompare: haveProductToCompare,
                      ),
                      CompareTexts2(
                        title: 'Price',
                        subTitle1: '#3000',
                        subTitle2: '#1500',
                        haveProductToCompare: haveProductToCompare,
                      ),
                      CompareTexts2(
                        title: 'Distance',
                        subTitle1: '2.8km',
                        subTitle2: '3.0km',
                        haveProductToCompare: haveProductToCompare,
                      ),
                      CompareTexts2(
                        title: 'Color',
                        subTitle1: 'Blue',
                        subTitle2: 'Blue',
                        haveProductToCompare: haveProductToCompare,
                      ),
                      CompareTexts2(
                        title: 'Style',
                        subTitle1: 'High stretch,5-pocket styling',
                        subTitle2: 'High Waist, Baggy',
                        haveProductToCompare: haveProductToCompare,
                      ),
                      CompareTexts2(
                        title: 'Style',
                        subTitle1: 'High stretch,5-pocket styling',
                        subTitle2: 'High Waist, Baggy',
                        haveProductToCompare: haveProductToCompare,
                      ),
                      CompareTexts2(
                        title: 'Style',
                        subTitle1: 'High stretch,5-pocket styling',
                        subTitle2: 'High Waist, Baggy',
                        haveProductToCompare: haveProductToCompare,
                      ),
                      CompareTexts2(
                        title: 'Style',
                        subTitle1: 'High stretch,5-pocket styling',
                        subTitle2: 'High Waist, Baggy',
                        haveProductToCompare: haveProductToCompare,
                      ),
                      CompareTexts2(
                        title: 'Style',
                        subTitle1: 'High stretch,5-pocket styling',
                        subTitle2: 'High Waist, Baggy',
                        haveProductToCompare: haveProductToCompare,
                      ),
                      CompareTexts2(
                        title: 'Style',
                        subTitle1: 'High stretch,5-pocket styling',
                        subTitle2: 'High Waist, Baggy',
                        haveProductToCompare: haveProductToCompare,
                      ),
                      CompareTexts2(
                        title: 'Style',
                        subTitle1: 'High stretch,5-pocket styling',
                        subTitle2: 'High Waist, Baggy',
                        haveProductToCompare: haveProductToCompare,
                      ),
                      CompareTexts2(
                        title: 'Style',
                        subTitle1: 'High stretch,5-pocket styling',
                        subTitle2: 'High Waist, Baggy',
                        haveProductToCompare: haveProductToCompare,
                      ),
                      CompareTexts2(
                        title: 'Style',
                        subTitle1: 'High stretch,5-pocket styling',
                        subTitle2: 'High Waist, Baggy',
                        haveProductToCompare: haveProductToCompare,
                      ),
                      CompareTexts2(
                        title: 'Style',
                        subTitle1: 'High stretch,5-pocket styling',
                        subTitle2: 'High Waist, Baggy',
                        haveProductToCompare: haveProductToCompare,
                      ),
                      CompareTexts2(
                        title: 'Style',
                        subTitle1: 'High stretch,5-pocket styling',
                        subTitle2: 'High Waist, Baggy',
                        haveProductToCompare: haveProductToCompare,
                      ),
                      CompareTexts2(
                        title: 'Style',
                        subTitle1: 'High stretch,5-pocket styling',
                        subTitle2: 'High Waist, Baggy',
                        haveProductToCompare: haveProductToCompare,
                      ),
                      CompareTexts2(
                        title: 'Style',
                        subTitle1: 'High stretch,5-pocket styling',
                        subTitle2: 'High Waist, Baggy',
                        haveProductToCompare: haveProductToCompare,
                      ),
                      CompareTexts2(
                        title: 'Style',
                        subTitle1: 'High stretch,5-pocket styling',
                        subTitle2: 'High Waist, Baggy',
                        haveProductToCompare: haveProductToCompare,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Expanded(
//   child: SingleChildScrollView(
//     child: Row(
//       mainAxisSize: MainAxisSize.max,
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.only(right: 6.0),
//                 child: ProductImageContainer(
//                   productImage: 'productImage',
//                 ),
//               ),
//               const Spacing.bigHeight(),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Text(
//                     'Name',
//                     style: TextStyle(
//                       color: AppColors.primaryColor,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   Spacing.tinyHeight(),
//                   Text(
//                     'Levi Jean Trousers',
//                     style: TextStyle(
//                       color: AppColors.grey1,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//               const Divider(thickness: 2)
//             ],
//           ),
//         ),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.only(left: 6.0),
//                 child: ProductImageContainer(
//                   productImage: 'productImage',
//                 ),
//               ),
//               const Spacing.bigHeight(),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Padding(
//                     padding: EdgeInsets.only(left: 6.0),
//                     child: Text(
//                       '',
//                       style: TextStyle(
//                         color: AppColors.primaryColor,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   Spacing.tinyHeight(),
//                   Padding(
//                     padding: EdgeInsets.only(left: 6.0),
//                     child: Text(
//                       'Levi Jean Trousers',
//                       style: TextStyle(
//                         color: AppColors.grey1,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const Divider(thickness: 2)
//             ],
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
