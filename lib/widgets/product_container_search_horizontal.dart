import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/constants/images.dart';
import 'package:buy_link/core/constants/svgs.dart';
import 'package:buy_link/widgets/distance_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductContainerSearchHorizontal extends ConsumerWidget {
  final String url;
  final String storeName;
  final String productName;
  final int productPrice;
  final String distance;
  final void Function()? onProductTapped;
  final void Function()? onDistanceTapped;
  final void Function()? onFlipTapped;
  final void Function()? onFavoriteTapped;
  final bool isBig;
  final bool isFavorite;
  final bool isDetails;

  const ProductContainerSearchHorizontal({
    Key? key,
    required this.url,
    required this.storeName,
    required this.productName,
    required this.productPrice,
    required this.distance,
    required this.isFavorite,
    this.onProductTapped,
    this.onDistanceTapped,
    this.onFlipTapped,
    this.onFavoriteTapped,
    this.isBig = false,
    this.isDetails = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      height: 112,
      width: 300,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: AppColors.grey,
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                width: 116,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(12)),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(url))),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.horizontal(right: Radius.circular(12)),
                    color: AppColors.light,
                  ),
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        storeName,
                        overflow: isDetails ? null : TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.grey3,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        productName,
                        overflow: isDetails ? null : TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.grey1,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '#$productPrice',
                        overflow: isDetails ? null : TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.grey1,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 8,
            left: 8,
            child: DistanceContainer(
              distance: distance,
              onDistanceTapped: onDistanceTapped,
            ),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: GestureDetector(
              onTap: onFlipTapped,
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
            bottom: 48,
            right: 8,
            child: GestureDetector(
              onTap: onFavoriteTapped,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppColors.light,
                ),
                child: SvgPicture.asset(
                  isFavorite ? AppSvgs.favoriteFilled : AppSvgs.favorite,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
