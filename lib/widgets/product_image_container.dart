import 'package:flutter/material.dart';

import '../core/constants/colors.dart';
import '../core/constants/images.dart';

class ProductImageContainer extends StatelessWidget {
  const ProductImageContainer({
    Key? key,
    required this.productImage,
  }) : super(key: key);
  final String productImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
          image: AssetImage(AppImages.flip),
          fit: BoxFit.fill,
        ),
        color: AppColors.red,
      ),
    );
  }
}
