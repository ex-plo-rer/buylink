import 'package:buy_link/features/core/notifiers/store_notifier/product_search_notifier.dart';
import 'package:buy_link/widgets/app_button.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:buy_link/widgets/special_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/constants/colors.dart';
import '../features/core/notifiers/store_notifier/compare_search_notifier.dart';

class CompareSearchDialog extends ConsumerWidget {
  CompareSearchDialog({
    Key? key,
    required this.value,
    required this.onSliderChanged,
    required this.onMinChanged,
    required this.onMaxChanged,
    required this.onApplyPressed,
  }) : super(key: key);
  final double value;
  final void Function(double)? onSliderChanged;
  final void Function(String)? onMinChanged;
  final void Function(String)? onMaxChanged;
  final void Function()? onApplyPressed;
  final minPriceController = TextEditingController();
  final maxPriceController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    final compareSearchNotifier = ref.watch(compareSearchNotifierProvider);
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            right: 0.0,
            top: 0.0,
            child: InkResponse(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.cancel, color: Colors.white, size: 26),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 40),
            padding: const EdgeInsets.all(16),
            height: 350,
            width: MediaQuery.of(context).size.width - 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Filter",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey1,
                      ),
                    ),
                    const Spacing.mediumHeight(),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Distance (km)",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.grey1),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const Spacing.smallHeight(),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 2.0,
                        overlayShape: SliderComponentShape.noOverlay,
                        valueIndicatorColor: AppColors.primaryColor,
                      ),
                      child: Slider(
                        onChanged: (newValue) =>
                            compareSearchNotifier.onSliderChanged(newValue),
                        value: compareSearchNotifier.sliderValue,
                        min: 1,
                        max: 10,
                        divisions: 9,
                        label: '${compareSearchNotifier.sliderValue} km',
                      ),
                    ),
                    const Spacing.smallHeight(),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Price Range",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey1,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: SpecialTextField(
                            height: 62,
                            tit: 'Min Price',
                            sub: '# ',
                            keyboardType: TextInputType.number,
                            onChanged: compareSearchNotifier.onMinPriceChanged,
                            controller: minPriceController,
                          ),
                        ),
                        const Spacing.mediumWidth(),
                        Expanded(
                          child: SpecialTextField(
                            height: 62,
                            tit: 'Max Price',
                            sub: '# ',
                            keyboardType: TextInputType.number,
                            onChanged: compareSearchNotifier.onMaxPriceChanged,
                            controller: maxPriceController,
                          ),
                        ),
                      ],
                    ),
                    const Spacing.smallHeight(),
                    const Spacing.smallHeight(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          minPriceController.clear();
                          maxPriceController.clear();
                          compareSearchNotifier.clearFilter();
                        },
                        child: const Text(
                          'Clear Filter',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor),
                        ),
                      ),
                    ),
                    const Spacing.largeHeight(),
                    AppButton(
                      text: 'Apply',
                      backgroundColor: compareSearchNotifier.minPrice == null ||
                              compareSearchNotifier.maxPrice == null
                          ? AppColors.grey6
                          : AppColors.primaryColor,
                      onPressed: compareSearchNotifier.minPrice == null ||
                              compareSearchNotifier.maxPrice == null
                          ? null
                          : onApplyPressed,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
