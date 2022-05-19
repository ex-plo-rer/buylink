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

class CompareView extends ConsumerStatefulWidget {
  CompareView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  bool haveProductToCompare = false;
  final CompareArgModel arguments;

  @override
  ConsumerState<CompareView> createState() => _CompareViewState();
}

class _CompareViewState extends ConsumerState<CompareView> {
  // final compareNotifier = ref.read(compareNotifierProvider(widget.arguments.product!));

  final searchFN = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    print('Compare view init state called');
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ref
          .read(compareNotifierProvider)
          .saveProduct(product: widget.arguments.product!);
    });
    super.initState();
  }

  @override
  void dispose() {
    searchFN.dispose();
    super.dispose();
  }

  Future<void> init() async {
    // compareNotifier = ref.read(compareNotifierProvider(widget.arguments.product!));
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    final compareNotifier = ref.watch(compareNotifierProvider);
    // compareNotifier.saveProduct(product: widget.arguments.product!);
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
                hasPrefixIcon: true,
              ),
              const Spacing.height(12),
              Expanded(
                child: SingleChildScrollView(
                  child: compareNotifier.product1 == null
                      ? const CircularProgress()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 6.0),
                                    child: ProductImageContainer(
                                      product: compareNotifier.product1!,
                                      activeIndex: compareNotifier.activeIndex,
                                      onPageChanged: compareNotifier.nextPage,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 6.0),
                                    // TODO: Check if there is a product to compare with.
                                    child: compareNotifier.product2 != null
                                        ? ProductImageContainer(
                                            product: compareNotifier.product2!,
                                            activeIndex:
                                                compareNotifier.activeIndex,
                                            onPageChanged:
                                                compareNotifier.nextPage,
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
                              subTitle1: compareNotifier.product1!.name,
                              subTitle2: compareNotifier.product2?.name ?? '',
                              haveProductToCompare:
                                  compareNotifier.product2 != null,
                            ),
                            CompareTexts2(
                              title: 'Price',
                              subTitle1:
                                  compareNotifier.product1!.price.toString(),
                              subTitle2:
                                  compareNotifier.product2?.price.toString() ??
                                      '',
                              haveProductToCompare:
                                  compareNotifier.product2 != null,
                            ),
                            CompareTexts2(
                              title: 'Distance',
                              subTitle1:
                                  '${ref.read(locationService).getDistance(
                                        storeLat:
                                            compareNotifier.product1!.store.lat,
                                        storeLon:
                                            compareNotifier.product1!.store.lon,
                                      )}km',
                              subTitle2:
                                  '${ref.read(locationService).getDistance(
                                        storeLat: compareNotifier
                                                .product2?.store.lat ??
                                            0,
                                        storeLon: compareNotifier
                                                .product2?.store.lon ??
                                            0,
                                      )}km',
                              haveProductToCompare:
                                  compareNotifier.product2 != null,
                            ),
                            CompareTexts2(
                              title: 'Care',
                              subTitle1: compareNotifier.product1!.care,
                              subTitle2: compareNotifier.product2?.care ?? '',
                              haveProductToCompare:
                                  compareNotifier.product2 != null,
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
