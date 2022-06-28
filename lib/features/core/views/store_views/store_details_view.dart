import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/constants/images.dart';
import 'package:buy_link/core/constants/svgs.dart';
import 'package:buy_link/core/routes.dart';
import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/features/core/models/store_review_arg_model.dart';
import 'package:buy_link/features/core/notifiers/home_notifier.dart';
import 'package:buy_link/features/core/notifiers/store_notifier/store_details_notifier.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/app_button.dart';
import 'package:buy_link/widgets/app_text_field.dart';
import 'package:buy_link/widgets/category_container.dart';
import 'package:buy_link/widgets/circular_progress.dart';
import 'package:buy_link/widgets/compare_texts.dart';
import 'package:buy_link/widgets/compare_texts_2.dart';
import 'package:buy_link/widgets/favorite_container.dart';
import 'package:buy_link/widgets/product_container.dart';
import 'package:buy_link/widgets/product_image_container.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/strings.dart';
import '../../../../services/location_service.dart';
import '../../../../widgets/iconNtext_container.dart';
import '../../models/compare_arg_model.dart';
import '../../models/message_model.dart';
import '../../models/product_model.dart';
import '../../notifiers/category_notifier.dart';
import '../../notifiers/user_provider.dart';
import '../../notifiers/wishlist_notifier.dart';

class StoreDetailsView extends ConsumerStatefulWidget {
  final int storeId;

  const StoreDetailsView({
    Key? key,
    required this.storeId,
  }) : super(key: key);

  @override
  ConsumerState<StoreDetailsView> createState() => _WishlistState();
}

