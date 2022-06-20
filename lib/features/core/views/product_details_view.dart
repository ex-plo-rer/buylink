import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/constants/svgs.dart';
import 'package:buy_link/core/routes.dart';
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

import '../../../services/location_service.dart';
import '../notifiers/product_details_notifier.dart';
import '../notifiers/wishlist_notifier.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class ProductDetailsView extends ConsumerWidget {
  ProductDetailsView({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  late String symb;

  void symbol(context) {
    Locale locale = Localizations.localeOf(context);
    var format =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
    symb = format.currencySymbol;
    print("CURRENCY SYMBOL ${symb}"); // $
    print("CURRENCY NAME ${format.currencyName}"); // USD
    // var format = NumberFormat.simpleCurrency(locale: Platform.localeName);
    symb = format.currencySymbol;
  }

  @override
  Widget build(BuildContext context, ref) {
    symbol(context);
    final productDetailsNotifier =
        ref.watch(productDetailsNotifierProvider(product.id));
    final homeNotifier = ref.watch(homeNotifierProvider(''));
    final wishlistNotifier = ref.watch(wishlistNotifierProvider);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
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
                      itemCount: product.image.length,
                      options: CarouselOptions(
                        height: 447,
                        autoPlay: true,
                        disableCenter: true,
                        viewportFraction: 1,
                        aspectRatio: 0,
                        onPageChanged: productDetailsNotifier.nextPage,
                      ),
                      itemBuilder: (context, index, realIndex) {
                        final urlImage = product.image[index];
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
                    count: product.image.length,
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
                    onTap: () =>
                        ref.read(navigationServiceProvider).navigateToNamed(
                              Routes.storeDetails,
                              arguments: product.store,
                            ),
                    leading: CircleAvatar(
                      backgroundColor: AppColors.grey1,
                      backgroundImage:
                          CachedNetworkImageProvider(product.store.logo),
                    ),
                    title: Text(
                      product.store.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.grey2,
                      ),
                    ),
                    subtitle: IconNTextContainer(
                      text: '4.6',
                      // text: product.store.rating,
                      padding: 0,
                      icon: SvgPicture.asset(
                        AppSvgs.star,
                        width: 12,
                        height: 12,
                        color: AppColors.yellow,
                      ),
                      containerColor: AppColors.transparent,
                    ),
                    trailing: DistanceContainer(
                      distance: ref.watch(locationService).getDistance(
                            endLat: product.lat,
                            endLon: product.lon,
                          ),
                      // distance: product.store.distance,
                      containerColor: AppColors.grey2,
                      textColor: AppColors.light,
                      iconColor: AppColors.light,
                    ),
                  ),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey1,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '#${product.price} ',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.grey1,
                        ),
                      ),
                      Visibility(
                        visible: product.oldPrice > 0,
                        child: Text(
                          '${product.oldPrice}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.grey4,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacing.height(20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'A super-comfortable denim legging,built to contour curves, lengthen legs and celebrate your form. Made with an innovative tummy-sliming',
                      //product.description,
                      // textAlign: TextAlign.justify,
                      style: TextStyle(
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
                                  arguments: product.store,
                                ),
                          ),
                        ),
                        const Spacing.smallWidth(),
                        Expanded(
                          child: FavoriteContainer(
                            height: 56,
                            width: 56,
                            favIcon: SvgPicture.asset(
                              product.isFav!
                                  ? AppSvgs.favoriteFilled
                                  : AppSvgs.favorite,
                            ),
                            containerColor: AppColors.grey10,
                            radius: 10,
                            padding: 18,
                            onFavoriteTapped: () async {
                              product.isFav!
                                  ? await wishlistNotifier.removeFromWishlist(
                                      productId: product.id)
                                  : await wishlistNotifier.addToWishlist(
                                      productId: product.id);
                              ref.refresh(homeNotifierProvider(''));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacing.bigHeight(),
                  const Divider(thickness: 2),
                  GestureDetector(
                    onTap: () {
                      homeNotifier.fetchProductAttr(productId: product.id);
                      ref
                          .read(navigationServiceProvider)
                          .navigateToNamed(Routes.productDetailsMore);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 5,
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
                  const Divider(thickness: 2),
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
                  SizedBox(
                    height: 400,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: productDetailsNotifier.state.isLoading
                          ? const CircularProgress()
                          : productDetailsNotifier.similarProducts.isEmpty
                              ? const Center(
                                  child: Text('No similar product'),
                                )
                              : MasonryGridView.count(
                                  itemCount: productDetailsNotifier
                                      .similarProducts.length,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 15,
                                  itemBuilder: (context, index) {
                                    return ProductContainer(
                                      url: productDetailsNotifier
                                          .similarProducts[index].image[0],
                                      storeName: productDetailsNotifier
                                          .similarProducts[index].store.name,
                                      productName: productDetailsNotifier
                                          .similarProducts[index].name,
                                      productPrice: productDetailsNotifier
                                          .similarProducts[index].price,
                                      distance: ref
                                          .watch(locationService)
                                          .getDistance(
                                            endLat: productDetailsNotifier
                                                .similarProducts[index].lat,
                                            endLon: productDetailsNotifier
                                                .similarProducts[index].lon,
                                          ),
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
                                      onFlipTapped: () {
                                        ref
                                            .read(navigationServiceProvider)
                                            .navigateToNamed(
                                              Routes.compare,
                                              arguments: CompareArgModel(
                                                product: productDetailsNotifier
                                                    .similarProducts[index],
                                              ),
                                            );
                                      },
                                      onFavoriteTapped: () async {
                                        productDetailsNotifier
                                                .similarProducts[index].isFav!
                                            ? await wishlistNotifier
                                                .removeFromWishlist(
                                                productId:
                                                    productDetailsNotifier
                                                        .similarProducts[index]
                                                        .id,
                                              )
                                            : await wishlistNotifier
                                                .addToWishlist(
                                                productId:
                                                    productDetailsNotifier
                                                        .similarProducts[index]
                                                        .id,
                                              );
                                        ref.refresh(
                                            productDetailsNotifierProvider(
                                                product.id));
                                      },
                                    );
                                  },
                                ),
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
