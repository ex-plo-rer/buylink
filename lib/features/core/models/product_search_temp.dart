import 'package:buy_link/features/core/models/product_model.dart';
import 'package:buy_link/features/core/notifiers/home_notifier.dart';
import 'package:buy_link/widgets/app_button.dart';
import 'package:buy_link/widgets/circular_progress.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/colors.dart';
import '../../../core/routes.dart';
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
/*      // backgroundColor: AppColors.light,
      // primaryColor: Colors.white,
      // primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.green),
      // textTheme: theme.textTheme.copyWith(
      //   subtitle1: const TextStyle(
      //     fontWeight: FontWeight.w500,
      //     fontSize: 14,
      //   ),
      // ),*/
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
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
    );
  }

  // @override
  // void showResults(BuildContext context) {
  //   close(context, query);
  // }

  @override
  Widget buildResults(BuildContext context) {
    //TODO: Move the calls here out of the homeNotifierProver...
    return FutureBuilder(
      future:
          ref.read(productSearchNotifierProvider).autoCompleteM(query: query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _oldFilters = snapshot.data as List<String>;
          print('_oldFilters: ${_oldFilters}');
          return ListView.separated(
            itemCount: _oldFilters.length,
            itemBuilder: (context, index) => Text(_oldFilters[index]),
            separatorBuilder: (context, index) => const Spacing.tinyHeight(),
          );
        } else if (snapshot.hasError) {
          return Container(
            child: Text('No text'),
          );
        } else {
          return CircularProgress();
        }
      },
    );
    // final List<ProductModel> products = allProducts
    //     .where((product) =>
    //         product.name.toLowerCase().contains(query.toLowerCase()))
    //     .toList();
    //
    // return ListView.builder(
    //   itemBuilder: (context, index) => ListTile(
    //     onTap: () {
    //       Navigator.pushReplacementNamed(
    //         context,
    //         Routes.productDetails,
    //         arguments: products[index],
    //       );
    //       print('Search item was tapped...');
    //       // showResults(context);
    //     },
    //     title: Text(products[index].name),
    //   ),
    //   itemCount: products.length,
    // );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future:
          ref.read(productSearchNotifierProvider).autoCompleteM(query: query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _oldFilters = snapshot.data as List<String>;
          print('_oldFilters: ${_oldFilters}');
          return ListView.separated(
            itemCount: _oldFilters.length,
            itemBuilder: (context, index) => Text(_oldFilters[index]),
            separatorBuilder: (context, index) => const Spacing.tinyHeight(),
          );
        } else if (snapshot.hasError) {
          return Container(
            child: Text('No text'),
          );
        } else {
          return CircularProgress();
        }
      },
    );
  }

/*  @override
  Widget buildSuggestions(BuildContext context) {
    final List<ProductModel> productsSuggestions = productsSuggestion
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return
        // query.isNotEmpty
        //   ? Padding(
        //       padding: const EdgeInsets.all(24.0),
        //       child: ListView.separated(
        //         shrinkWrap: true,
        //         itemBuilder: (context, index) => Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Text(
        //               productsSuggestions[index].name,
        //               style: const TextStyle(
        //                 color: AppColors.grey1,
        //                 fontSize: 14,
        //                 fontWeight: FontWeight.w500,
        //               ),
        //             ),
        //             const Icon(
        //               Icons.north_west_outlined,
        //               color: AppColors.grey5,
        //               size: 15,
        //             ),
        //           ],
        //         ),
        //         //     ListTile(
        //         //   onTap: () {
        //         //     Navigator.pushReplacementNamed(
        //         //       context,
        //         //       Routes.productDetails,
        //         //       arguments: productsSuggestions[index],
        //         //     );
        //         //     print('Search item was tapped...');
        //         //     // showResults(context);
        //         //   },
        //         //   // leading: IconButton(
        //         //   //   icon: Image.network(productsSuggestions[index].image),
        //         //   //   onPressed: () {},
        //         //   // ),
        //         //   title: Text(productsSuggestions[index].name),
        //         // ),
        //         itemCount: productsSuggestions.length,
        //         separatorBuilder: (BuildContext context, int index) =>
        //             const Spacing.smallHeight(),
        //       ),
        //     )
        //   :
        FutureBuilder<List<String>>(
      future: onSearchChanged != null ? onSearchChanged(query) : null,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print('snapshot.data! ${snapshot.data!}');
          _oldFilters = snapshot.data!;
        }
        return ListView.builder(
          itemCount: _oldFilters.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.restore),
              title: Text("${_oldFilters[index]}"),
              onTap: () => close(
                context,
                _oldFilters[index],
              ),
            );
          },
        );
      },
    );
  }*/
/*
    // Do this if query is not empty
    Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recently Searched',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.grey5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacing.smallHeight(),
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        productsSuggestions[index].name,
                        style: const TextStyle(
                          color: AppColors.grey1,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Icon(
                        Icons.close,
                        color: AppColors.grey5,
                        size: 15,
                      ),
                    ],
                  ),
                  //     ListTile(
                  //   onTap: () {
                  //     Navigator.pushReplacementNamed(
                  //       context,
                  //       Routes.productDetails,
                  //       arguments: productsSuggestions[index],
                  //     );
                  //     print('Search item was tapped...');
                  //     // showResults(context);
                  //   },
                  //   // leading: IconButton(
                  //   //   icon: Image.network(productsSuggestions[index].image),
                  //   //   onPressed: () {},
                  //   // ),
                  //   title: Text(productsSuggestions[index].name),
                  // ),
                  itemCount: 4,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Spacing.smallHeight(),
                ),
                const Spacing.smallHeight(),
                const Align(
                  alignment: Alignment.bottomRight,
                  child: AppButton(
                    text: 'Clear all',
                    borderColor: AppColors.grey5,
                    textColor: AppColors.grey5,
                    width: null,
                    height: 22,
                  ),
                ),
                const Text(
                  'Recently Searched',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.grey5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacing.smallHeight(),
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        productsSuggestions[index].name,
                        style: const TextStyle(
                          color: AppColors.grey1,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Icon(
                        Icons.north_west_outlined,
                        color: AppColors.grey5,
                        size: 15,
                      ),
                    ],
                  ),
                  //     ListTile(
                  //   onTap: () {
                  //     Navigator.pushReplacementNamed(
                  //       context,
                  //       Routes.productDetails,
                  //       arguments: productsSuggestions[index],
                  //     );
                  //     print('Search item was tapped...');
                  //     // showResults(context);
                  //   },
                  //   // leading: IconButton(
                  //   //   icon: Image.network(productsSuggestions[index].image),
                  //   //   onPressed: () {},
                  //   // ),
                  //   title: Text(productsSuggestions[index].name),
                  // ),
                  itemCount: 4,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Spacing.smallHeight(),
                ),
                const Spacing.smallHeight(),
              ],
            ),
          );*/
}