class _WishlistState extends ConsumerState<StoreDetailsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ref
          .watch(storeDetailsNotifierProvider(widget.storeId))
          .fetchStoreProducts(
            storeId: widget.storeId,
            category: 'all',
          );
      _tabController = TabController(
          length: ref.read(categoryNotifierProvider).mCategories.length,
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
    ref.read(storeDetailsNotifierProvider(widget.storeId)).fetchStoreProducts(
        storeId: widget.storeId,
        category: ref
            .watch(categoryNotifierProvider)
            .mCategories[_tabController.index]
            .name);
  }

  @override
  Widget build(BuildContext context) {
    final storeDetailsNotifier =
        ref.watch(storeDetailsNotifierProvider(widget.storeId));
    final categoryNotifier = ref.watch(categoryNotifierProvider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              storeDetailsNotifier.detailsLoading
                  ? const CircularProgress()
                  : Stack(
                      children: [
                        Container(
                          height: 243,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                storeDetailsNotifier.storeDetails.background,
                              ),
                              fit: BoxFit.fill,
                            ),
                            // color: AppColors.red,
                          ),
                        ),
                        SizedBox(
                          height: 284,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CircleAvatar(
                                    radius: 34,
                                    backgroundImage: CachedNetworkImageProvider(
                                      storeDetailsNotifier.storeDetails.logo,
                                    ),
                                    backgroundColor: AppColors.transparent,
                                  ),
                                  Row(
                                    children: [
                                      FavoriteContainer(
                                        height: 32,
                                        width: 32,
                                        favIcon: const Icon(
                                          Icons.mail_outline_outlined,
                                          size: 16,
                                          color: AppColors.primaryColor,
                                        ),
                                        containerColor: AppColors.grey10,
                                        radius: 50,
                                        padding: 1,
                                        hasBorder: true,
                                        onFavoriteTapped: () {
                                          ref
                                              .read(navigationServiceProvider)
                                              .navigateToNamed(
                                                Routes.messageView,
                                                arguments: MessageModel(
                                                  id: storeDetailsNotifier
                                                      .storeId,
                                                  name: storeDetailsNotifier
                                                      .storeDetails.name,
                                                  imageUrl: storeDetailsNotifier
                                                      .storeDetails.background,
                                                  from: 'storeDetails',
                                                ),
                                              );
                                        },
                                      ),
                                      const Spacing.smallWidth(),
                                      FavoriteContainer(
                                        height: 32,
                                        width: 32,
                                        favIcon: SvgPicture.asset(
                                          AppSvgs.locateOutlined,
                                          color: AppColors.primaryColor,
                                          fit: BoxFit.none,
                                          width: 16,
                                          height: 16,
                                        ),
                                        containerColor: AppColors.grey10,
                                        radius: 50,
                                        padding: 1,
                                        hasBorder: true,
                                      ),
                                      const Spacing.smallWidth(),
                                      AppButton(
                                        text: 'See Review',
                                        textColor: AppColors.shade5,
                                        fontSize: 12,
                                        width: null,
                                        height: 32,
                                        borderColor: AppColors.shade5,
                                        onPressed: () => ref
                                            .read(navigationServiceProvider)
                                            .navigateToNamed(
                                              Routes.storeReviews,
                                              arguments: StoreReviewArgModel(
                                                  storeName:
                                                      storeDetailsNotifier
                                                          .storeDetails.name,
                                                  storeId: widget.storeId),
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
              const Spacing.smallHeight(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: storeDetailsNotifier.detailsLoading
                    ? Container()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacing.smallHeight(),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    storeDetailsNotifier.storeDetails.name,
                                    style: const TextStyle(
                                      color: AppColors.grey1,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacing.smallWidth(),
                                  SvgPicture.asset(
                                    AppSvgs.star,
                                    width: 12,
                                    height: 12,
                                    color: AppColors.yellow,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    storeDetailsNotifier.storeDetails.star
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.grey1),
                                  ),
                                ],
                              ),
                              Text(
                                storeDetailsNotifier.storeDetails.about,
                                style: const TextStyle(
                                  color: AppColors.grey2,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacing.tinyHeight(),
                              Text(
                                storeDetailsNotifier.storeDetails.address,
                                style: const TextStyle(
                                  color: AppColors.grey4,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacing.tinyHeight(),
                              Text(
                                storeDetailsNotifier.storeDetails.telephone,
                                style: const TextStyle(
                                  color: AppColors.grey4,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacing.tinyHeight(),
                              Text(
                                storeDetailsNotifier.storeDetails.email,
                                style: const TextStyle(
                                  color: AppColors.grey4,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacing.bigHeight(),
                            ],
                          ),
                          const Spacing.bigHeight(),
                          TabBar(
                              labelColor: AppColors.shade5,
                              unselectedLabelColor: AppColors.grey5,
                              padding: const EdgeInsets.only(bottom: 24),
                              controller: _tabController,
                              isScrollable: true,
                              onTap: (index) {
                                print('index $index');
                                storeDetailsNotifier.fetchStoreProducts(
                                    storeId: widget.storeId,
                                    category: categoryNotifier
                                        .categories[index].name);
                              },
                              tabs: categoryNotifier.mCategories
                                  .map((category) => Tab(text: category.name))
                                  .toList()),
                          SizedBox(
                            height: 500,
                            child: TabBarView(
                              controller: _tabController,
                              children:
                                  categoryNotifier.mCategories.map((category) {
                                return storeDetailsNotifier.state.isLoading
                                    ? const CircularProgress()
                                    : MasonryGridView.count(
                                        itemCount: storeDetailsNotifier
                                            .products.length,
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 20,
                                        crossAxisSpacing: 15,
                                        itemBuilder: (context, index) {
                                          return ProductContainer(
                                            url: storeDetailsNotifier
                                                .products[index].image[0],
                                            storeName: storeDetailsNotifier
                                                .products[index].store.name,
                                            productName: storeDetailsNotifier
                                                .products[index].name,
                                            productPrice: storeDetailsNotifier
                                                .products[index].price,
                                            distance: ref
                                                .read(locationService)
                                                .getDistance(
                                                  endLat: storeDetailsNotifier
                                                      .products[index].lat,
                                                  endLon: storeDetailsNotifier
                                                      .products[index].lon,
                                                ),
                                            isFavorite: true,
                                            onProductTapped: () {
                                              ref
                                                  .read(
                                                      navigationServiceProvider)
                                                  .navigateToNamed(
                                                    Routes.productDetails,
                                                    arguments:
                                                        storeDetailsNotifier
                                                            .products[index],
                                                  );
                                            },
                                            onDistanceTapped: () {},
                                            onFlipTapped: () {
                                              ref
                                                  .read(
                                                      navigationServiceProvider)
                                                  .navigateToNamed(
                                                    Routes.compare,
                                                    arguments: CompareArgModel(
                                                      product:
                                                          storeDetailsNotifier
                                                              .products[index],
                                                    ),
                                                  );
                                            },
                                            onFavoriteTapped: () async {
                                              storeDetailsNotifier
                                                      .products[index].isFav!
                                                  ? await ref
                                                      .read(
                                                          wishlistNotifierProvider)
                                                      .removeFromWishlist(
                                                        productId: ref
                                                            .read(
                                                                wishlistNotifierProvider)
                                                            .products[index]
                                                            .id,
                                                      )
                                                  : await ref
                                                      .read(
                                                          wishlistNotifierProvider)
                                                      .addToWishlist(
                                                        productId: ref
                                                            .read(
                                                                wishlistNotifierProvider)
                                                            .products[index]
                                                            .id,
                                                      );
                                              ref.refresh(
                                                  wishlistNotifierProvider);
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
            ],
          ),
        ),
      ),
    );
  }
}
