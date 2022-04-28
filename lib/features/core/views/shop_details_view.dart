import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/constants/images.dart';
import 'package:buy_link/core/constants/svgs.dart';
import 'package:buy_link/features/core/notifiers/home_notifier.dart';
import 'package:buy_link/widgets/app_button.dart';
import 'package:buy_link/widgets/app_text_field.dart';
import 'package:buy_link/widgets/category_container.dart';
import 'package:buy_link/widgets/compare_texts.dart';
import 'package:buy_link/widgets/compare_texts_2.dart';
import 'package:buy_link/widgets/favorite_container.dart';
import 'package:buy_link/widgets/product_container.dart';
import 'package:buy_link/widgets/product_image_container.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/strings.dart';
import '../../../widgets/iconNtext_container.dart';

class ShopDetailsView extends ConsumerStatefulWidget {
  const ShopDetailsView({Key? key}) : super(key: key);
  @override
  ConsumerState<ShopDetailsView> createState() => _WishlistState();
}

class _WishlistState extends ConsumerState<ShopDetailsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 243,
                decoration: const BoxDecoration(
                  color: AppColors.grey1,
                ),
              ),
              const Spacing.smallHeight(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FavoriteContainer(
                          height: 32,
                          width: 32,
                          favIcon: Icon(
                            Icons.mail_outline_outlined,
                            size: 14,
                          ),
                          containerColor: AppColors.grey10,
                          radius: 50,
                          padding: 1,
                          hasBorder: true,
                        ),
                        Spacing.smallWidth(),
                        FavoriteContainer(
                          height: 32,
                          width: 32,
                          favIcon: Icon(
                            Icons.mail_outline_outlined,
                            size: 14,
                          ),
                          containerColor: AppColors.grey10,
                          radius: 50,
                          padding: 1,
                          hasBorder: true,
                        ),
                        Spacing.smallWidth(),
                        AppButton(
                          text: 'See Review',
                          textColor: AppColors.shade5,
                          fontSize: 12,
                          width: null,
                          height: 32,
                          borderColor: AppColors.shade5,
                        ),
                      ],
                    ),
                    const Spacing.smallHeight(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'Atinuke Stores',
                          style: TextStyle(
                            color: AppColors.grey1,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconNTextContainer(
                          text: '4.6 km',
                          icon: Icon(
                            Icons.star_outline,
                            size: 12,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'We sell all fashion wears, shoes, bags, slides all at affordable rates',
                      style: TextStyle(
                        color: AppColors.grey2,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacing.tinyHeight(),
                    const Text(
                      'Shop 3, Maxdot, Ikeja, Lagos',
                      style: TextStyle(
                        color: AppColors.grey4,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacing.tinyHeight(),
                    const Text(
                      '+23478768987673',
                      style: TextStyle(
                        color: AppColors.grey4,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacing.tinyHeight(),
                    const Text(
                      'Atinuke@gmail.com',
                      style: TextStyle(
                        color: AppColors.grey4,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacing.bigHeight(),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: AppButton(
                        text: 'See all categories',
                        textColor: AppColors.shade5,
                        fontSize: 12,
                        width: null,
                        height: 22,
                        borderColor: AppColors.shade5,
                        backgroundColor: AppColors.primaryColor,
                      ),
                    ),
                    const Spacing.bigHeight(),
                    TabBar(
                      labelColor: AppColors.shade5,
                      unselectedLabelColor: AppColors.grey5,
                      padding: const EdgeInsets.only(bottom: 24),
                      controller: _tabController,
                      isScrollable: true,
                      tabs: const [
                        Tab(text: 'All'),
                        Tab(text: 'Fashion'),
                        Tab(text: 'Photography'),
                        Tab(text: 'Baby & Toddler'),
                        Tab(text: '5555555'),
                      ],
                    ),
                    SizedBox(
                      height: 500,
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
            ],
          ),
        ),
      ),
    );
  }
}
