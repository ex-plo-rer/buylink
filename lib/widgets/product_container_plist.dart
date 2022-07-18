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

class ProductContainerPList extends ConsumerWidget {
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

  const ProductContainerPList({
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
                    // 'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg'
                  ),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [],
                ),
              ),
            ),
          ),
          const Spacing.tinyHeight(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.grey2,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),

              RichText(
                // overflow: TextOverflow.clip(isDetails ? null : TextOverflow.ellipsis,),
                text: TextSpan(
                  children: [
                    // WidgetSpan(
                    //   style: TextStyle(
                    //     color: AppColors.grey1,
                    //     fontSize: 14,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    //   child: SvgPicture.asset(
                    //     AppSvgs.naira,
                    //     height: 15,
                    //     width: 15,
                    //   ),
                    // ),
                    TextSpan(
                      text: '₦$productPrice',
                      style: TextStyle(
                        color: AppColors.grey1,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              // Text(
              //   '#$productPrice',
              //   overflow: isDetails ? null : TextOverflow.ellipsis,
              //   style: const TextStyle(
              //     color: AppColors.grey1,
              //     fontSize: 14,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
