import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/constants/images.dart';
import 'package:buy_link/core/constants/svgs.dart';
import 'package:buy_link/core/routes.dart';
import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/features/core/models/compare_arg_model.dart';
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

import '../../../core/constants/strings.dart';
import '../../../core/utilities/alertify.dart';
import '../../../core/utilities/loader.dart';
import '../../../widgets/circular_progress.dart';
import '../../../widgets/compare_search_term_container.dart';
import '../../../widgets/map_search_term_container.dart';
import '../models/product_search.dart';
import '../notifiers/category_notifier.dart';
import '../notifiers/flip_notifier.dart';
import '../notifiers/store_notifier/compare_search_notifier.dart';

class CompareProductsView extends ConsumerStatefulWidget {
  CompareProductsView({
    Key? key,
    required this.searchTerm,
  }) : super(key: key);
  final String searchTerm;

  @override
  ConsumerState<CompareProductsView> createState() =>
      _CompareProductsViewState();
}

class _CompareProductsViewState extends ConsumerState<CompareProductsView> {
  final searchFN = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    ref.read(compareSearchNotifierProvider).initLocation();
    ref
        .read(compareSearchNotifierProvider)
        .fetchCompareSearch(searchTerm: widget.searchTerm);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final wishlistNotifier = ref.watch(wishlistNotifierProvider);
    // final categoryNotifier = ref.watch(categoryNotifierProvider);
    final compareSearchNotifier = ref.watch(compareSearchNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.dark, //change your color here
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.transparent,
        title: const Text(
          AppStrings.compare,
          style: TextStyle(
            color: AppColors.dark,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CompareSearchTermContainer(
                marginTop: 0,
                horizontalMargin: 0,
                containerColor: AppColors.grey10,
                searchTerm: widget.searchTerm,
                onMinChanged: compareSearchNotifier.onMinPriceChanged,
                onMaxChanged: compareSearchNotifier.onMaxPriceChanged,
                onSliderChanged: (newValue) =>
                    compareSearchNotifier.onSliderChanged(newValue),
                sliderValue: compareSearchNotifier.sliderValue,
                onApplyPressed: () {
                  if (compareSearchNotifier.minPrice! >=
                      compareSearchNotifier.maxPrice!) {
                    Alertify(
                            title:
                                'Minimum price should not be greater than maximum price.')
                        .error();
                  } else {
                    ref.read(navigationServiceProvider).navigateBack();
                    // Loader(context).showLoader(text: 'Loading');
                    compareSearchNotifier.fetchCompareSearch(
                      searchTerm: widget.searchTerm,
                      isInitialLoading: false,
                    );
                    // Loader(context).hideLoader();
                  }
                }),
            const Spacing.smallHeight(),
            Expanded(
              child: compareSearchNotifier.productsLoading
                  ? const CircularProgress()
                  : compareSearchNotifier.products.isEmpty
                      ? AppEmptyStates(
                          imageString: AppImages.bag,
                          message1String:
                              'No Product... Kindly Reload or check back',
                          buttonString: 'Reload',
                          hasButton: false,
                          hasIcon: false,
                          onButtonPressed: () => () {})
                      : MasonryGridView.count(
                          itemCount: compareSearchNotifier.products.length,
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 15,
                          itemBuilder: (context, index) {
                            return ProductContainer(
                              url: compareSearchNotifier
                                  .products[index].image[0],
                              storeName: compareSearchNotifier
                                  .products[index].store.name,
                              productName:
                                  compareSearchNotifier.products[index].name,
                              productPrice:
                                  compareSearchNotifier.products[index].price,
                              distance: ref.watch(locationService).getDistance(
                                    endLat: compareSearchNotifier
                                        .products[index].lat,
                                    endLon: compareSearchNotifier
                                        .products[index].lon,
                                  ),
                              isFavorite: false,
                              onProductTapped: () async {
                                await ref
                                    .read(flipNotifierProvider)
                                    .addItemToCompare(
                                        productId: compareSearchNotifier
                                            .products[index].id);
                                if (ref
                                    .read(flipNotifierProvider)
                                    .successfullyAdded) {
                                  ref
                                      .read(navigationServiceProvider)
                                      .navigateBack();
                                  ref
                                      .read(navigationServiceProvider)
                                      .navigateOffNamed(
                                        Routes.compare,
                                        // arguments: CompareArgModel(
                                        //     product:
                                        //         homeNotifier.products[index]),
                                      );
                                }
                              },
                              onDistanceTapped: () {},
                              onFlipTapped: () {
                                // ref
                                //     .read(navigationServiceProvider)
                                //     .navigateToNamed(
                                //       Routes.compare,
                                //       arguments: CompareArgModel(
                                //           product: compareSearchNotifier
                                //               .products[index]),
                                //     );
                              },
                              onFavoriteTapped: () async {
                                // compareSearchNotifier.products[index].isFav!
                                //     ? await wishlistNotifier
                                //         .removeFromWishlist(
                                //         productId: compareSearchNotifier
                                //             .products[index].id,
                                //       )
                                //     : await wishlistNotifier.addToWishlist(
                                //         productId: compareSearchNotifier
                                //             .products[index].id,
                                //       );
                                // ref.refresh(
                                //     compareSearchNotifierProvider(null));
                              },
                            );
                          }),
            ),
          ],
        ),
      ),
    );
  }
}
