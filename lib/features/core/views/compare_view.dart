import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/features/core/models/compare_arg_model.dart';
import 'package:buy_link/features/core/models/product_model.dart';
import 'package:buy_link/repositories/core_repository.dart';
import 'package:buy_link/services/location_service.dart';
import 'package:buy_link/widgets/app_text_field.dart';
import 'package:buy_link/widgets/compare_texts_2.dart';
import 'package:buy_link/widgets/product_image_container.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/strings.dart';
import '../../../widgets/circular_progress.dart';
import '../models/compare_search.dart';
import '../notifiers/compare_notifier.dart';
import '../notifiers/store_notifier/compare_search_notifier.dart';

class CompareView extends ConsumerStatefulWidget {
  CompareView({
    Key? key,
    // required this.arguments,
  }) : super(key: key);

  // bool haveProductToCompare = false;
  // final CompareArgModel arguments;

  @override
  ConsumerState<CompareView> createState() => _CompareViewState();
}

class _CompareViewState extends ConsumerState<CompareView> {
  final searchFN = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    print('Compare view init state called');
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // ref
      //     .read(compareSearchNotifierProvider)
      //     .saveProduct(product: widget.arguments.product!);
      init();
    });
    super.initState();
  }

  @override
  void dispose() {
    searchFN.dispose();
    super.dispose();
  }

  Future<void> init() async {
    // compareSearchNotifier = ref.read(compareSearchNotifierProvider(widget.arguments.product!));
    ref.watch(compareSearchNotifierProvider).fetchItemsToCompare();
  }

  @override
  Widget build(BuildContext context) {
    final compareNotifier = ref.watch(compareNotifierProvider);
    final compareSearchNotifier = ref.watch(compareSearchNotifierProvider);
    // compareSearchNotifier.saveProduct(product: widget.arguments.product!);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.dark, //change your color here
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios_outlined, color: AppColors.grey2, size: 15
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            // vertical: 16,
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                style: TextStyle(color: AppColors.grey1, fontSize: 20, fontWeight: FontWeight.w500),
                hintText: 'Search for another product to compare',
                onTap: () async {
                  searchFN.unfocus();
                  await showSearch(
                    context: context,
                    delegate: CompareSearch(
                      ref: ref,
                    ),
                  );
                  searchFN.unfocus();
                  // if (searchText != null) {
                  //   await homeNotifier.saveToRecentSearches(searchText);
                  // }
                },
                prefixIcon: const Icon(Icons.search_outlined),
                hasBorder: false,
                focusNode: searchFN,
                isSearch: true,
                fillColor: AppColors.grey8,
              ),
              const Spacing.height(12),
              Expanded(
                child: SingleChildScrollView(
                  child: compareSearchNotifier.itemsToCompareLoading
                      ? const CircularProgress()
                      : compareSearchNotifier.itemsToCompare.isEmpty
                          ? const Center(
                              child: Text('An error occurred!!!'),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 6.0),
                                        child: ProductImageContainer(
                                          product: compareSearchNotifier
                                              .itemsToCompare[0],
                                          activeIndex:
                                              compareSearchNotifier.activeIndex,
                                          onPageChanged:
                                              compareSearchNotifier.nextPage,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 6.0),
                                        // TODO: Check if there is a product to compare with.
                                        child: compareSearchNotifier
                                                .haveProductToCompare
                                            ? ProductImageContainer(
                                                product: compareSearchNotifier
                                                    .itemsToCompare[1],
                                                activeIndex:
                                                    compareSearchNotifier
                                                        .activeIndex,
                                                onPageChanged:
                                                    compareSearchNotifier
                                                        .nextPage,
                                              )
                                            : const SizedBox(
                                                height: 160,
                                                child: Center(
                                                  child: Text(
                                                    'Search to add another product to compare',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacing.bigHeight(),
                                CompareTexts2(
                                  title: 'Name',
                                  subTitle1: compareSearchNotifier
                                      .itemsToCompare[0].name,
                                  subTitle2:
                                      compareSearchNotifier.haveProductToCompare
                                          ? compareSearchNotifier
                                              .itemsToCompare[1].name
                                          : '',
                                  haveProductToCompare: compareSearchNotifier
                                      .haveProductToCompare,
                                ),
                                CompareTexts2(
                                  title: 'Price',
                                  subTitle1: compareSearchNotifier
                                      .itemsToCompare[0].price
                                      .toString(),
                                  subTitle2:
                                      compareSearchNotifier.haveProductToCompare
                                          ? compareSearchNotifier
                                              .itemsToCompare[1].price
                                              .toString()
                                          : '',
                                  haveProductToCompare: compareSearchNotifier
                                      .haveProductToCompare,
                                ),
                                CompareTexts2(
                                  title: 'Distance',
                                  subTitle1:
                                      '${ref.read(locationService).getDistance(
                                            endLat: compareSearchNotifier
                                                .itemsToCompare[0].store.lat,
                                            endLon: compareSearchNotifier
                                                .itemsToCompare[0].store.lon,
                                          )}km',
                                  subTitle2:
                                      '${ref.read(locationService).getDistance(
                                            endLat: compareSearchNotifier
                                                    .haveProductToCompare
                                                ? compareSearchNotifier
                                                    .itemsToCompare[1].store.lat
                                                : 0,
                                            endLon: compareSearchNotifier
                                                    .haveProductToCompare
                                                ? compareSearchNotifier
                                                    .itemsToCompare[1].store.lon
                                                : 0,
                                          )}km',
                                  haveProductToCompare: compareSearchNotifier
                                      .haveProductToCompare,
                                ),
                                CompareTexts2(
                                  title: 'Care',
                                  subTitle1: compareSearchNotifier
                                      .itemsToCompare[0].care,
                                  subTitle2:
                                      compareSearchNotifier.haveProductToCompare
                                          ? compareSearchNotifier
                                              .itemsToCompare[1].care
                                          : '',
                                  haveProductToCompare: compareSearchNotifier
                                      .haveProductToCompare,
                                ),
                              ],
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

// Expanded(
//   child: SingleChildScrollView(
//     child: Row(
//       mainAxisSize: MainAxisSize.max,
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.only(right: 6.0),
//                 child: ProductImageContainer(
//                   productImage: 'productImage',
//                 ),
//               ),
//               const Spacing.bigHeight(),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Text(
//                     'Name',
//                     style: TextStyle(
//                       color: AppColors.primaryColor,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   Spacing.tinyHeight(),
//                   Text(
//                     'Levi Jean Trousers',
//                     style: TextStyle(
//                       color: AppColors.grey1,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//               const Divider(thickness: 2)
//             ],
//           ),
//         ),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.only(left: 6.0),
//                 child: ProductImageContainer(
//                   productImage: 'productImage',
//                 ),
//               ),
//               const Spacing.bigHeight(),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Padding(
//                     padding: EdgeInsets.only(left: 6.0),
//                     child: Text(
//                       '',
//                       style: TextStyle(
//                         color: AppColors.primaryColor,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   Spacing.tinyHeight(),
//                   Padding(
//                     padding: EdgeInsets.only(left: 6.0),
//                     child: Text(
//                       'Levi Jean Trousers',
//                       style: TextStyle(
//                         color: AppColors.grey1,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const Divider(thickness: 2)
//             ],
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
