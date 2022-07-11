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
import '../models/product_edit_model.dart';

class EditProductSpecificsView extends ConsumerStatefulWidget {
  const EditProductSpecificsView({
    Key? key,
    required this.product,
  }) : super(key: key);
  final ProductEditModel product;

  @override
  ConsumerState<EditProductSpecificsView> createState() =>
      _EditProductSpecificsViewState();
}

class _EditProductSpecificsViewState
    extends ConsumerState<EditProductSpecificsView> {
  // final productNameFN = FocusNode();
  // final minPriceFN = FocusNode();
  // final maxPriceFN = FocusNode();
  // final productSpecificsFN = FocusNode();
  // final productDescFN = FocusNode();

  late final TextEditingController productBrandCtrl;
  late final TextEditingController productColorsCtrl;
  late final TextEditingController minAgeCtrl;
  late final TextEditingController maxAgeCtrl;
  late final TextEditingController minWeightCtrl;
  late final TextEditingController maxWeightCtrl;
  late final TextEditingController productModelCtrl;
  late final TextEditingController productMaterialCtrl;
  late final TextEditingController productCareCtrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ref.read(editProductNotifierProvider).initImages(widget.product.image);
    productBrandCtrl = TextEditingController(
        text: widget.product.brand == 'null' ? '' : widget.product.brand);
    productColorsCtrl = TextEditingController(
        text: widget.product.colors == 'null' ? '' : widget.product.colors);
    minAgeCtrl = TextEditingController(
        text: widget.product.ageMin.toString() == 'null'
            ? ''
            : widget.product.ageMin.toString());
    maxAgeCtrl = TextEditingController(
        text: widget.product.ageMax.toString() == 'null'
            ? ''
            : widget.product.ageMax.toString());
    minWeightCtrl = TextEditingController(
        text: widget.product.weightMin.toString() == 'null'
            ? ''
            : widget.product.weightMin.toString());
    maxWeightCtrl = TextEditingController(
        text: widget.product.weightMax.toString() == 'null'
            ? ''
            : widget.product.weightMax.toString());
    productModelCtrl = TextEditingController(
        text: widget.product.model == 'null' ? '' : widget.product.model);
    productMaterialCtrl = TextEditingController(
        text: widget.product.material == 'null' ? '' : widget.product.material);
    productCareCtrl = TextEditingController(
        text: widget.product.care == 'null' ? '' : widget.product.care);
  }

  @override
  Widget build(BuildContext context) {
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
          'Edit Product Specifics',
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
                style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                hasBorder: true,
                controller: productBrandCtrl,
                title: 'Brand',
                hintText: 'Brand of the product',
                onChanged: addProductNotifier.onBrandChanged,
              ),
              AppTextField(
                style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                hasBorder: true,
                controller: productColorsCtrl,
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
                      controller: minAgeCtrl,
                      onChanged: addProductNotifier.onMinAgeChanged,
                    ),
                  ),
                  const Spacing.smallWidth(),
                  Expanded(
                    child: SpecialTextField(
                      height: 56,
                      tit: 'Max',
                      sub: 'Years ',
                      hintText: '0',
                      controller: maxAgeCtrl,
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
                      controller: minWeightCtrl,
                      onChanged: addProductNotifier.onMinWeightChanged,
                    ),
                  ),
                  const Spacing.smallWidth(),
                  Expanded(
                    child: SpecialTextField(
                      height: 56,
                      tit: 'Max',
                      sub: 'Kg ',
                      controller: maxWeightCtrl,
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
                onChanged: addProductNotifier.sizes.isEmpty
                    ? null
                    : (newSize) {
                        // _subCatKey.currentState?.reset();
                        addProductNotifier.onSizeChanged(
                            newSize: newSize.toString());
                      },
              ),
              const Spacing.mediumHeight(),
              AppTextField(
                style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                hasBorder: true,
                controller: productModelCtrl,
                title: 'Model',
                hintText: 'Model',
                onChanged: addProductNotifier.onModelChanged,
              ),
              const Spacing.mediumHeight(),
              AppTextField(
                style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                hasBorder: true,
                // initialValue: productMaterialCtrl.text ?? '',
                controller: productMaterialCtrl,
                title: 'Material',
                hintText: 'Material of the product',
                maxLines: 7,
                onChanged: addProductNotifier.onMaterialChanged,
              ),
              const Spacing.mediumHeight(),
              AppTextField(
                style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                hasBorder: true,
                controller: productCareCtrl,
                // initialValue: productCareCtrl.text ?? '',
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
