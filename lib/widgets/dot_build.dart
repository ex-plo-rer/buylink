import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/constants/colors.dart';
import '../features/startup/notifiers/onboarding_notifier.dart';

// Container buildDot(ref, BuildContext context){
//   var onboardnotifier = ref.watch(onboardProv);
//
//   return Container(
//     height: 10,
//     width: 1 == index ? 25 : 10,
//     margin: EdgeInsets.only(right: 5),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(20),
//       color: AppColors.grey1,
//     ),
//   );
// }

class DotsIndicator extends AnimatedWidget {
  const DotsIndicator({
    required this.controller,
    required this.itemCount,
    required this.onPageSelected,
    this.color = AppColors.shade3,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 8.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    return Container(
      height: 6,
      width: controller.page == index ? 25 : 6,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: controller.page == index ? AppColors.primaryColor: AppColors.shade3,
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}