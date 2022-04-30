import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';

import '../core/constants/colors.dart';
import '../core/constants/images.dart';

class ProductCount extends StatelessWidget {
  const ProductCount({
    Key? key,
    required this.productImage,
    required this.productName,
    required this.productNum, required this.type,
  }) : super(key: key);
  final String productImage;
  final String productName;
  final int productNum;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              productImage,
              height: 40,
              width: 40,
            ),
            const Spacing.smallWidth(),
            Text(
              productName,
              style: const TextStyle(
                color: AppColors.grey4,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
        Text(
          '$productNum ${type.toLowerCase() == 'searches' ? 'Searches' : type.toLowerCase() == 'visits' ? 'Visits': 'Saves'}',
          style: const TextStyle(
            color: AppColors.grey4,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
