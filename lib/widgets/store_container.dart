import 'package:buy_link/features/core/views/store_views/store_dashboard_view.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/constants/colors.dart';

class StoreContainer extends ConsumerWidget {
  final String storeImage;
  final String storeName;
  final int starRate;

  const StoreContainer({
    Key? key,
    required this.storeImage,
    required this.storeName,
    required this.starRate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      //margin: EdgeInsets.all(10),
      height: 160,
      // width: 164,
      decoration: BoxDecoration(
        color: AppColors.grey,
        image: DecorationImage(
          image: CachedNetworkImageProvider(storeImage),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.star_rate_rounded,
                  color: AppColors.yellow,
                ),
                Text(
                  starRate.toString(),
                  style: const TextStyle(color: AppColors.light, fontSize: 16),
                )
              ],
            ),
          ),
          Center(
            child: Text(
              storeName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.light,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacing.largeHeight(),
        ],
      ),
    );
  }
}
