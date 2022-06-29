import 'dart:io';

import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/features/core/notifiers/add_product_notifier.dart';
import 'package:buy_link/features/core/notifiers/category_notifier.dart';
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
import '../../../core/utilities/alertify.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/spacing.dart';
import '../models/product_model.dart';
import '../notifiers/store_notifier/store_dashboard_notifier.dart';

class AddProductView extends ConsumerWidget {
  final Store store;

  AddProductView({
    Key? key,
    required this.store,
  }) : super(key: key);

  final productNameFN = FocusNode();
  final minPriceFN = FocusNode();
  final maxPriceFN = FocusNode();
  final productSpecificsFN = FocusNode();
  final productDescFN = FocusNode();

  final productNameCtrl = TextEditingController();
  final minPriceCtrl = TextEditingController();
  final maxPriceCtrl = TextEditingController();
  final productSpecificsCtrl = TextEditingController();
  final productDescCtrl = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    final addProductNotifier = ref.watch(addProductNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.dark,
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
          'Add Product',
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
                'Product Pictures(${addProductNotifier.imageList.length > 4 ? 4 : addProductNotifier.imageList.length}/4)',
                style: TextStyle(
                  color: AppColors.getColorFromHex('3A4150'),
                  fontSize: 12,
                ),
              ),
              const Spacing.tinyHeight(),
              SelectProductImageContainer(
                onDottedContainerTapped: () async {
                  print('Pick file Clicked');
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.image,
                    withData: true,
                    allowMultiple: true,
                  );

                  if (result != null) {
                    addProductNotifier.setImages(images: result.files);
                  } else {
                    // User canceled the picker
                  }
                },
              ),
              const Spacing.mediumHeight(),
              AppTextField(
                style: TextStyle(
                    color: AppColors.grey2,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                hasBorder: true,
                controller: productNameCtrl,
                title: 'Product Name',
                hintText: 'Name of the product',
                onChanged: addProductNotifier.onNameChanged,
              ),
              const Spacing.mediumHeight(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: SpecialTextField(
                      controller: minPriceCtrl,
                      height: 56,
                      title: 'Price',
                      tit: 'Min Price',
                      sub: '# ',
                      onChanged: addProductNotifier.onMinPriceChanged,
                    ),
                  ),
                  Spacing.smallWidth(),
                  Expanded(
                    child: SpecialTextField(
                      controller: maxPriceCtrl,
                      height: 56,
                      tit: 'Max Price',
                      sub: '# ',
                      onChanged: addProductNotifier.onMaxPriceChanged,
                    ),
                  ),
                ],
              ),
              const Spacing.mediumHeight(),
              AppDropdownField(
                title: 'Product Category',
                hintText: 'Select Product Category',
                items: ref
                    .read(categoryNotifierProvider)
                    .categories
                    .map(
                      (category) => DropdownMenuItem(
                        child: Text(category.name),
                        value: category.name,
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
              // const Spacing.mediumHeight(),
              // AppDropdownField(
              //   title: 'Product Sub-Category',
              //   hintText: 'Select Product Sub-Category',
              //   items: addProductNotifier.categories
              //       .map(
              //         (category) => DropdownMenuItem(
              //           child: Text(category),
              //           value: category,
              //         ),
              //       )
              //       .toList(),
              //   onChanged: addProductNotifier.categories.isEmpty
              //       ? null
              //       : (newCategory) {
              //           // _subCatKey.currentState?.reset();
              //           addProductNotifier.onCategoryChanged(
              //               newCategory: newCategory.toString());
              //         },
              // ),
              const Spacing.mediumHeight(),
              AppTextField(
                style: TextStyle(
                    color: AppColors.grey2,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                hasBorder: true,
                title: 'Product Specifics',
                hintText: 'Brand, Size, Color, Material, Mobile',
                enabled: true,
                controller: productSpecificsCtrl,
                focusNode: productSpecificsFN,
                fillColor: AppColors.grey8,
                onTap: () {
                  productSpecificsFN.unfocus();
                  ref
                      .read(navigationServiceProvider)
                      .navigateToNamed(Routes.addProductSpecifics);
                },
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                  ),
                  onPressed: () {},
                ),
              ),
              const Spacing.mediumHeight(),
              AppTextField(
                controller: productDescCtrl,
                style: TextStyle(
                    color: AppColors.grey2,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                hasBorder: true,
                title: 'Product Description',
                hintText: 'Describe your product',
                maxLines: 10,
                onChanged: addProductNotifier.onDescChanged,
              ),
              const Spacing.height(40),
              AppButton(
                isLoading: addProductNotifier.state.isLoading,
                text: 'Save Product',
                fontSize: 16,
                backgroundColor: productDescCtrl.text.isEmpty &&
                        productNameCtrl.text.isEmpty &&
                        productSpecificsCtrl.text.isEmpty &&
                        maxPriceCtrl.text.isEmpty &&
                        minPriceCtrl.text.isEmpty
                    ? AppColors.grey6
                    : AppColors.primaryColor,
                onPressed: () async {
                  await addProductNotifier.addProduct(storeId: store.id);
                  await ref
                      .read(storeDashboardNotifierProvider)
                      .initFetch(storeId: store.id);
                  Alertify(title: 'Your product has been added').success();
                  ref.read(navigationServiceProvider).navigateBack();
                },
              ),
              const Spacing.height(54),
            ],
          ),
        ),
      ),
    );
  }
}
