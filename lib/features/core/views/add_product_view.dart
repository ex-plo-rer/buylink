import 'package:buy_link/features/core/views/add_product_desc.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/app_text_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/colors.dart';
import '../../../core/routes.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/spacing.dart';

class AddProductView extends ConsumerWidget {
  const AddProductView({Key? key}) : super(key: key);

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
            size: 14,
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.transparent,
        title: const Text(
          "Product Specifics",
          style: const TextStyle(
            color: AppColors.dark,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(20),
                dashPattern: [6, 3],
                color: AppColors.grey6,
                strokeWidth: 2,
                child: SizedBox(
                  height: 144,
                  width: double.maxFinite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.image,
                        color: AppColors.grey5,
                        size: 30,
                      ),
                      Text(
                        "You can only add upto 4 pictures of the product",
                        style: TextStyle(
                          color: AppColors.grey4,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacing.mediumHeight(),
              const AppTextField(
                hasBorder: true,
                title: 'Product Name',
                hintText: 'Name of the product',
              ),
              const Spacing.mediumHeight(),
              const AppTextField(
                hasBorder: true,
                title: 'Price',
                hintText: '# 0',
              ),
              const Spacing.mediumHeight(),
              const AppTextField(
                hasBorder: true,
                title: 'Product Category',
                hintText: 'Select Product Category',
              ),
              const Spacing.mediumHeight(),
              const AppTextField(
                hasBorder: true,
                title: 'Product Sub Category',
                hintText: 'Select Product Sub Category',
              ),
              const Spacing.mediumHeight(),
              AppTextField(
                hasBorder: true,
                title: 'Product Specifics',
                hintText: 'Brand, Size, Color, Material,Mobile',
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                  ),
                  onPressed: () => ref
                      .read(navigationServiceProvider)
                      .navigateToNamed(Routes.addProductDesc),
                ),
              ),
              const Spacing.mediumHeight(),
              const AppTextField(
                hasBorder: true,
                title: 'Product Description',
                hintText: 'Describe your product',
                maxLines: 6,
              ),
              Spacing.height(40),
              AppButton(
                text: 'Save Product',
                fontSize: 16,
                backgroundColor: AppColors.primaryColor,
                // onPressed: () => ref
                //     .read(navigationServiceProvider)
                //     .navigateToNamed(Routes.homeView),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
