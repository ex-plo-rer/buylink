import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/constants/images.dart';
import 'package:buy_link/core/constants/svgs.dart';
import 'package:buy_link/core/routes.dart';
import 'package:buy_link/features/core/notifiers/home_notifier.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/distance_container.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductContainer extends ConsumerWidget {
  final String url;
  final String storeName;
  final String productName;
  final String productPrice;
  final String distance;
  final void Function()? onProductTapped;
  final void Function()? onDistanceTapped;
  final void Function()? onFlipTapped;
  final void Function()? onFavoriteTapped;
  final bool isBig;

  const ProductContainer({
    Key? key,
    required this.url,
    required this.storeName,
    required this.productName,
    required this.productPrice,
    required this.distance,
    this.onProductTapped,
    this.onDistanceTapped,
    this.onFlipTapped,
    this.onFavoriteTapped,
    this.isBig = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return SizedBox(
      height: 242,
      width: isBig ? 500 : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onProductTapped,
            child: Container(
              height: 176,
              // width: 156,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    url,
                    maxHeight: 176,
                    maxWidth: 156,
                    // 'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg'
                  ),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: DistanceContainer(
                        distance: distance,
                        onDistanceTapped: onDistanceTapped,
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          ref
                              .read(navigationServiceProvider)
                              .navigateToNamed(Routes.compare);
                        },
                        // onTap: onFlipTapped,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: AppColors.light,
                          ),
                          child: Image.asset(
                            AppImages.flip,
                            height: 16,
                            width: 16,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: onFavoriteTapped,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: AppColors.light,
                          ),
                          child: SvgPicture.asset(
                            ref.watch(homeNotifierProvider).isFavorite
                                ? AppSvgs.favoriteFilled
                                : AppSvgs.favorite,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacing.tinyHeight(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                storeName,
                style: const TextStyle(
                  color: AppColors.grey3,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                productName,
                style: const TextStyle(
                  color: AppColors.grey1,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '#$productPrice',
                style: const TextStyle(
                  color: AppColors.grey1,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
