import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/constants/images.dart';
import 'package:buy_link/core/constants/svgs.dart';
import 'package:buy_link/features/core/notifiers/home_notifier.dart';
import 'package:buy_link/widgets/app_button.dart';
import 'package:buy_link/widgets/app_text_field.dart';
import 'package:buy_link/widgets/category_container.dart';
import 'package:buy_link/widgets/distance_container.dart';
import 'package:buy_link/widgets/favorite_container.dart';
import 'package:buy_link/widgets/product_container.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductDetailsView extends ConsumerWidget {
  const ProductDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final homeNotifier = ref.watch(homeNotifierProvider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 427,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                  color: AppColors.grey1,
                ),
              ),
              const SizedBox(
                child: Divider(
                  thickness: 2,
                  color: AppColors.grey1,
                ),
                width: 50,
              ),
              const ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.grey1,
                ),
                title: Text('Atinuke Stores'),
                subtitle: Text('* 4.5'),
                trailing: DistanceContainer(
                  distance: '2.3',
                  containerColor: AppColors.grey2,
                  textColor: AppColors.light,
                  iconColor: AppColors.light,
                ),
              ),
              const Text(
                'Levi Jean Trouser',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.grey1,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    '#3,000 ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey1,
                    ),
                  ),
                  Text(
                    '#5,000',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey4,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
              const Spacing.height(20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'A super-comfortable denim legging,built to contour curves, lengthen legs and celebrate your form. Made with an innovative tummy-sliming',
                  // textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey2,
                  ),
                ),
              ),
              const Spacing.bigHeight(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  // mainAxisSize: MainAxisSize.max,
                  children: [
                    const Expanded(
                      flex: 5,
                      child: AppButton(
                        text: 'Locate Store',
                        hasIcon: true,
                        backgroundColor: AppColors.primaryColor,
                        textColor: AppColors.light,
                        icon: Icon(Icons.storage),
                      ),
                    ),
                    const Spacing.smallWidth(),
                    Expanded(
                      child: FavoriteContainer(
                        height: 56,
                        width: 56,
                        favIcon: SvgPicture.asset(AppSvgs.favorite),
                        containerColor: AppColors.grey10,
                        radius: 10,
                        padding: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacing.bigHeight(),
              const Divider(thickness: 2),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Product Details',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey1,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 12,
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 2),
              const Spacing.bigHeight(),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Similar Products',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey1,
                    ),
                  ),
                ),
              ),
              const Spacing.height(20),
              SizedBox(
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: MasonryGridView.count(
                    itemCount: 20,
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 15,
                    itemBuilder: (context, index) {
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
                          homeNotifier.toggleFavorite();
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
