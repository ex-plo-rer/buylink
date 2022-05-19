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
    final List<ProductModel> products = ref
        .read(homeNotifierProvider(''))
        .products
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          // Navigator.pushReplacementNamed(
          //   context,
          //   Routes.compare,
          //   arguments: CompareArgModel(
          //     product: products[index],
          //     fromSearch: true,
          //   ),
          // );
          ref
              .read(compareNotifierProvider)
              .saveProduct(product: products[index]);
          ref.read(navigationServiceProvider).navigateBack();
          print('Search item was tapped...');
          // showResults(context);
        },
        // leading: IconButton(
        //   icon: Image.network(products[index].image),
        //   onPressed: () {},
        // ),
        title: Text(products[index].name),
      ),
      itemCount: products.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<ProductModel> productsSuggestions = ref
        .read(homeNotifierProvider(''))
        .products
        .where(
          (product) => product.name.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          // Navigator.pushReplacementNamed(
          //   context,
          //   Routes.compare,
          //   arguments: CompareArgModel(
          //     product: productsSuggestions[index],
          //     fromSearch: true,
          //   ),
          // );
          ref
              .read(compareNotifierProvider)
              .saveProduct(product: productsSuggestions[index]);
          ref.read(navigationServiceProvider).navigateBack();
          print('Search item was tapped...');
          // showResults(context);
        },
        // leading: IconButton(
        //   icon: Image.network(productsSuggestions[index].image),
        //   onPressed: () {},
        // ),
        title: Text(productsSuggestions[index].name),
      ),
      itemCount: productsSuggestions.length,
    );
  }
}
