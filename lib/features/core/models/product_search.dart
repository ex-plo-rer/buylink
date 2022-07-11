import 'package:buy_link/core/constants/images.dart';
import 'package:buy_link/core/utilities/extensions/strings.dart';
import 'package:buy_link/widgets/app_empty_states.dart';
import 'package:buy_link/widgets/circular_progress.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/colors.dart';
import '../../../core/routes.dart';
import '../../../services/navigation_service.dart';
import '../notifiers/store_notifier/product_search_notifier.dart';

typedef OnSearchChanged = Future<List<String>> Function(String);

class ProductSearch extends SearchDelegate<String> {
  final WidgetRef ref;

  ProductSearch({
    required this.ref,
  });

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      textTheme: theme.textTheme.copyWith(
        headline6: const TextStyle(
          color: AppColors.grey1,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: AppColors.transparent,
        iconTheme: IconThemeData(color: AppColors.grey5),
      ),
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        hintStyle: theme.textTheme.subtitle1?.copyWith(color: Colors.grey),
        fillColor: Colors.grey[200],
        isDense: true,
        border: InputBorder.none,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          onPressed: () {
            query = '';
            print('query: $query');
          },
          icon: const Icon(Icons.clear),
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back_ios_outlined,
        size: 15,
      ),
      onPressed: () => Navigator.pop(context),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final productSearchNotifier = ref.watch(productSearchNotifierProvider);
    return query.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(24.0),
            child: FutureBuilder(
              future: productSearchNotifier.autoCompleteM(query: query),
              builder: (context, snapshot) {
                return productSearchNotifier.searchLoading
                    ? const CircularProgress()
                    : productSearchNotifier.autoComplete!.result.isEmpty
                        ? const Center(
                            child: AppEmptyStates(
                            imageString: AppImages.emptyProduct,
                            message1String: "Oops, no products available",
                            message2String:
                                "Try searching with another keyword ",
                            buttonString: "",
                            hasButton: false,
                          ))
                        : Expanded(
                            child: ListView.separated(
                              itemCount: productSearchNotifier
                                  .autoComplete!.result.length,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  ref
                                      .read(navigationServiceProvider)
                                      .navigateOffNamed(
                                        Routes.productSearch,
                                        arguments: productSearchNotifier
                                            .autoComplete!.result[index],
                                      );
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        productSearchNotifier
                                            .autoComplete!.result[index],
                                        style: const TextStyle(
                                          color: AppColors.grey1,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.north_west_outlined,
                                      color: AppColors.grey5,
                                      size: 15,
                                    ),
                                  ],
                                ),
                              ),
                              separatorBuilder: (context, index) =>
                                  const Spacing.tinyHeight(),
                            ),
                          );
              },
            ),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final productSearchNotifier = ref.watch(productSearchNotifierProvider);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: FutureBuilder(
        future: productSearchNotifier.autoCompleteM(query: query),
        builder: (context, snapshot) {
          return productSearchNotifier.searchLoading
              ? const CircularProgress()
              : query.isEmpty
                  ? StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) =>
                          Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (productSearchNotifier.recentSearches != null &&
                              productSearchNotifier.recentSearches!.isNotEmpty)
                            ListView.separated(
                              shrinkWrap: true,
                              itemCount:
                                  productSearchNotifier.recentSearches!.length +
                                      1,
                              itemBuilder: (context, index) {
                                return index == 0
                                    ? const Text(
                                        'Recently Searched',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: AppColors.grey5),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          ref
                                              .read(navigationServiceProvider)
                                              .navigateOffNamed(
                                                  Routes.productSearch,
                                                  arguments:
                                                      productSearchNotifier
                                                              .recentSearches![
                                                          index - 1]);
                                        },
                                        child: Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    productSearchNotifier
                                                            .recentSearches![
                                                        index - 1],
                                                    style: const TextStyle(
                                                      color: AppColors.grey1,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    productSearchNotifier
                                                        .removeRecent(
                                                            index - 1);
                                                    setState(() {});
                                                  },
                                                  child: const Icon(
                                                    Icons.clear,
                                                    color: AppColors.grey5,
                                                    size: 15,
                                                  ),
                                                ),
                                              ],
                                            )),
                                      );
                              },
                              separatorBuilder: (context, index) =>
                                  const Spacing.tinyHeight(),
                            ),
                          if (productSearchNotifier.recentSearches != null &&
                              productSearchNotifier.recentSearches!.isNotEmpty)
                            const Spacing.mediumHeight(),
                          if (productSearchNotifier.recentSearches != null &&
                              productSearchNotifier.recentSearches!.isNotEmpty)
                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  productSearchNotifier.clearRecent();
                                  setState(() {});
                                },
                                child: Container(
                                  //width: 60,
                                  // height: 20,
                                  padding: const EdgeInsets.all(4.0),
                                  child: const Text(
                                    "Clear all",
                                    style: TextStyle(
                                      color: AppColors.grey5,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: AppColors.grey5),
                                  ),
                                ),
                              ),
                            ),
                          if (productSearchNotifier.recentSearches != null &&
                              productSearchNotifier.recentSearches!.isNotEmpty)
                            const Spacing.smallHeight(),
                          if (productSearchNotifier
                              .autoComplete!.result.isNotEmpty)
                            Expanded(
                              child: ListView.separated(
                                itemCount: productSearchNotifier
                                        .autoComplete!.result.length +
                                    1,
                                itemBuilder: (context, index) => index == 0
                                    ? const Text(
                                        'Popular Searches',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: AppColors.grey5),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          ref
                                              .read(navigationServiceProvider)
                                              .navigateOffNamed(
                                                  Routes.productSearch,
                                                  arguments:
                                                      productSearchNotifier
                                                          .autoComplete!
                                                          .result[index - 1]);
                                        },
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                productSearchNotifier
                                                    .autoComplete!
                                                    .result[index - 1],
                                                style: const TextStyle(
                                                  color: AppColors.grey1,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            const Icon(
                                              Icons.north_west_outlined,
                                              color: AppColors.grey5,
                                              size: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                separatorBuilder: (context, index) =>
                                    const Spacing.tinyHeight(),
                              ),
                            ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      itemCount:
                          productSearchNotifier.autoComplete!.result.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          ref.read(navigationServiceProvider).navigateOffNamed(
                              Routes.productSearch,
                              arguments: productSearchNotifier
                                  .autoComplete!.result[index]);
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                productSearchNotifier
                                    .autoComplete!.result[index],
                                style: const TextStyle(
                                  color: AppColors.grey1,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.clear,
                              color: AppColors.grey5,
                              size: 15,
                            ),
                          ],
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          const Spacing.tinyHeight(),
                    );
        },
      ),
    );
  }

// @override
// Widget buildSuggestions(BuildContext context) {
//   return Padding(
//     padding: const EdgeInsets.all(24.0),
//     child: FutureBuilder(
//       future:
//           ref.read(productSearchNotifierProvider).autoCompleteM(query: query),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           _oldFilters = snapshot.data as List<String>;
//           print('_oldFilters: $_oldFilters');
//           return ref.watch(productSearchNotifierProvider).searchLoading
//               ? const CircularProgress()
//               : _oldFilters.isEmpty
//                   ? const Center(
//                       child: Text('No match'),
//                     )
//                   : ListView.separated(
//                       itemCount: _oldFilters.length,
//                       itemBuilder: (context, index) => Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             _oldFilters[index],
//                             style: const TextStyle(
//                               color: AppColors.grey1,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           const Icon(
//                             Icons.north_west_outlined,
//                             color: AppColors.grey5,
//                             size: 15,
//                           ),
//                         ],
//                       ),
//                       separatorBuilder: (context, index) =>
//                           const Spacing.tinyHeight(),
//                     );
//         } else if (snapshot.hasError) {
//           return const Text('No text');
//         } else {
//           return const CircularProgress();
//         }
//       },
//     ),
//   );
// }
}
