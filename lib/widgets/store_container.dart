import 'package:buy_link/features/core/views/store_views/store_dashboard_view.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/constants/colors.dart';
import '../core/constants/svgs.dart';
import '../core/routes.dart';

class StoreContainer extends ConsumerWidget {
  final String storeImage;
  final String storeName;
  final num starRate;
  final void Function()? onTap;

  const StoreContainer({
    Key? key,
    required this.storeImage,
    required this.storeName,
    required this.starRate,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child:

      Container(
        //margin: EdgeInsets.all(10),
        width: (MediaQuery.of(context).size.width - 74) / 2,
        height: 163,
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
                  SvgPicture.asset(
                    AppSvgs.starFilled,
                    width: 14,
                    height: 14,
                  ),
                  Spacing.tinyWidth(),
                  Text(
                    starRate.toStringAsFixed(1),
                    style:
                        const TextStyle(color: AppColors.light, fontSize: 16),
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
      )),
    );
  }
}
