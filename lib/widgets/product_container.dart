import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/constants/images.dart';
import 'package:buy_link/core/constants/svgs.dart';
import 'package:buy_link/core/routes.dart';
import 'package:buy_link/features/core/models/product_model.dart';
import 'package:buy_link/features/core/notifiers/home_notifier.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/auth_dialog.dart';
import 'package:buy_link/widgets/distance_container.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/utilities/loader.dart';
import '../features/core/notifiers/category_notifier.dart';
import '../features/core/notifiers/user_provider.dart';
import '../services/location_service.dart';
import 'app_dialog.dart';

class ProductContainer extends ConsumerWidget {
  final ProductModel product;
  final void Function()? onProductTapped;
  final void Function()? onDistanceTapped;
  final void Function()? onFlipTapped;
  final void Function()? onFavoriteTapped;
  final bool isBig;
  final bool isFavorite;
  final bool isDetails;

  const ProductContainer({
    Key? key,
    required this.product,
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
                  image: CachedNetworkImageProvider(product.image[0]),
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
                        distance: ref.watch(locationService).getDist(
                            endLat: product.store.lat,
                            endLon: product.store.lon),
                        onDistanceTapped: () async {
                          ref.read(navigationServiceProvider).navigateToNamed(
                              Routes.storeDirection,
                              arguments: product.store);
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          if (ref.watch(userProvider).currentUser == null) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return const AuthDialog();
                              },
                            );
                            return;
                          }
                          onFlipTapped;
                        },
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
                        onTap: () {
                          if (ref.watch(userProvider).currentUser == null) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              barrierColor: AppColors.transparent,
                              builder: (BuildContext context) {
                                return const AuthDialog();
                              },
                            );
                            return;
                          }
                          onFavoriteTapped;
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: AppColors.light,
                          ),
                          child: SvgPicture.asset(
                            isFavorite
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
          //const Spacing.tinyHeight(),
          GestureDetector(
            onTap: () async {
              ref.read(navigationServiceProvider).navigateToNamed(
                  Routes.storeDetails,
                  arguments: product.store.id);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.store.name,
                  overflow: isDetails ? null : TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.grey3,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  product.name,
                  overflow: isDetails ? null : TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.grey2,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                    //  mainAxisSize: MainAxisSize.min,
                    children: [
                      RichText(
                        // overflow: TextOverflow.clip(isDetails ? null : TextOverflow.ellipsis,),
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              style: const TextStyle(
                                color: AppColors.grey1,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              child: SvgPicture.asset(
                                AppSvgs.naira,
                                height: 15,
                                width: 15,
                              ),
                            ),
                            TextSpan(
                              text: '${product.price}',
                              style: const TextStyle(
                                color: AppColors.grey1,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacing.tinyWidth(),
                      Visibility(
                          visible: product.oldPrice > 0,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  // alignment: Alignment.topLeft,
                                  style: const TextStyle(
                                      color: AppColors.grey4,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.lineThrough),
                                  child: SvgPicture.asset(
                                    AppSvgs.naira,
                                    height: 13.5,
                                    width: 13.5,
                                    color: AppColors.grey4,
                                  ),
                                ),
                                TextSpan(
                                  text: '${product.oldPrice}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.grey4,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ]),
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
          ),
        ],
      ),
    );
  }
}
