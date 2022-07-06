import 'package:buy_link/features/core/notifiers/add_product_notifier.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/app_dropdown_field.dart';
import 'package:buy_link/widgets/app_text_field.dart';
import 'package:buy_link/widgets/special_text_field.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/colors.dart';
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
          onPressed: () {
            ref.read(navigationServiceProvider).navigateBack();
          },
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
              AppTextField(
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                hasBorder: true,
                title: 'Brand',
                hintText: 'Brand of the product',
                onChanged: addProductNotifier.onBrandChanged,
              ),
              AppTextField(
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                hasBorder: true,
                title: 'Colors',
                hintText: 'Colors of the product',
                onChanged: addProductNotifier.onColorChanged,
              ),
              const Spacing.mediumHeight(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: SpecialTextField(
                      height: 56,
                      title: 'Age',
                      tit: 'Min',
                      sub: 'Years ',
                      hintText: '0',
                      onChanged: addProductNotifier.onMinAgeChanged,
                    ),
                  ),
                  Spacing.smallWidth(),
                  Expanded(
                    child: SpecialTextField(
                      height: 56,
                      tit: 'Max',
                      sub: 'Years ',
                      hintText: '0',
                      onChanged: addProductNotifier.onMaxAgeChanged,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: SpecialTextField(
                      height: 56,
                      title: 'Weight',
                      tit: 'Min',
                      sub: 'Kg ',
                      onChanged: addProductNotifier.onMinWeightChanged,
                    ),
                  ),
                  Spacing.smallWidth(),
                  Expanded(
                    child: SpecialTextField(
                      height: 56,
                      tit: 'Max',
                      sub: 'Kg ',
                      onChanged: addProductNotifier.onMaxWeightChanged,
                    ),
                  ),
                ],
              ),
              const Spacing.mediumHeight(),
              AppDropdownField(
                title: 'Size of the product',
                hintText: 'Select Size',
                items: addProductNotifier.sizes
                    .map(
                      (size) => DropdownMenuItem(
                        child: Text(size),
                        value: size,
                      ),
                    )
                    .toList(),
                onChanged: addProductNotifier.categories.isEmpty
                    ? null
                    : (newSize) {
                        // _subCatKey.currentState?.reset();
                        addProductNotifier.onSizeChanged(
                            newSize: newSize.toString());
                      },
              ),
              const Spacing.mediumHeight(),
              AppTextField(
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                hasBorder: true,
                title: 'Model',
                hintText: 'Model',
                onChanged: addProductNotifier.onModelChanged,
              ),
              const Spacing.mediumHeight(),
              AppTextField(
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                hasBorder: true,
                title: 'Material',
                hintText: 'Material of the product',
                maxLines: 7,
                onChanged: addProductNotifier.onMaterialChanged,
              ),
              const Spacing.mediumHeight(),
              AppTextField(
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                hasBorder: true,
                title: 'Care',
                hintText: 'How to take care of the product',
                maxLines: 7,
                onChanged: addProductNotifier.onCareChanged,
              ),
              const Spacing.mediumHeight(),
              const Spacing.height(40),
              AppButton(
                // isLoading: addProductNotifier.state.isLoading,
                text: 'Continue',
                fontSize: 16,
                backgroundColor: AppColors.primaryColor,
                onPressed: () =>
                    ref.read(navigationServiceProvider).navigateBack(),
              ),
              const Spacing.height(54),
            ],
          ),
        ),
      ),
    );
  }
}
