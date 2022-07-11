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

import '../../../widgets/app_empty_states.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(categoryNotifierProvider)
          .fetchStoreCategories(storeId: widget.store.id.toString());
      await ref
          .watch(productListNotifierProvider)
          .fetchStoreProducts(storeId: widget.store.id, category: 'all');
      _tabController = TabController(
          length: ref.read(categoryNotifierProvider).storeCategories.length,
          vsync: this);
      _tabController.addListener(_handleTabChange);
      print('Left initttttttttttttttttttttttttt');
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
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.dark,
          //size: 14//change your color here
        ),
        leading: IconButton(
          onPressed: () {
            ref.read(navigationServiceProvider).navigateBack();
          },
          icon: const Icon(Icons.arrow_back_ios_outlined,
              size: 15, color: AppColors.grey2),
        ),
        elevation: 0,
        backgroundColor: AppColors.transparent,
        title: const Text(
          "Product Lists",
          style: TextStyle(
            color: AppColors.grey3,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: productListNotifier.state.isLoading ||
                categoryNotifier.storeCategoriesLoading
            ? const CircularProgress()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Spacing.mediumHeight(),
                  DecoratedBox(
                      decoration: BoxDecoration(
                        //This is for background color
                        color: Colors.white.withOpacity(0.0),

                        //This is for bottom border that is needed
                        border: const Border(
                          bottom: BorderSide(
                            color: AppColors.grey8,
                            width: 2,
                          ),
                        ),
                      ),
                      child: TabBar(
                          indicatorColor: AppColors.primaryColor,
                          labelColor: AppColors.shade5,
                          unselectedLabelColor: AppColors.grey5,
                          // padding: const EdgeInsets.only(bottom: 0),
                          controller: _tabController,
                          isScrollable: true,
                          onTap: (index) {
                            print('index $index');
                            productListNotifier.fetchStoreProducts(
                                storeId: widget.store.id,
                                category:
                                    categoryNotifier.storeCategories[index]);
                          },
                          tabs: categoryNotifier.storeCategories
                              .map((category) => Tab(text: category))
                              .toList())),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children:
                          categoryNotifier.storeCategories.map((category) {
                        return productListNotifier.products.isEmpty
                            ? AppEmptyStates(
                                onButtonPressed: () {
                                  ref
                                      .read(navigationServiceProvider)
                                      .navigateToNamed(
                                        Routes.addProduct,
                                        arguments: widget.store,
                                      );
                                },
                                imageString: AppImages.emptyProduct,
                                message1String: 'No Product Added Yet',
                                message2String:
                                    'Tap the button below to create your first store',
                                buttonString: '+ Add your first Product',
                                hasButton: true,
                                hasIcon: false,
                                // onButtonPressed: () => homeNotifier.fetchProducts(category: 'all'),
                              )
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 24,
                                ),
                                child: MasonryGridView.count(
                                  itemCount:
                                      productListNotifier.products.length,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 0,
                                  crossAxisSpacing: 16,
                                  itemBuilder: (context, index) {
                                    return ProductContainerPList(
                                      url: productListNotifier
                                          .products[index].image[0],
                                      storeName: productListNotifier
                                          .products[index].store.name,
                                      productName: productListNotifier
                                          .products[index].name,
                                      productPrice: productListNotifier
                                          .products[index].price,
                                      distance:
                                          ref.read(locationService).getDist(
                                                endLat: productListNotifier
                                                    .products[index].lat,
                                                endLon: productListNotifier
                                                    .products[index].lon,
                                              ),
                                      isFavorite: productListNotifier
                                          .products[index].isFav!,
                                      onProductTapped: () {
                                        ref
                                            .read(navigationServiceProvider)
                                            .navigateToNamed(
                                              Routes.productDetails2,
                                              arguments: productListNotifier
                                                  .products[index],
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
                                        productListNotifier
                                                .products[index].isFav!
                                            ? await ref
                                                .read(wishlistNotifierProvider)
                                                .removeFromWishlist(
                                                  productId: ref
                                                      .read(
                                                          wishlistNotifierProvider)
                                                      .products[index]
                                                      .id,
                                                )
                                            : await ref
                                                .read(wishlistNotifierProvider)
                                                .addToWishlist(
                                                  productId: ref
                                                      .read(
                                                          wishlistNotifierProvider)
                                                      .products[index]
                                                      .id,
                                                );
                                        ref.refresh(wishlistNotifierProvider);
                                      },
                                    );
                                  },
                                ));
                      }).toList(),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
