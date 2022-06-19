import 'package:buy_link/features/core/notifiers/store_notifier/input_search_location_notifier.dart';
import 'package:buy_link/widgets/app_button.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:buy_link/widgets/special_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/constants/colors.dart';

class AppSearchDialog extends ConsumerWidget {
  AppSearchDialog({
    Key? key,
    required this.value,
    required this.onSliderChanged,
    required this.onMinChanged,
    required this.onMaxChanged,
    required this.onClearFilter,
    required this.sliderLabel,
  }) : super(key: key);
  final double value;
  final void Function(double)? onSliderChanged;
  final void Function(String)? onMinChanged;
  final void Function(String)? onMaxChanged;
  final void Function()? onClearFilter;
  final String? sliderLabel;
  final minPriceController = TextEditingController();
  final maxPriceController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
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
                        onChanged: onSliderChanged,
                        value: ref
                            .watch(inputSearchLocationNotifierProvider)
                            .sliderValue,
                        min: 1,
                        max: 10,
                        divisions: 9,
                        label:
                            '${ref.watch(inputSearchLocationNotifierProvider).sliderValue} km',
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
                            onChanged: onMinChanged,
                            controller: minPriceController,
                          ),
                        ),
                        const Spacing.mediumWidth(),
                        Expanded(
                          child: SpecialTextField(
                            height: 62,
                            tit: 'Max Price',
                            sub: '# ',
                            onChanged: onMaxChanged,
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
                          ref
                              .read(inputSearchLocationNotifierProvider)
                              .clearFilter();
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
                      backgroundColor: AppColors.primaryColor,
                      onPressed: () {},
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
