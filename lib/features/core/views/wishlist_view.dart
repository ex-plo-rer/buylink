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

import '../../../core/constants/images.dart';
import '../../../core/utilities/loader.dart';
import '../../../widgets/app_empty_states.dart';
import '../notifiers/category_notifier.dart';
import '../notifiers/flip_notifier.dart';
import '../notifiers/user_provider.dart';

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
    if (ref.read(userProvider).currentUser != null) {
      // TODO: implement initState
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (ref.read(categoryNotifierProvider).userCategories.isEmpty) {
          await ref.read(categoryNotifierProvider).fetchUserCategories();
        }
        // ref.watch(wishlistNotifierProvider).fetchWishlist(category: 'all');
        _tabController = TabController(
            length: ref.read(categoryNotifierProvider).userCategories.length,
            vsync: this);
        _tabController.addListener(_handleTabChange);
      });
      // init();
    }
    super.initState();
  }

  Future<void> init() async {
    if (ref.read(categoryNotifierProvider).userCategories.isEmpty) {
      await ref.read(categoryNotifierProvider).fetchUserCategories();
    }
    // ref.read(wishlistNotifierProvider).fetchWishlist(category: 'all');
    _tabController = TabController(
        length: ref.watch(categoryNotifierProvider).userCategories.length,
        vsync: this);
    _tabController.addListener(_handleTabChange);
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
    final categoryNotifier = ref.watch(categoryNotifierProvider);
    final wishlistNotifier = ref.watch(wishlistNotifierProvider);
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
                    const Spacing.mediumHeight(),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children:
                            categoryNotifier.userCategories.map((category) {
                          return wishlistNotifier.favLoading
                              ? const CircularProgress()
                              : RefreshIndicator(
                                  onRefresh: () async {
                                    await wishlistNotifier.fetchWishlist(
                                        category:
                                            categoryNotifier.userCategories[
                                                _tabController.index]);
                                  },
                                  child: MasonryGridView.count(
                                    itemCount: wishlistNotifier.products.isEmpty
                                        ? 1
                                        : wishlistNotifier.products.length,
                                    crossAxisCount:
                                        wishlistNotifier.products.isEmpty
                                            ? 1
                                            : 2,
                                    mainAxisSpacing:
                                        wishlistNotifier.products.isEmpty
                                            ? 0
                                            : 20,
                                    crossAxisSpacing:
                                        wishlistNotifier.products.isEmpty
                                            ? 0
                                            : 15,
                                    itemBuilder: (context, index) {
                                      return wishlistNotifier.products.isEmpty
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  top: (MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          2) -
                                                      200),
                                              child: const AppEmptyStates(
                                                imageString:
                                                    AppImages.emptyProduct,
                                                message1String:
                                                    'No product in wishlist',
                                                message2String:
                                                    'Pull down to refresh',
                                                buttonString: '',
                                                hasButton: false,
                                                hasIcon: false,
                                                // onButtonPressed: () => homeNotifier.fetchProducts(category: 'all'),
                                              ),
                                            )
                                          : ProductContainer(
                                              product: wishlistNotifier
                                                  .products[index],
                                              isFavorite: true,
                                              onProductTapped: () {
                                                ref
                                                    .read(
                                                        navigationServiceProvider)
                                                    .navigateToNamed(
                                                      Routes.productDetails,
                                                      arguments:
                                                          wishlistNotifier
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
                                                        productId:
                                                            wishlistNotifier
                                                                .products[index]
                                                                .id);
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
                                                // Loader(context).hideLoader();
                                              },
                                              onFavoriteTapped: () =>
                                                  wishlistNotifier
                                                      .removeFromFav(
                                                index: index,
                                                id: wishlistNotifier
                                                    .products[index].id,
                                              ),
                                            );
                                    },
                                  ),
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
