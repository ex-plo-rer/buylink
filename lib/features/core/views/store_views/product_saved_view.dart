import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/constants/images.dart';
import 'package:buy_link/core/constants/svgs.dart';
import 'package:buy_link/widgets/product_no_of_searches.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
                    productNum: '300',
                    type: 'saves',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: '300',
                    type: 'saves',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: '300',
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
                    productNum: '300',
                    type: 'saves',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: '300',
                    type: 'saves',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: '300',
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
                    productNum: '300',
                    type: 'saves',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: '300',
                    type: 'saves',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: '300',
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
                    productNum: '300',
                    type: 'saves',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: '300',
                    type: 'saves',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: '300',
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
