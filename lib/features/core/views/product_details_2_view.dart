import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/constants/svgs.dart';
import 'package:buy_link/core/routes.dart';
import 'package:buy_link/core/utilities/loader.dart';
import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/features/core/models/compare_arg_model.dart';
import 'package:buy_link/features/core/models/edit_product_arg_model.dart';
import 'package:buy_link/features/core/models/product_model.dart';
import 'package:buy_link/features/core/notifiers/home_notifier.dart';
import 'package:buy_link/features/core/notifiers/product_list_notifier.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/app_button.dart';
import 'package:buy_link/widgets/back_arrow.dart';
import 'package:buy_link/widgets/circular_progress.dart';
import 'package:buy_link/widgets/distance_container.dart';
import 'package:buy_link/widgets/expandable_text.dart';
import 'package:buy_link/widgets/favorite_container.dart';
import 'package:buy_link/widgets/iconNtext_container.dart';
import 'package:buy_link/widgets/product_container.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../services/location_service.dart';
import '../../../widgets/app_dialog.dart';
import '../notifiers/flip_notifier.dart';
import '../notifiers/product_details_2_notifier.dart';
import '../notifiers/product_details_notifier.dart';
import '../notifiers/wishlist_notifier.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class ProductDetails2View extends ConsumerStatefulWidget {
  const ProductDetails2View({
    Key? key,
    required this.product,
  }) : super(key: key);
  final ProductModel product;

  @override
  ConsumerState<ProductDetails2View> createState() =>
      _ProductDetails2ViewState();
}

class _ProductDetails2ViewState extends ConsumerState<ProductDetails2View> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    final loader = Loader(context);
    final productDetails2Notifier = ref.watch(productDetails2NotifierProvider);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.dark,
        ),
        leading: IconButton(
          onPressed: () {
            ref.read(navigationServiceProvider).navigateBack();
          },
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            size: 14,
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.transparent,
        title: const Text(
          'Product Details',
          style: TextStyle(
            color: AppColors.dark,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_horiz_outlined),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () async {
                  WidgetsBinding.instance
                      .addPostFrameCallback((timeStamp) async {
                    loader.showLoader(text: '');
                    await productDetails2Notifier.loadEdit(
                        productId: widget.product.id);
                    if (productDetails2Notifier.productToEdit != null) {
                      ref.read(navigationServiceProvider).navigateBack();
                      ref.read(navigationServiceProvider).navigateToNamed(
                            Routes.editProduct,
                            arguments: EditProductArgModel(
                              store: widget.product.store,
                              product: productDetails2Notifier.productToEdit!,
                            ),
                          );
                    } else {
                      ref.read(navigationServiceProvider).navigateBack();
                    }
                  });
                },
                child: const Text(
                  'Edit Product',
                  style: TextStyle(
                    color: AppColors.grey2,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                value: 1,
              ),
              PopupMenuItem(
                onTap: () {
                  WidgetsBinding.instance
                      .addPostFrameCallback((timeStamp) async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) => AppDialog(
                        title: 'Are you sure you want to delete the product?',
                        text1: 'No',
                        text2: 'Yes',
                        onText1Pressed: () =>
                            ref.read(navigationServiceProvider).navigateBack(),
                        onText2Pressed: () async {
                          ref.read(navigationServiceProvider).navigateBack();
                          loader.showLoader(text: '');
                          await productDetails2Notifier.deleteProduct(
                              productId: widget.product.id);
                          if (productDetails2Notifier.deleted) {
                            await ref
                                .read(productListNotifierProvider)
                                .fetchStoreProducts(
                                  storeId: widget.product.store.id,
                                  category: 'all',
                                );
                            ref.read(navigationServiceProvider).navigateBack();
                            ref.read(navigationServiceProvider).navigateBack();
                          } else {
                            ref.read(navigationServiceProvider).navigateBack();
                          }
                        },
                      ),
                    );
                  });
                },
                child: const Text(
                  'Delete Product',
                  style: TextStyle(
                    color: AppColors.grey2,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                value: 2,
              )
            ],
          ),
          const Spacing.mediumWidth(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Container(
                height: 340,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.grey1,
                ),
                child: CarouselSlider.builder(
                  itemCount: widget.product.image.length,
                  options: CarouselOptions(
                    height: 447,
                    autoPlay: true,
                    disableCenter: true,
                    viewportFraction: 1,
                    aspectRatio: 0,
                    onPageChanged: productDetails2Notifier.nextPage,
                  ),
                  itemBuilder: (context, index, realIndex) {
                    final urlImage = widget.product.image[index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(urlImage),
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Spacing.mediumHeight(),
              AnimatedSmoothIndicator(
                count: widget.product.image.length,
                activeIndex: productDetails2Notifier.activeIndex,
                effect: const ExpandingDotsEffect(
                  dotHeight: 4,
                  dotWidth: 4,
                ),
              ),
              const Spacing.mediumHeight(),
              Text(
                widget.product.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.grey1,
                ),
              ),
              RichText(
                // overflow: TextOverflow.clip(isDetails ? null : TextOverflow.ellipsis,),
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      style: const TextStyle(
                        color: AppColors.grey1,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      child: SvgPicture.asset(
                        AppSvgs.naira,
                        height: 15,
                        width: 15,
                      ),
                    ),
                    TextSpan(
                      text: '${widget.product.price}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey1,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacing.height(20),
              ExpandableText(
                text: widget.product.desc,
                // text: 'A super-comfortable denim legging,built to contour curves, lengthen legs and celebrate your qwew ewewe dsfsfsd fwsfddwfwefd asfdsffsd wef',
                trimLines: 2,
              ),
              const Spacing.bigHeight(),
              const Divider(thickness: 2),
              GestureDetector(
                onTap: () {
                  productDetails2Notifier.fetchProductAttr(
                      productId: widget.product.id);
                  ref
                      .read(navigationServiceProvider)
                      .navigateToNamed(Routes.productDetails2More);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    // horizontal: 20.0,
                    vertical: 5,
                  ),
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
              ),
              const Divider(thickness: 2),
            ],
          ),
        ),
      ),
    );
  }
}
