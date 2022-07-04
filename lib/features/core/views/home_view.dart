import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/constants/images.dart';
import 'package:buy_link/core/constants/svgs.dart';
import 'package:buy_link/core/routes.dart';
import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/features/core/models/compare_arg_model.dart';
import 'package:buy_link/features/core/notifiers/flip_notifier.dart';
import 'package:buy_link/features/core/notifiers/home_notifier.dart';
import 'package:buy_link/features/core/notifiers/store_notifier/product_search_notifier.dart';
import 'package:buy_link/features/core/notifiers/user_provider.dart';
import 'package:buy_link/features/core/notifiers/wishlist_notifier.dart';
import 'package:buy_link/services/location_service.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/app_button.dart';
import 'package:buy_link/widgets/app_empty_states.dart';
import 'package:buy_link/widgets/app_text_field.dart';
import 'package:buy_link/widgets/category_container.dart';
import 'package:buy_link/widgets/product_container.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/utilities/loader.dart';
import '../../../widgets/circular_progress.dart';
import '../models/product_search.dart';
import '../notifiers/category_notifier.dart';

class HomeView extends ConsumerWidget {
  HomeView({Key? key}) : super(key: key);

  final searchFN = FocusNode();

  @override
  Widget build(BuildContext context, ref) {
    final homeNotifier = ref.watch(homeNotifierProvider(null));
    final wishlistNotifier = ref.watch(wishlistNotifierProvider);
    final categoryNotifier = ref.watch(categoryNotifierProvider);
    print('latttttttttttttttttttttttttt${ref.watch(locationService).lat}');
    // ref.watch(locationService).getCurrentLocation();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                hintText: 'What would you like to buy ?',
                onTap: () async {
                  searchFN.unfocus();
                  ref.read(productSearchNotifierProvider).getRecentSearches();
                  await showSearch(
                    context: context,
                    delegate: ProductSearch(
                      ref: ref,
                    ),
                  );
                },
                prefixIcon: const Icon(Icons.search_outlined),
                hasBorder: false,
                isSearch: true,
                fillColor: AppColors.grey8,
                focusNode: searchFN,
              ),
              //   ),
              // ),
              const Spacing.height(12),
              Visibility(
                visible: ref.watch(userProvider).currentUser == null,
                child: AppButton(
                  text: 'Log in to personalize your Buylink experience',
                  textColor: AppColors.primaryColor,
                  fontSize: 14,
                  backgroundColor: AppColors.shade1,
                  hasIcon: true,
                  icon: SvgPicture.asset(AppSvgs.login),
                  onPressed: () {
                    ref.read(navigationServiceProvider).navigateOffAllNamed(
                          Routes.login,
                          (p0) => false,
                        );
                  },
                ),
              ),
              const Spacing.height(12),
              if (!homeNotifier.productLoading ||
                  homeNotifier.products.isNotEmpty)
                Text(
                  homeNotifier.initialText,
                  style: const TextStyle(
                    color: AppColors.grey1,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              const Spacing.smallHeight(),
              Expanded(
                child: homeNotifier.productLoading
                    ? const CircularProgress()
                    : homeNotifier.products.isEmpty
                        ? AppEmptyStates(
                            imageString: AppImages.bag,
                            message1String:
                                'No Product... Kindly Reload or check back',
                            buttonString: 'Reload',
                            hasButton: true,
                            hasIcon: false,
                            onButtonPressed: () =>
                                homeNotifier.fetchProducts(category: 'all'))
                        : MasonryGridView.count(
                            itemCount: homeNotifier.products.length,
                            crossAxisCount: 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 15,
                            itemBuilder: (context, index) {
                              if (index == 3) {
                                return Container(
                                  height: 182,
                                  color: AppColors.transparent,
                                  child: homeNotifier.categoriesLoading
                                      ? const CircularProgress()
                                      : homeNotifier.categories.isEmpty
                                          ? const Center(
                                              child: Text('Category is empty'),
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CategoryContainer(
                                                  categoryName: homeNotifier
                                                      .categories[0].name,
                                                  categoryImage: homeNotifier
                                                      .categories[0].image,
                                                  onTap: () => homeNotifier
                                                      .fetchProducts(
                                                          category: homeNotifier
                                                              .categories[0]
                                                              .name),
                                                ),
                                                CategoryContainer(
                                                  categoryName: homeNotifier
                                                      .categories[1].name,
                                                  categoryImage: homeNotifier
                                                      .categories[1].image,
                                                  onTap: () => homeNotifier
                                                      .fetchProducts(
                                                          category: homeNotifier
                                                              .categories[1]
                                                              .name),
                                                ),
                                                CategoryContainer(
                                                  categoryName: homeNotifier
                                                      .categories[2].name,
                                                  categoryImage: homeNotifier
                                                      .categories[2].image,
                                                  onTap: () => homeNotifier
                                                      .fetchProducts(
                                                          category: homeNotifier
                                                              .categories[2]
                                                              .name),
                                                ),
                                              ],
                                            ),
                                );
                              } else {
                                return ProductContainer(
                                  product: homeNotifier.products[index],
                                  url: homeNotifier.products[index].image[0],
                                  storeName:
                                      homeNotifier.products[index].store.name,
                                  productName:
                                      homeNotifier.products[index].name,
                                  productPrice:
                                      homeNotifier.products[index].price,
                                  distance: (Geolocator.distanceBetween(
                                    ref.watch(locationService).lat ?? 0,
                                    ref.watch(locationService).lon ?? 0,
                                    homeNotifier.products[index].lat,
                                    homeNotifier.products[index].lon,
                                  )
                                      // / 1000
                                      ).toStringAsFixed(1),
                                  // distance: ref
                                  //     .watch(locationService)
                                  //     .getDistance(
                                  //       endLat:
                                  //           homeNotifier.products[index].lat,
                                  //       endLon:
                                  //           homeNotifier.products[index].lon,
                                  //     ),
                                  isFavorite: homeNotifier.fav[index]!,
                                  onProductTapped: () {
                                    ref
                                        .read(navigationServiceProvider)
                                        .navigateToNamed(
                                          Routes.productDetails,
                                          arguments:
                                              homeNotifier.products[index],
                                        );
                                  },
                                  onDistanceTapped: () {},
                                  onFlipTapped: () async {
                                    Loader(context).showLoader(text: '');
                                    await ref
                                        .read(flipNotifierProvider)
                                        .addItemToCompare(
                                            productId: homeNotifier
                                                .products[index].id);
                                    if (ref
                                        .read(flipNotifierProvider)
                                        .successfullyAdded) {
                                      Loader(context).hideLoader();
                                      ref
                                          .read(navigationServiceProvider)
                                          .navigateToNamed(Routes.compare);
                                      return;
                                    }
                                    Loader(context).hideLoader();
                                  },
                                  onFavoriteTapped: () =>
                                      homeNotifier.toggleFav(
                                          index: index,
                                          id: homeNotifier.products[index].id),
                                  // {
                                  //   homeNotifier.products[index].isFav!
                                  //       ? await wishlistNotifier
                                  //           .removeFromWishlist(
                                  //           productId:
                                  //               homeNotifier.products[index].id,
                                  //         )
                                  //       : await wishlistNotifier.addToWishlist(
                                  //           productId:
                                  //               homeNotifier.products[index].id,
                                  //         );
                                  //   ref.refresh(homeNotifierProvider(null));
                                  // },
                                );
                              }
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
