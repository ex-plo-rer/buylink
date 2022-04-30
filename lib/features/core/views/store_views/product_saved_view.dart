import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/constants/images.dart';
import 'package:buy_link/core/constants/strings.dart';
import 'package:buy_link/core/constants/svgs.dart';
import 'package:buy_link/features/core/notifiers/home_notifier.dart';
import 'package:buy_link/features/core/views/single_rating.dart';
import 'package:buy_link/widgets/app_button.dart';
import 'package:buy_link/widgets/app_progress_bar.dart';
import 'package:buy_link/widgets/app_rating_bar.dart';
import 'package:buy_link/widgets/app_text_field.dart';
import 'package:buy_link/widgets/category_container.dart';
import 'package:buy_link/widgets/compare_texts.dart';
import 'package:buy_link/widgets/compare_texts_2.dart';
import 'package:buy_link/widgets/custmised_text.dart';
import 'package:buy_link/widgets/iconNtext_container.dart';
import 'package:buy_link/widgets/product_container.dart';
import 'package:buy_link/widgets/product_image_container.dart';
import 'package:buy_link/widgets/product_no_of_searches.dart';
import 'package:buy_link/widgets/review_text_field.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../widgets/favorite_container.dart';

class ProductSavedView extends ConsumerWidget {
  ProductSavedView({Key? key}) : super(key: key);

  String dropdownValue = 'This Week';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                horizontalTitleGap: 0,
                dense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                leading: FavoriteContainer(
                  height: 28,
                  width: 28,
                  padding: 5,
                  favIcon: SvgPicture.asset(AppSvgs.favorite),
                  containerColor: AppColors.shade1,
                ),
                title: const Text(
                  'Product Saved',
                  style: TextStyle(
                    color: AppColors.grey4,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: const Text(
                  '9,500',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                trailing: Container(
                  height: 32,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.primaryColor,
                    ),
                    color: AppColors.light,
                  ),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                    iconSize: 16,
                    onChanged: (String? newValue) {
                      // setState(() {
                      //   dropdownValue = newValue!;
                      // });
                    },
                    underline: const SizedBox(),
                    items: <String>['This Week', 'Two', 'Free', 'Four']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const Spacing.height(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Sunday',
                    style: TextStyle(
                      color: AppColors.grey4,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'saves',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'saves',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'saves',
                  ),
                ],
              ),
              const Spacing.height(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Monday',
                    style: TextStyle(
                      color: AppColors.grey4,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'saves',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'saves',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'saves',
                  ),
                ],
              ),
              const Spacing.height(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Tuesday',
                    style: TextStyle(
                      color: AppColors.grey4,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'saves',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'saves',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'saves',
                  ),
                ],
              ),
              const Spacing.height(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Wednesday',
                    style: TextStyle(
                      color: AppColors.grey4,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'saves',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'saves',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'saves',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
