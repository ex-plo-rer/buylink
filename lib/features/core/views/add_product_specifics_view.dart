import 'dart:io';

import 'package:buy_link/features/core/notifiers/add_product_notifier.dart';
import 'package:buy_link/features/core/views/add_product_desc.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/app_dropdown_field.dart';
import 'package:buy_link/widgets/app_text_field.dart';
import 'package:buy_link/widgets/select_product_image_container.dart';
import 'package:buy_link/widgets/special_text_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/colors.dart';
import '../../../core/routes.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/spacing.dart';

class AddProductSpecificsView extends ConsumerWidget {
  const AddProductSpecificsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final addProductNotifier = ref.watch(addProductNotifierProvider);
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
          'Product Specifics',
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
          padding: const EdgeInsets.symmetric(
            // vertical: 16,
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'This helps your costumers locate your products faster, all the fields are optional, so fill the field that applies to your product',
                style: TextStyle(
                    color: AppColors.getColorFromHex('3A4150'),
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
              ),
              const Spacing.height(20),
              const AppTextField(
                hasBorder: true,
                title: 'Brand',
                hintText: 'Brand of the product',
              ),
              const AppTextField(
                hasBorder: true,
                title: 'Colors',
                hintText: 'Colors of the product',
              ),
              const Spacing.mediumHeight(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Expanded(
                    child: SpecialTextField(
                      title: 'Age',
                      tit: 'Min',
                      sub: 'Years ',
                      hintText: '0',
                    ),
                  ),
                  Spacing.smallWidth(),
                  Expanded(
                      child: SpecialTextField(
                    tit: 'Max',
                    sub: 'Years ',
                    hintText: '0',
                  )),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Expanded(
                      child: SpecialTextField(
                          title: 'Weight', tit: 'Min', sub: 'Kg ')),
                  Spacing.smallWidth(),
                  Expanded(child: SpecialTextField(tit: 'Max', sub: 'Kg ')),
                ],
              ),
              const Spacing.mediumHeight(),
              AppDropdownField(
                title: 'Size of the product',
                hintText: 'Select Size',
                items: addProductNotifier.categories
                    .map(
                      (category) => DropdownMenuItem(
                        child: Text(category),
                        value: category,
                      ),
                    )
                    .toList(),
                onChanged: addProductNotifier.categories.isEmpty
                    ? null
                    : (newCategory) {
                        // _subCatKey.currentState?.reset();
                        addProductNotifier.onCategoryChanged(
                            newCategory: newCategory.toString());
                      },
              ),
              const Spacing.mediumHeight(),
              const AppTextField(
                hasBorder: true,
                title: 'Model',
                hintText: 'Model',
              ),
              const Spacing.mediumHeight(),
              const AppTextField(
                hasBorder: true,
                title: 'Material',
                hintText: 'Material of the product',
                maxLines: 7,
              ),
              const Spacing.mediumHeight(),
              const AppTextField(
                hasBorder: true,
                title: 'Care',
                hintText: 'How to take care of the product',
                maxLines: 7,
              ),
              const Spacing.mediumHeight(),
              const Spacing.height(40),
              AppButton(
                text: 'Continue',
                fontSize: 16,
                backgroundColor: AppColors.primaryColor,
                // onPressed: () => ref
                //     .read(navigationServiceProvider)
                //     .navigateToNamed(Routes.homeView),
                onPressed: () {},
              ),
              const Spacing.height(54),
            ],
          ),
        ),
      ),
    );
  }
}
