import 'package:buy_link/widgets/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../core/constants/colors.dart';
import '../core/constants/images.dart';
import '../core/constants/svgs.dart';
import '../features/core/notifiers/store_notifier/product_search_result_notifier.dart';
import '../services/location_service.dart';
import 'distance_container.dart';

class SearchResultContainer extends ConsumerWidget {
  final String url;
  final String storeName;
  final String productName;
  final int productPrice;
  final int oldPrice;
  final String distance;
  final int index;
  final void Function()? onProductTapped;
  final void Function()? onDistanceTapped;
  final void Function()? onFlipTapped;
  final void Function()? onFavoriteTapped;
  final void Function()? onPageChanged;
  final bool isBig;
  final bool isFavorite;
  final bool isDetails;
  final int imageCount;

  const SearchResultContainer({
    Key? key,
    required this.url,
    required this.storeName,
    required this.productName,
    required this.productPrice,
    required this.oldPrice,
    required this.distance,
    required this.index,
    required this.isFavorite,
    required this.imageCount,
    this.onProductTapped,
    this.onDistanceTapped,
    this.onFlipTapped,
    this.onFavoriteTapped,
    this.onPageChanged,
    this.isBig = false,
    this.isDetails = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final productSearchResultNotifier =
        ref.watch(productSearchResultNotifierProvider);
    return SizedBox(
      height: 242,
      width: isBig ? 500 : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onProductTapped,
            child: Container(
              // margin: EdgeInsets.all(10),
              height: 176,
              // width: 156,
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: CachedNetworkImageProvider(
              //       url,
              //       // 'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg'
              //     ),
              //     fit: BoxFit.fill,
              //   ),
              //   borderRadius: BorderRadius.circular(20),
              // ),

              child: Stack(
                children: [
                  CarouselSlider.builder(
                    itemCount: imageCount,
                    options: CarouselOptions(
                        height: 447,
                        autoPlay: true,
                        disableCenter: true,
                        viewportFraction: 1,
                        aspectRatio: 0,
                        onPageChanged: productSearchResultNotifier.nextPage
                        // onPageChanged: compareNotifier.nextPage,
                        // onPageChanged: onPageChanged,
                        ),
                    itemBuilder: (context, index, realIndex) {
                      //final urlImage = url;
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(url),
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    },
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
                    right: 50,
                    child: GestureDetector(
                      // onTap: () {
                      //   ref
                      //       .read(navigationServiceProvider)
                      //       .navigateToNamed(Routes.compare);
                      // },
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
                      bottom: 8,
                      right: 0,
                      left: 0,
                      child: Center(
                        child: AnimatedSmoothIndicator(
                          count: imageCount,
                          activeIndex: index,
                          effect: const ExpandingDotsEffect(
                              activeDotColor: AppColors.light,
                              dotColor: AppColors.light,
                              dotHeight: 4,
                              dotWidth: 4,
                              expansionFactor: 4),
                        ),
                      )),
                  Positioned(
                    bottom: 8,
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
          const Spacing.tinyHeight(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  color: AppColors.grey2,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(children: <Widget>[
                Visibility(
                    visible: oldPrice > 0,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          // WidgetSpan(
                          //   // alignment: Alignment.topLeft,
                          //   style: const TextStyle(
                          //       color: AppColors.grey4,
                          //       fontSize: 12,
                          //       fontWeight: FontWeight.w500,
                          //       decoration: TextDecoration.lineThrough),
                          //   child: SvgPicture.asset(
                          //     AppSvgs.naira,
                          //     height: 13.5,
                          //     width: 13.5,
                          //     color: AppColors.grey4,
                          //   ),
                          // ),
                          TextSpan(
                            text: '₦$oldPrice',
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
                Spacing.tinyWidth(),
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
                        //overflow: isDetails ? null : TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.grey1,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
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
        ],
      ),
    );
  }
}
