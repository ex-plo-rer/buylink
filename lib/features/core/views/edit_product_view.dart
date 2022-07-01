import 'dart:io';

import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/features/core/models/product_edit_model.dart';
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
import '../../../core/utilities/loader.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/edit_product_images_container.dart';
import '../../../widgets/spacing.dart';
import '../models/edit_product_arg_model.dart';
import '../models/product_model.dart';
import '../notifiers/edit_product_notifier.dart';
import '../notifiers/product_list_notifier.dart';
import '../notifiers/store_notifier/store_dashboard_notifier.dart';

class EditProductView extends ConsumerStatefulWidget {
  final EditProductArgModel args;

  EditProductView({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  ConsumerState<EditProductView> createState() => _EditProductViewState();
}

class _EditProductViewState extends ConsumerState<EditProductView> {
  final productNameFN = FocusNode();
  final minPriceFN = FocusNode();
  final maxPriceFN = FocusNode();
  final productSpecificsFN = FocusNode();
  final productDescFN = FocusNode();

  late final TextEditingController productNameCtrl;
  late final TextEditingController minPriceCtrl;
  late final TextEditingController maxPriceCtrl;
  late final TextEditingController productSpecificsCtrl;
  late final TextEditingController productDescCtrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref
        .read(editProductNotifierProvider)
        .initImages(widget.args.product.images);
    productNameCtrl = TextEditingController(
        text:
            widget.args.product.name == 'null' ? '' : widget.args.product.name);
    minPriceCtrl = TextEditingController(
        text: widget.args.product.price.toString() == 'null'
            ? ''
            : widget.args.product.price.toString());
    maxPriceCtrl = TextEditingController(
        text: widget.args.product.oldPrice.toString() == 'null'
            ? ''
            : widget.args.product.oldPrice.toString());
    productSpecificsCtrl = TextEditingController();
    productDescCtrl = TextEditingController(
        text: widget.args.product.description == 'null'
            ? ''
            : widget.args.product.description);
  }

  @override
  Widget build(BuildContext context) {
    final editProductNotifier = ref.watch(editProductNotifierProvider);
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
                'Product Pictures(${editProductNotifier.imageList.length > 4 ? 4 : editProductNotifier.imageList.length}/4)',
                style: TextStyle(
                  color: AppColors.getColorFromHex('3A4150'),
                  fontSize: 12,
                ),
              ),
              const Spacing.tinyHeight(),
              EditProductImagesContainer(
                onDottedContainerTapped: () async {
                  print('Pick file Clicked');
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.image,
                    withData: true,
                    allowMultiple: true,
                  );

                  if (result != null) {
                    editProductNotifier.setImages(images: result.files);
                  } else {
                    // User canceled the picker
                  }
                },
                // image1: widget.args.product.image.first,
                // image2: widget.args.product.image.length < 2 ? null : widget.args.product.image[1],
                // image3: widget.args.product.image.length < 3 ? null : widget.args.product.image[2],
                // image4: widget.args.product.image.length < 4 ? null : widget.args.product.image[3],
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
                onChanged: editProductNotifier.onNameChanged,
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
                      onChanged: editProductNotifier.onMinPriceChanged,
                    ),
                  ),
                  Spacing.smallWidth(),
                  Expanded(
                    child: SpecialTextField(
                      controller: maxPriceCtrl,
                      height: 56,
                      tit: 'Max Price',
                      sub: '# ',
                      onChanged: editProductNotifier.onMaxPriceChanged,
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
                onChanged: editProductNotifier.categories.isEmpty
                    ? null
                    : (newCategory) {
                        // _subCatKey.currentState?.reset();
                        editProductNotifier.onCategoryChanged(
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
                  ref.read(navigationServiceProvider).navigateToNamed(
                        Routes.editProductSpecifics,
                        arguments: widget.args.product,
                      );
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
                onChanged: editProductNotifier.onDescChanged,
              ),
              const Spacing.height(40),
              AppButton(
                // isLoading: addProductNotifier.state.isLoading,
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
                  Loader(context).showLoader(text: '');
                  await editProductNotifier.updateProduct(
                      storeId: widget.args.store.id);
                  await ref
                      .read(storeDashboardNotifierProvider)
                      .initFetch(storeId: widget.args.store.id);
                  await ref
                      .read(productListNotifierProvider)
                      .fetchStoreProducts(
                          storeId: widget.args.store.id, category: 'all');
                  Loader(context).hideLoader();
                  Alertify(title: 'Product updated successfully.').success();
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
