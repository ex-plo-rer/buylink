import 'package:buy_link/features/core/models/compare_arg_model.dart';
import 'package:buy_link/features/core/models/product_model.dart';
import 'package:buy_link/features/core/notifiers/compare_notifier.dart';
import 'package:buy_link/features/core/notifiers/compare_notifier.dart';
import 'package:buy_link/features/core/notifiers/home_notifier.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/app_button.dart';
import 'package:buy_link/widgets/circular_progress.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/colors.dart';
import '../../../core/routes.dart';
import '../notifiers/store_notifier/compare_search_notifier.dart';
import '../notifiers/store_notifier/product_search_notifier.dart';

class CompareSearch extends SearchDelegate<String> {
  final WidgetRef ref;

  CompareSearch({
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
    // suggestions = Provider.of<SupplyStoreViewModel>(context).allStudents;
    return [
      if (query.isNotEmpty)
        IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear),
        ),
    ];
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
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
    final compareSearchNotifier = ref.watch(compareSearchNotifierProvider);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: FutureBuilder(
        future: compareSearchNotifier.autoCompleteM(query: query),
        builder: (context, snapshot) {
          return compareSearchNotifier.searchLoading
              ? const CircularProgress()
              : compareSearchNotifier.autoComplete!.result.isEmpty
                  ? const Center(child: Text('No Match'))
                  : Expanded(
                      child: ListView.separated(
                        itemCount:
                            compareSearchNotifier.autoComplete!.result.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            ref
                                .read(navigationServiceProvider)
                                .navigateOffNamed(
                                  Routes.compareProducts,
                                  arguments: compareSearchNotifier
                                      .autoComplete!.result[index],
                                );
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  compareSearchNotifier
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
    final productSearchNotifier = ref.watch(compareSearchNotifierProvider);
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
                                                Routes.compareProducts,
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
                              Routes.compareProducts,
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
}
