import 'package:buy_link/features/core/models/product_model.dart';
import 'package:buy_link/features/core/notifiers/home_notifier.dart';
import 'package:buy_link/widgets/app_button.dart';
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
  final OnSearchChanged onSearchChanged;
  List<String> _oldFilters = [];

  final List<ProductModel> allProducts;
  final List<ProductModel> productsSuggestion;
  final WidgetRef ref;

  ProductSearch({
    required this.allProducts,
    required this.productsSuggestion,
    required this.onSearchChanged,
    required this.ref,
  });

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: AppColors.transparent,
        iconTheme: IconThemeData(color: AppColors.grey5),
      ),
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        hintStyle: theme.textTheme.subtitle1?.copyWith(color: Colors.grey),
        fillColor: Colors.grey[200],
        // filled: true,
        isDense: true,
        // contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        border: InputBorder.none,
        // OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(5),
        //   borderSide: const BorderSide(color: Colors.grey, width: 0),
        // ),
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(5),
        //   borderSide: const BorderSide(color: Colors.grey, width: 0),
        // ),
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
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: FutureBuilder(
        future: productSearchNotifier.autoCompleteM(query: query),
        builder: (context, snapshot) {
          return productSearchNotifier.searchLoading
              ? const CircularProgress()
              : productSearchNotifier.autoComplete!.result.isEmpty
                  ? const Center(child: Text('No Match'))
                  : Expanded(
                      child: ListView.separated(
                        itemCount:
                            productSearchNotifier.autoComplete!.result.length,
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
                  ? Column(
                      children: [
                        if (productSearchNotifier
                            .autoComplete!.recentSearches.isNotEmpty)
                          Expanded(
                            child: ListView.separated(
                              itemCount: productSearchNotifier
                                      .autoComplete!.recentSearches.length +
                                  1,
                              itemBuilder: (context, index) => index == 0
                                  ? const Text('Recently Searched')
                                  : Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            productSearchNotifier.autoComplete!
                                                .recentSearches[index - 1],
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
                              separatorBuilder: (context, index) =>
                                  const Spacing.tinyHeight(),
                            ),
                          ),
                        if (productSearchNotifier
                            .autoComplete!.result.isNotEmpty)
                          Expanded(
                            child: ListView.separated(
                              itemCount: productSearchNotifier
                                      .autoComplete!.result.length +
                                  1,
                              itemBuilder: (context, index) => index == 0
                                  ? const Text('Popular Searches')
                                  : GestureDetector(
                                      onTap: () {
                                        ref
                                            .read(navigationServiceProvider)
                                            .navigateOffNamed(
                                                Routes.productSearch,
                                                arguments: productSearchNotifier
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
                              Icons.north_west_outlined,
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
