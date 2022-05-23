import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/constants/images.dart';
import 'package:buy_link/core/constants/strings.dart';
import 'package:buy_link/core/constants/svgs.dart';
import 'package:buy_link/core/routes.dart';
import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/features/core/models/category_model.dart';
import 'package:buy_link/features/core/notifiers/home_notifier.dart';
import 'package:buy_link/features/core/notifiers/wishlist_notifier.dart';
import 'package:buy_link/services/location_service.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/app_button.dart';
import 'package:buy_link/widgets/app_text_field.dart';
import 'package:buy_link/widgets/category_container.dart';
import 'package:buy_link/widgets/circular_progress.dart';
import 'package:buy_link/widgets/product_container.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/compare_arg_model.dart';
import '../notifiers/category_notifier.dart';

class WishlistView extends ConsumerStatefulWidget {
  const WishlistView({Key? key}) : super(key: key);
  @override
  ConsumerState<WishlistView> createState() => _WishlistState();
}

class _WishlistState extends ConsumerState<WishlistView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(
        length: ref.read(categoryNotifierProvider).mCategories.length,
        vsync: this);
    _tabController.addListener(_handleTabChange);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ref.watch(wishlistNotifierProvider).fetchWishlist(category: 'all');
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    ref.read(wishlistNotifierProvider).fetchWishlist(
        category: ref
            .watch(categoryNotifierProvider)
            .mCategories[_tabController.index]
            .name);
  }

  // TODO: Make the third product fill the screen's width
  @override
  Widget build(BuildContext context) {
    final wishlistNotifier = ref.watch(wishlistNotifierProvider);
    final categoryNotifier = ref.watch(categoryNotifierProvider);
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
              const Text(
                'Wishlist',
                style: TextStyle(
                  color: AppColors.grey1,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacing.mediumHeight(),
              TabBar(
                  labelColor: AppColors.shade5,
                  unselectedLabelColor: AppColors.grey5,
                  padding: const EdgeInsets.only(bottom: 24),
                  controller: _tabController,
                  isScrollable: true,
                  onTap: (index) {
                    print('index $index');
                    wishlistNotifier.fetchWishlist(
                        category: categoryNotifier.categories[index].name);
                  },
                  tabs: categoryNotifier.mCategories
                      .map((category) => Tab(text: category.name))
                      .toList()),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: categoryNotifier.mCategories.map((category) {
                    return wishlistNotifier.state.isLoading
                        ? const CircularProgress()
                        : MasonryGridView.count(
                            itemCount: wishlistNotifier.products.length,
                            crossAxisCount: 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 15,
                            itemBuilder: (context, index) {
                              return ProductContainer(
                                url: wishlistNotifier.products[index].image[0],
                                storeName:
                                    wishlistNotifier.products[index].store.name,
                                productName:
                                    wishlistNotifier.products[index].name,
                                productPrice:
                                    wishlistNotifier.products[index].price,
                                distance: ref.read(locationService).getDistance(
                                      storeLat:
                                          wishlistNotifier.products[index].lat,
                                      storeLon:
                                          wishlistNotifier.products[index].lon,
                                    ),
                                isFavorite: true,
                                onProductTapped: () {
                                  ref
                                      .read(navigationServiceProvider)
                                      .navigateToNamed(
                                        Routes.productDetails,
                                        arguments:
                                            wishlistNotifier.products[index],
                                      );
                                },
                                onDistanceTapped: () {},
                                onFlipTapped: () {
                                  ref
                                      .read(navigationServiceProvider)
                                      .navigateToNamed(
                                        Routes.compare,
                                        arguments: CompareArgModel(
                                          product:
                                              wishlistNotifier.products[index],
                                        ),
                                      );
                                },
                                onFavoriteTapped: () async {
                                  wishlistNotifier.products[index].isFav!
                                      ? await wishlistNotifier
                                          .removeFromWishlist(
                                          productId: wishlistNotifier
                                              .products[index].id,
                                        )
                                      : await wishlistNotifier.addToWishlist(
                                          productId: wishlistNotifier
                                              .products[index].id,
                                        );
                                  ref.refresh(wishlistNotifierProvider);
                                },
                              );
                            },
                          );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
