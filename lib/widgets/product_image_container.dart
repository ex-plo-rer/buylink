import 'package:buy_link/features/core/notifiers/compare_notifier.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../core/constants/colors.dart';
import '../core/constants/images.dart';
import '../features/core/models/product_model.dart';

class ProductImageContainer extends ConsumerWidget {
  const ProductImageContainer({
    Key? key,
    required this.product,
    required this.activeIndex,
    this.onPageChanged,
  }) : super(key: key);
  final ProductModel product;
  final dynamic Function(int, CarouselPageChangedReason)? onPageChanged;
  final int activeIndex;

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      height: 160,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          CarouselSlider.builder(
            itemCount: product.image.length,
            options: CarouselOptions(
              height: 447,
              autoPlay: true,
              disableCenter: true,
              viewportFraction: 1,
              aspectRatio: 0,
              // onPageChanged: compareNotifier.nextPage,
              onPageChanged: onPageChanged,
            ),
            itemBuilder: (context, index, realIndex) {
              final urlImage = product.image[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(urlImage),
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: AnimatedSmoothIndicator(
                count: product.image.length,
                // activeIndex: compareNotifier.activeIndex,
                activeIndex: activeIndex,
                effect: const ExpandingDotsEffect(
                  spacing: 3,
                  expansionFactor: 4,
                  activeDotColor: AppColors.light,
                  dotColor: AppColors.light,
                  dotHeight: 4,
                  dotWidth: 4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}