import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/constants/images.dart';
import 'package:buy_link/core/constants/svgs.dart';
import 'package:buy_link/core/routes.dart';
import 'package:buy_link/features/core/notifiers/flip_notifier.dart';
import 'package:buy_link/features/core/notifiers/home_notifier.dart';
import 'package:buy_link/features/core/notifiers/store_notifier/product_search_notifier.dart';
import 'package:buy_link/features/core/notifiers/user_provider.dart';
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

import '../../../core/utilities/loader.dart';
import '../../../widgets/circular_progress.dart';
import '../models/product_search.dart';

class HomeView extends ConsumerStatefulWidget {
  HomeView({
    Key? key,
    this.fromLoginOrSignup = false,
  }) : super(key: key);
  bool fromLoginOrSignup;

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final searchFN = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    final hNP = ref.read(homeNotifierProvider(null));
    super.initState();
    print('INNNNNNNNNNNNNITstate');
    print('INNNNNNNNNNNNNIT ${hNP.init}');
    // if (hNP.init) {
    //   hNP.initCall();
    // }
    if (widget.fromLoginOrSignup) {
      if (hNP.init) {
        print('From Init');
        hNP.startTimer();
        hNP.initCall();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeNotifier = ref.watch(homeNotifierProvider(null));
    print('latttttttttttttttttttttttttt${ref.watch(locationService).lat}');
    // ref.watch(locationService).getCurrentLocation();
    return WillPopScope(
      onWillPop: () async {
        return homeNotifier.willPopM();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 26, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  hintText: 'What would you like to buy?',
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
                ref.watch(userProvider).currentUser == null
                    ? AppButton(
                        text: 'Log in to personalize your Buylink experience',
                        textColor: AppColors.primaryColor,
                        fontSize: 14,
                        backgroundColor: AppColors.shade1,
                        hasIcon: true,
                        icon: SvgPicture.asset(AppSvgs.login),
                        onPressed: () {
                          ref
                              .read(navigationServiceProvider)
                              .navigateOffAllNamed(
                                Routes.login,
                                (p0) => false,
                              );
                        },
                      )
                    : widget.fromLoginOrSignup
                        ? homeNotifier.showWelcome
                            ? AppButton(
                                text: 'Welcome to Buylink',
                                textColor: const Color(0xff14AD9F),
                                fontSize: 14,
                                backgroundColor: const Color(0xffDFF8F6),
                                hasIcon: true,
                                icon: SvgPicture.asset(AppSvgs.favoriteFilled),
                              )
                            : const Spacing.empty()
                        : const Spacing.empty(),
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
                      : RefreshIndicator(
                          onRefresh: () async {
                            homeNotifier.fetchRandomCategories();
                            await homeNotifier.fetchProducts(category: null);
                          },
                          child: MasonryGridView.count(
                            itemCount: homeNotifier.products.isEmpty
                                ? 1
                                : homeNotifier.products.length,
                            crossAxisCount:
                                homeNotifier.products.isEmpty ? 1 : 2,
                            mainAxisSpacing:
                                homeNotifier.products.isEmpty ? 0 : 20,
                            crossAxisSpacing:
                                homeNotifier.products.isEmpty ? 0 : 15,
                            itemBuilder: (context, index) {
                              if (homeNotifier.products.isEmpty) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: (MediaQuery.of(context).size.height /
                                              2) -
                                          200),
                                  child: const AppEmptyStates(
                                    imageString: AppImages.emptyProduct,
                                    message1String:
                                        'Oops, no products available',
                                    message2String:
                                        'Try searching with another keyword',
                                    buttonString: '',
                                    hasButton: false,
                                    hasIcon: false,
                                    // onButtonPressed: () => homeNotifier.fetchProducts(category: 'all'),
                                  ),
                                );
                              } else if (index == 3) {
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
                                    // Loader(context).hideLoader();
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
