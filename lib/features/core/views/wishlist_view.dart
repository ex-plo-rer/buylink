import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/routes.dart';
import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/features/core/notifiers/wishlist_notifier.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/circular_progress.dart';
import 'package:buy_link/widgets/product_container.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/loader.dart';
import '../notifiers/category_notifier.dart';
import '../notifiers/flip_notifier.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(categoryNotifierProvider).fetchUserCategories();
      await ref.watch(wishlistNotifierProvider).fetchWishlist(category: 'all');
      _tabController = TabController(
          length: ref.read(categoryNotifierProvider).userCategories.length,
          vsync: this);
      _tabController.addListener(_handleTabChange);
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
            .userCategories[_tabController.index]);
  }

  // TODO: Make the third product fill the screen's width
  @override
  Widget build(BuildContext context) {
    final wishlistNotifier = ref.watch(wishlistNotifierProvider);
    final categoryNotifier = ref.watch(categoryNotifierProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 24, 18, 0),
          child: wishlistNotifier.favLoading ||
                  categoryNotifier.userCategoriesLoading
              ? const CircularProgress()
              : Column(
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
                        indicatorColor: AppColors.primaryColor,
                        labelColor: AppColors.primaryColor,
                        unselectedLabelColor: AppColors.grey5,
                        //padding: const EdgeInsets.only(bottom: 4),
                        controller: _tabController,
                        isScrollable: true,
                        onTap: (index) {
                          print('index $index');
                          wishlistNotifier.fetchWishlist(
                              category: categoryNotifier.userCategories[index]);
                        },
                        tabs: categoryNotifier.userCategories
                            .map((category) => Tab(text: category))
                            .toList()),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children:
                            categoryNotifier.userCategories.map((category) {
                          return wishlistNotifier.favLoading
                              ? const CircularProgress()
                              : wishlistNotifier.products.isEmpty
                                  ? const Center(child: Text('Empty'))
                                  : MasonryGridView.count(
                                      itemCount:
                                          wishlistNotifier.products.length,
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 15,
                                      itemBuilder: (context, index) {
                                        return ProductContainer(
                                          product:
                                              wishlistNotifier.products[index],
                                          isFavorite: true,
                                          onProductTapped: () {
                                            ref
                                                .read(navigationServiceProvider)
                                                .navigateToNamed(
                                                  Routes.productDetails,
                                                  arguments: wishlistNotifier
                                                      .products[index],
                                                );
                                          },
                                          onDistanceTapped: () {},
                                          onFlipTapped: () async {
                                            Loader(context)
                                                .showLoader(text: '');
                                            await ref
                                                .read(flipNotifierProvider)
                                                .addItemToCompare(
                                                    productId: wishlistNotifier
                                                        .products[index].id);
                                            if (ref
                                                .read(flipNotifierProvider)
                                                .successfullyAdded) {
                                              Loader(context).hideLoader();
                                              ref
                                                  .read(
                                                      navigationServiceProvider)
                                                  .navigateToNamed(
                                                      Routes.compare);
                                              return;
                                            }
                                            Loader(context).hideLoader();
                                          },
                                          onFavoriteTapped: () =>
                                              wishlistNotifier.removeFromFav(
                                            index: index,
                                            id: wishlistNotifier
                                                .products[index].id,
                                          ),
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
