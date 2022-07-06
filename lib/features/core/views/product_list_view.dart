import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/constants/images.dart';
import 'package:buy_link/core/constants/strings.dart';
import 'package:buy_link/core/constants/svgs.dart';
import 'package:buy_link/core/routes.dart';
import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/features/core/models/category_model.dart';
import 'package:buy_link/features/core/models/edit_product_arg_model.dart';
import 'package:buy_link/features/core/notifiers/home_notifier.dart';
import 'package:buy_link/features/core/notifiers/wishlist_notifier.dart';
import 'package:buy_link/services/location_service.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/app_button.dart';
import 'package:buy_link/widgets/app_text_field.dart';
import 'package:buy_link/widgets/category_container.dart';
import 'package:buy_link/widgets/circular_progress.dart';
import 'package:buy_link/widgets/product_container.dart';
import 'package:buy_link/widgets/product_container_plist.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/compare_arg_model.dart';
import '../models/product_model.dart';
import '../notifiers/category_notifier.dart';
import '../notifiers/flip_notifier.dart';
import '../notifiers/product_list_notifier.dart';

class ProductListView extends ConsumerStatefulWidget {
  final Store store;

  const ProductListView({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  ConsumerState<ProductListView> createState() => _WishlistState();
}

class _WishlistState extends ConsumerState<ProductListView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(
        length: ref.read(categoryNotifierProvider).storeCategories.length,
        vsync: this);
    _tabController.addListener(_handleTabChange);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .watch(productListNotifierProvider)
          .fetchStoreProducts(storeId: widget.store.id, category: 'all');
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
    ref.read(productListNotifierProvider).fetchStoreProducts(
          storeId: widget.store.id,
          category: ref
              .watch(categoryNotifierProvider)
              .storeCategories[_tabController.index],
        );
  }

  // TODO: Make the third product fill the screen's width
  @override
  Widget build(BuildContext context) {
    final productListNotifier = ref.watch(productListNotifierProvider);
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
                'Product List',
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
                    productListNotifier.fetchStoreProducts(
                        storeId: widget.store.id,
                        category: categoryNotifier.storeCategories[index]);
                  },
                  tabs: categoryNotifier.storeCategories
                      .map((category) => Tab(text: category))
                      .toList()),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: categoryNotifier.storeCategories.map((category) {
                    return productListNotifier.state.isLoading
                        ? const CircularProgress()
                        : MasonryGridView.count(
                            itemCount: productListNotifier.products.length,
                            crossAxisCount: 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 15,
                            itemBuilder: (context, index) {
                              return ProductContainerPList(
                                url: productListNotifier
                                    .products[index].image[0],
                                storeName: productListNotifier
                                    .products[index].store.name,
                                productName:
                                    productListNotifier.products[index].name,
                                productPrice:
                                    productListNotifier.products[index].price,
                                distance: ref.read(locationService).getDist(
                                      endLat: productListNotifier
                                          .products[index].lat,
                                      endLon: productListNotifier
                                          .products[index].lon,
                                    ),
                                isFavorite:
                                    productListNotifier.products[index].isFav!,
                                onProductTapped: () {
                                  ref
                                      .read(navigationServiceProvider)
                                      .navigateToNamed(
                                        Routes.productDetails2,
                                        arguments:
                                            productListNotifier.products[index],
                                        // arguments: EditProductArgModel(store: productListNotifier.products[index].store, product: productListNotifier.productEditModel),
                                      );
                                  // ref
                                  //     .read(navigationServiceProvider)
                                  //     .navigateToNamed(
                                  //       Routes.editProduct,
                                  //       // arguments: productListNotifier.products[index],
                                  //       // arguments: EditProductArgModel(store: productListNotifier.products[index].store, product: productListNotifier.productEditModel),
                                  //     );
                                },
                                onDistanceTapped: () {},
                                onFlipTapped: () async {
                                  await ref
                                      .read(flipNotifierProvider)
                                      .addItemToCompare(
                                          productId: productListNotifier
                                              .products[index].id);
                                  if (ref
                                      .read(flipNotifierProvider)
                                      .successfullyAdded) {
                                    ref
                                        .read(navigationServiceProvider)
                                        .navigateToNamed(Routes.compare);
                                  }
                                },
                                onFavoriteTapped: () async {
                                  productListNotifier.products[index].isFav!
                                      ? await ref
                                          .read(wishlistNotifierProvider)
                                          .removeFromWishlist(
                                            productId: ref
                                                .read(wishlistNotifierProvider)
                                                .products[index]
                                                .id,
                                          )
                                      : await ref
                                          .read(wishlistNotifierProvider)
                                          .addToWishlist(
                                            productId: ref
                                                .read(wishlistNotifierProvider)
                                                .products[index]
                                                .id,
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
