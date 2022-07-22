import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/constants/svgs.dart';
import 'package:buy_link/core/routes.dart';
import 'package:buy_link/core/utilities/extensions/strings.dart';
import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/features/core/models/compare_arg_model.dart';
import 'package:buy_link/features/core/models/product_model.dart';
import 'package:buy_link/features/core/notifiers/home_notifier.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/app_button.dart';
import 'package:buy_link/widgets/back_arrow.dart';
import 'package:buy_link/widgets/circular_progress.dart';
import 'package:buy_link/widgets/distance_container.dart';
import 'package:buy_link/widgets/favorite_container.dart';
import 'package:buy_link/widgets/iconNtext_container.dart';
import 'package:buy_link/widgets/product_container.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/utilities/loader.dart';
import '../../../services/location_service.dart';
import '../../../widgets/auth_dialog.dart';
import '../notifiers/category_notifier.dart';
import '../notifiers/flip_notifier.dart';
import '../notifiers/product_details_notifier.dart';
import '../notifiers/user_provider.dart';
import '../notifiers/wishlist_notifier.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class ProductDetailsView extends ConsumerStatefulWidget {
  const ProductDetailsView({
    Key? key,
    required this.product,
  }) : super(key: key);
  final ProductModel product;

  @override
  ConsumerState<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends ConsumerState<ProductDetailsView> {
  ScrollController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print(widget.product.name);
      ref
          .watch(productDetailsNotifierProvider)
          .setFavorite(widget.product.isFav!);
      ref
          .watch(productDetailsNotifierProvider)
          .fetchSimilarProducts(productId: widget.product.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final productDetailsNotifier = ref.watch(productDetailsNotifierProvider);
    // final homeNotifier = ref.watch(homeNotifierProvider(''));
    final wishlistNotifier = ref.watch(wishlistNotifierProvider);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: controller,
              child: Column(
                children: [
                  Container(
                    height: 427,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(20),
                      ),
                      color: AppColors.grey1,
                    ),
                    child: CarouselSlider.builder(
                      itemCount: widget.product.image.length,
                      options: CarouselOptions(
                        height: 447,
                        autoPlay: true,
                        disableCenter: true,
                        viewportFraction: 1,
                        aspectRatio: 0,
                        onPageChanged: productDetailsNotifier.nextPage,
                      ),
                      itemBuilder: (context, index, realIndex) {
                        final urlImage = widget.product.image[index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(20),
                            ),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(urlImage),
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Spacing.smallHeight(),
                  AnimatedSmoothIndicator(
                    count: widget.product.image.length,
                    activeIndex: productDetailsNotifier.activeIndex,
                    effect: const ExpandingDotsEffect(
                      spacing: 3,
                      expansionFactor: 5,
                      activeDotColor: AppColors.primaryColor,
                      dotColor: AppColors.primaryColor,
                      dotHeight: 4,
                      dotWidth: 4,
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      // if (ref
                      //     .read(categoryNotifierProvider)
                      //     .storeCategories
                      //     .isEmpty) {
                      // Loader(context).showLoader(text: '');
                      // await ref
                      //     .read(categoryNotifierProvider)
                      //     .fetchStoreCategories(
                      //         storeId: widget.product.store.id.toString());
                      // Loader(context).hideLoader();
                      ref.read(navigationServiceProvider).navigateToNamed(
                            Routes.storeDetails,
                            arguments: widget.product.store,
                          );
                      // } else {
                      //   ref.read(navigationServiceProvider).navigateToNamed(
                      //         Routes.storeDetails,
                      //         arguments: widget.product.store.id,
                      //       );
                      // }
                    },
                    leading: CircleAvatar(
                      backgroundColor: AppColors.grey1,
                      backgroundImage:
                          CachedNetworkImageProvider(widget.product.store.logo),
                    ),
                    title: Text(
                      widget.product.store.name.characters
                          .replaceAll(Characters(''), Characters('\u{200B}'))
                          .toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.grey2,
                      ),
                    ),
                    subtitle: IconNTextContainer(
                      // text: '4.6',
                      text: ''.extractDouble(widget.product.store.star),
                      padding: 0,
                      icon: SvgPicture.asset(
                        AppSvgs.star,
                        width: 11,
                        height: 11,
                        color: AppColors.yellow,
                      ),
                      containerColor: AppColors.transparent,
                    ),
                    trailing: DistanceContainer(
                      distance: ref.watch(locationService).getDist(
                            endLat: widget.product.store.lat,
                            endLon: widget.product.store.lon,
                          ),
                      // distance: widget.product.store.distance,
                      containerColor: AppColors.grey2,
                      textColor: AppColors.light,
                      iconColor: AppColors.light,
                      onDistanceTapped: () {
                        ref.read(navigationServiceProvider).navigateToNamed(
                            Routes.storeDirection,
                            arguments: widget.product.store);
                      },
                    ),
                  ),
                  const Spacing.tinyHeight(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      widget.product.name.characters
                          .replaceAll(Characters(''), Characters('\u{200B}'))
                          .toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey1,
                      ),
                    ),
                  ),
                  const Spacing.tinyHeight(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RichText(
                        // overflow: TextOverflow.clip(isDetails ? null : TextOverflow.ellipsis,),
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '₦${widget.product.price}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.grey1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacing.tinyWidth(),
                      Visibility(
                          visible: widget.product.oldPrice > 0,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                // WidgetSpan(
                                //   // alignment: Alignment.topLeft,
                                //   style: const TextStyle(
                                //       color: AppColors.grey9,
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
                                  text: '₦${widget.product.oldPrice}',
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
                    ],
                  ),
                  const Spacing.height(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      widget.product.desc,
                      // textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey2,
                      ),
                    ),
                  ),
                  const Spacing.bigHeight(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      // mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 5,
                          child: AppButton(
                            text: 'Locate Store',
                            hasIcon: true,
                            backgroundColor: AppColors.primaryColor,
                            textColor: AppColors.light,
                            icon: SvgPicture.asset(AppSvgs.locate),
                            onPressed: () => ref
                                .read(navigationServiceProvider)
                                .navigateToNamed(
                                  Routes.storeDirection,
                                  arguments: widget.product.store,
                                ),
                          ),
                        ),
                        const Spacing.smallWidth(),
                        Expanded(
                          child: FavoriteContainer(
                            height: 56,
                            width: 56,
                            favIcon: SvgPicture.asset(
                              productDetailsNotifier.isFavorite
                                  // widget.product.isFav!
                                  ? AppSvgs.favoriteFilled
                                  : AppSvgs.favorite,
                            ),
                            containerColor: AppColors.grey10,
                            radius: 10,
                            padding: 18,
                            onFavoriteTapped: () async {
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
                              await productDetailsNotifier.onFavTapped(
                                  productId: widget.product.id);
                              // TODO: Should pass category here...
                              ref
                                  .refresh(homeNotifierProvider(null))
                                  .fetchProducts(category: 'all');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacing.bigHeight(),
                  const Divider(thickness: 1),
                  GestureDetector(
                    onTap: () {
                      productDetailsNotifier.fetchProductAttr(
                          productId: widget.product.id);
                      ref
                          .read(navigationServiceProvider)
                          .navigateToNamed(Routes.productDetailsMore);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 9,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Product Details',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.grey1,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(thickness: 1),
                  const Spacing.bigHeight(),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Similar Products',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.grey1,
                        ),
                      ),
                    ),
                  ),
                  const Spacing.height(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: productDetailsNotifier.state.isLoading
                        ? const CircularProgress()
                        : productDetailsNotifier.similarProducts.isEmpty
                            ? const Center(child: Text('No similar product'))
                            : MasonryGridView.count(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                controller: controller,
                                itemCount: productDetailsNotifier
                                    .similarProducts.length,
                                crossAxisCount: 2,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 15,
                                itemBuilder: (context, index) {
                                  return ProductContainer(
                                    product: productDetailsNotifier
                                        .similarProducts[index],
                                    isFavorite: productDetailsNotifier
                                        .similarProducts[index].isFav!,
                                    isDetails: true,
                                    onProductTapped: () {
                                      ref
                                          .read(navigationServiceProvider)
                                          .navigateToNamed(
                                            Routes.productDetails,
                                            arguments: productDetailsNotifier
                                                .similarProducts[index],
                                          );
                                    },
                                    onDistanceTapped: () {},
                                    onFlipTapped: () async {
                                      Loader(context).showLoader(text: '');
                                      await ref
                                          .read(flipNotifierProvider)
                                          .addItemToCompare(
                                              productId: productDetailsNotifier
                                                  .similarProducts[index].id);
                                      if (ref
                                          .read(flipNotifierProvider)
                                          .successfullyAdded) {
                                        Loader(context).hideLoader();
                                        ref
                                            .read(navigationServiceProvider)
                                            .navigateToNamed(Routes.compare);
                                        return;
                                      }
                                      // Loader(context).hideLoader();
                                    },
                                    onFavoriteTapped: () async {
                                      productDetailsNotifier
                                              .similarProducts[index].isFav!
                                          ? await wishlistNotifier
                                              .removeFromWishlist(
                                              productId: productDetailsNotifier
                                                  .similarProducts[index].id,
                                            )
                                          : await wishlistNotifier
                                              .addToWishlist(
                                              productId: productDetailsNotifier
                                                  .similarProducts[index].id,
                                            );
                                      ref.refresh(homeNotifierProvider(''));
                                    },
                                  );
                                },
                              ),
                  ),
                ],
              ),
            ),
            const BackArrow(),
          ],
        ),
      ),
    );
  }
}
