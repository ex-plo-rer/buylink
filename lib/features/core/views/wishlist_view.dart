import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/constants/images.dart';
import 'package:buy_link/core/constants/svgs.dart';
import 'package:buy_link/core/routes.dart';
import 'package:buy_link/features/core/notifiers/home_notifier.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/app_button.dart';
import 'package:buy_link/widgets/app_text_field.dart';
import 'package:buy_link/widgets/category_container.dart';
import 'package:buy_link/widgets/product_container.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  // TODO: Make the third product fill the screen's width
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 14,
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
              Align(
                alignment: Alignment.centerRight,
                child: AppButton(
                  text: 'See all categories',
                  textColor: AppColors.shade5,
                  onPressed: () {
                    ref
                        .read(navigationServiceProvider)
                        .navigateToNamed(Routes.categories);
                  },
                  //=> ref
                  //.read(navigationServiceProvider)
                  //.navigateToNamed(Routes.categories),
                  fontSize: 12,
                  width: null,
                  height: 22,
                  borderColor: AppColors.shade5,
                ),
              ),
              const Spacing.smallHeight(),
              TabBar(
                labelColor: AppColors.shade5,
                unselectedLabelColor: AppColors.grey5,
                padding: const EdgeInsets.only(bottom: 10),
                controller: _tabController,
                isScrollable: true,
                tabs: const [
                  Tab(
                      child: Flexible ( child: Text("All")
                  )),
                  Tab(
                    child: Text("Fashion")),
                  Tab(
                      child : Text("Photography")),
                  Tab(
                      child: Flexible(child: Text ("Baby & Toddler")))
                  // Tab(text: 'All'),
                  // Tab(text: 'Fashion'),
                  // Tab(text: 'Photography'),
                  // Tab(text: 'Baby & Toddler'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    MasonryGridView.count(
                      itemCount: 20 + 1,
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 15,
                      itemBuilder: (context, index) {
                        if (index == 3) {
                          return ProductContainer(
                            url:
                            'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
                            storeName: 'Atinuke Store',
                            productName: 'Oraimo Power Bank',
                            productPrice: '12000',
                            distance: '3.5',
                            onProductTapped: () {},
                            onDistanceTapped: () {},
                            onFlipTapped: () {},
                            onFavoriteTapped: () {
                              // homeNotifier.toggleFavorite();
                            },
                            isBig: true,
                          );
                        } else {
                          return ProductContainer(
                            url:
                            'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
                            storeName: 'Atinuke Store',
                            productName: 'Oraimo Power Bank',
                            productPrice: '12000',
                            distance: '3.5',
                            onProductTapped: () {},
                            onDistanceTapped: () {},
                            onFlipTapped: () {},
                            onFavoriteTapped: () {
                              // homeNotifier.toggleFavorite();
                            },
                          );
                        }
                      },
                    ),
                    MasonryGridView.count(
                      itemCount: 20 + 1,
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 15,
                      itemBuilder: (context, index) {
                        if (index == 3) {
                          return ProductContainer(
                            url:
                            'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
                            storeName: 'Atinuke Store',
                            productName: 'Oraimo Power Bank',
                            productPrice: '12000',
                            distance: '3.5',
                            onProductTapped: () {},
                            onDistanceTapped: () {},
                            onFlipTapped: () {},
                            onFavoriteTapped: () {
                              // homeNotifier.toggleFavorite();
                            },
                            isBig: true,
                          );
                        } else {
                          return ProductContainer(
                            url:
                            'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
                            storeName: 'Atinuke Store',
                            productName: 'Oraimo Power Bank',
                            productPrice: '12000',
                            distance: '3.5',
                            onProductTapped: () {},
                            onDistanceTapped: () {},
                            onFlipTapped: () {},
                            onFavoriteTapped: () {
                              // homeNotifier.toggleFavorite();
                            },
                          );
                        }
                      },
                    ),
                    MasonryGridView.count(
                      itemCount: 20 + 1,
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 15,
                      itemBuilder: (context, index) {
                        if (index == 3) {
                          return ProductContainer(
                            url:
                            'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
                            storeName: 'Atinuke Store',
                            productName: 'Oraimo Power Bank',
                            productPrice: '12000',
                            distance: '3.5',
                            onProductTapped: () {},
                            onDistanceTapped: () {},
                            onFlipTapped: () {},
                            onFavoriteTapped: () {
                              // homeNotifier.toggleFavorite();
                            },
                            isBig: true,
                          );
                        } else {
                          return ProductContainer(
                            url:
                            'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
                            storeName: 'Atinuke Store',
                            productName: 'Oraimo Power Bank',
                            productPrice: '12000',
                            distance: '3.5',
                            onProductTapped: () {},
                            onDistanceTapped: () {},
                            onFlipTapped: () {},
                            onFavoriteTapped: () {
                              // homeNotifier.toggleFavorite();
                            },
                          );
                        }
                      },
                    ),
                    MasonryGridView.count(
                      itemCount: 20 + 1,
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 15,
                      itemBuilder: (context, index) {
                        if (index == 3) {
                          return ProductContainer(
                            url:
                            'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
                            storeName: 'Atinuke Store',
                            productName: 'Oraimo Power Bank',
                            productPrice: '12000',
                            distance: '3.5',
                            onProductTapped: () {},
                            onDistanceTapped: () {},
                            onFlipTapped: () {},
                            onFavoriteTapped: () {
                              // homeNotifier.toggleFavorite();
                            },
                            isBig: true,
                          );
                        } else {
                          return ProductContainer(
                            url:
                            'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
                            storeName: 'Atinuke Store',
                            productName: 'Oraimo Power Bank',
                            productPrice: '12000',
                            distance: '3.5',
                            onProductTapped: () {},
                            onDistanceTapped: () {},
                            onFlipTapped: () {},
                            onFavoriteTapped: () {
                              // homeNotifier.toggleFavorite();
                            },
                          );
                        }
                      },
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
