import 'package:buy_link/features/core/models/product_model.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductContainerSearch extends ConsumerWidget {
  final String url;
  final String storeName;
  final String productName;
  final int productPrice;
  final int oldPrice;
  final String distance;
  final void Function()? onProductTapped;
  final void Function()? onDistanceTapped;
  final void Function()? onFlipTapped;
  final void Function()? onFavoriteTapped;
  final bool isBig;
  final bool isFavorite;
  final bool isDetails;
  final List<ProductModel> product;
  final dynamic Function(int, CarouselPageChangedReason)? onPageChanged;
  final int activeIndex;

  const ProductContainerSearch({
    Key? key,
    required this.url,
    required this.storeName,
    required this.productName,
    required this.productPrice,
    required this.distance,
    required this.isFavorite,
    this.oldPrice = 0,
    this.onProductTapped,
    this.onDistanceTapped,
    this.onFlipTapped,
    this.onFavoriteTapped,
    this.isBig = false,
    this.isDetails = false,
    required this.product,
    required this.activeIndex,
    this.onPageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return SizedBox(
      height: 242,
      width: isBig ? 500 : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   height: 160,
          //   width: double.maxFinite,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Stack(
          //     children: [
          //       CarouselSlider.builder(
          //         itemCount: product[index].image.length,
          //         options: CarouselOptions(
          //           height: 447,
          //           autoPlay: true,
          //           disableCenter: true,
          //           viewportFraction: 1,
          //           aspectRatio: 0,
          //           // onPageChanged: compareNotifier.nextPage,
          //           onPageChanged: onPageChanged,
          //         ),
          //         itemBuilder: (context, index, realIndex) {
          //           final urlImage = product.image[index];
          //           return Container(
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(12),
          //               image: DecorationImage(
          //                 image: CachedNetworkImageProvider(urlImage),
          //                 fit: BoxFit.fill,
          //               ),
          //             ),
          //           );
          //         },
          //       ),
          //       Positioned(
          //         top: 8,
          //         left: 8,
          //         child: DistanceContainer(
          //           distance: distance,
          //           onDistanceTapped: onDistanceTapped,
          //         ),
          //       ),
          //       Positioned(
          //         bottom: 8,
          //         right: 48,
          //         child: GestureDetector(
          //           onTap: onFlipTapped,
          //           child: Container(
          //             padding: const EdgeInsets.all(8),
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(50),
          //               color: AppColors.light,
          //             ),
          //             child: Image.asset(
          //               AppImages.flip,
          //               height: 16,
          //               width: 16,
          //             ),
          //           ),
          //         ),
          //       ),
          //       Positioned(
          //         bottom: 8,
          //         right: 8,
          //         child: GestureDetector(
          //           onTap: onFavoriteTapped,
          //           child: Container(
          //             padding: const EdgeInsets.all(8),
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(50),
          //               color: AppColors.light,
          //             ),
          //             child: SvgPicture.asset(
          //               isFavorite ? AppSvgs.favoriteFilled : AppSvgs.favorite,
          //             ),
          //           ),
          //         ),
          //       ),
          //       Align(
          //         alignment: Alignment.bottomCenter,
          //         child: Padding(
          //           padding: const EdgeInsets.only(bottom: 8.0),
          //           child: AnimatedSmoothIndicator(
          //             count: 0,
          //             // activeIndex: compareNotifier.activeIndex,
          //             activeIndex: activeIndex,
          //             effect: const WormEffect(
          //               dotHeight: 4,
          //               dotWidth: 4,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // const Spacing.tinyHeight(),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Text(
          //       storeName,
          //       overflow: isDetails ? null : TextOverflow.ellipsis,
          //       style: const TextStyle(
          //         color: AppColors.grey3,
          //         fontSize: 14,
          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),
          //     Text(
          //       productName,
          //       overflow: isDetails ? null : TextOverflow.ellipsis,
          //       style: const TextStyle(
          //         color: AppColors.grey1,
          //         fontSize: 14,
          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),
          //     Row(
          //         //  mainAxisSize: MainAxisSize.min,
          //         children: [
          //           RichText(
          //             // overflow: TextOverflow.clip(isDetails ? null : TextOverflow.ellipsis,),
          //             text: TextSpan(
          //               children: [
          //                 WidgetSpan(
          //                   style: TextStyle(
          //                     color: AppColors.grey1,
          //                     fontSize: 14,
          //                     fontWeight: FontWeight.w600,
          //                   ),
          //                   child: SvgPicture.asset(
          //                     AppSvgs.naira,
          //                     height: 15,
          //                     width: 15,
          //                   ),
          //                 ),
          //                 TextSpan(
          //                   text: '$productPrice',
          //                   style: TextStyle(
          //                     color: AppColors.grey1,
          //                     fontSize: 14,
          //                     fontWeight: FontWeight.w600,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Spacing.tinyWidth(),
          //           Visibility(
          //               visible: productPrice > 0,
          //               child: RichText(
          //                 text: TextSpan(
          //                   children: [
          //                     WidgetSpan(
          //                       // alignment: Alignment.topLeft,
          //                       style: TextStyle(
          //                           color: AppColors.grey4,
          //                           fontSize: 12,
          //                           fontWeight: FontWeight.w500,
          //                           decoration: TextDecoration.lineThrough),
          //                       child: SvgPicture.asset(
          //                         AppSvgs.naira,
          //                         height: 13.5,
          //                         width: 13.5,
          //                         color: AppColors.grey4,
          //                       ),
          //                     ),
          //                     TextSpan(
          //                       text: '$productPrice',
          //                       style: const TextStyle(
          //                         fontSize: 12,
          //                         fontWeight: FontWeight.w500,
          //                         color: AppColors.grey4,
          //                         decoration: TextDecoration.lineThrough,
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               )),
          //         ]),
          //     Text(
          //       '#$productPrice',
          //       overflow: isDetails ? null : TextOverflow.ellipsis,
          //       style: const TextStyle(
          //         color: AppColors.grey1,
          //         fontSize: 14,
          //         fontWeight: FontWeight.w600,
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
