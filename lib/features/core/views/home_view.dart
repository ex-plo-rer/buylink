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

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final homeNotifier = ref.watch(homeNotifierProvider);
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
              const AppTextField(
                hintText: 'What would you like to buy ?',
                prefixIcon: Icon(Icons.search_outlined),
                hasBorder: false,
                isSearch: true,
                fillColor: AppColors.grey8,
                hasPrefixIcon: true,
              ),
              const Spacing.height(12),
              AppButton(
                text: 'Log in to personalize your Buylink experience',
                textColor: AppColors.primaryColor,
                fontSize: 14,
                backgroundColor: AppColors.shade1,
                hasIcon: true,
                icon: SvgPicture.asset(AppSvgs.login),
              ),
              const Spacing.height(12),
              const Text(
                'Based on your interest',
                style: TextStyle(
                  color: AppColors.grey1,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacing.smallHeight(),
              Expanded(
                child: MasonryGridView.count(
                  itemCount: 20 + 1,
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 15,
                  itemBuilder: (context, index) {
                    if (index == 3) {
                      return Container(
                        height: 176,
                        color: AppColors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CategoryContainer(
                              categoryName: 'Fashion',
                              categoryImage: '',
                              onTap: () {},
                            ),
                            CategoryContainer(
                              categoryName: 'Photography',
                              categoryImage: '',
                              onTap: () {},
                            ),
                            CategoryContainer(
                              categoryName: 'Baby & Toddler',
                              categoryImage: '',
                              onTap: () {},
                            ),
                          ],
                        ),
                      );
                    } else {
                      return ProductContainer(
                        url:
                            'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
                        storeName: 'Atinuke Store',
                        productName: 'Oraimo Power Bank',
                        productPrice: '12000',
                        distance: '3.5',
                        onProductTapped: () {
                          ref
                              .read(navigationServiceProvider)
                              .navigateToNamed(Routes.productDetails);
                        },
                        onDistanceTapped: () {},
                        onFlipTapped: () {},
                        onFavoriteTapped: () {
                          homeNotifier.toggleFavorite();
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
