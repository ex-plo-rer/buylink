import 'package:buy_link/widgets/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../core/constants/colors.dart';
import '../core/constants/images.dart';

class ProductCount extends StatelessWidget {
  const ProductCount({
    Key? key,
    required this.productImage,
    required this.productName,
    required this.productNum,
    required this.type,
  }) : super(key: key);
  final String productImage;
  final String productName;
  final String productNum;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CachedNetworkImage(
          imageUrl: productImage,
          height: 40,
          width: 40,
        ),
        const Spacing.smallWidth(),
        Expanded(
          child: Text(
            productName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.grey4,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
        const Spacing.smallWidth(),
        Text(
          '${productNum.substring(0, productNum.characters.firstWhere((element) => element.contains('-')).length)} ${type.toLowerCase() == 'searches' ? 'Searches' : type.toLowerCase() == 'visits' ? 'Visits' : 'Saves'}',
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
