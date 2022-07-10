import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/constants/images.dart';
import 'package:buy_link/core/constants/svgs.dart';
import 'package:buy_link/features/core/models/product_model.dart';
import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/widgets/product_no_of_searches.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../widgets/circular_progress.dart';
import '../../../../widgets/favorite_container.dart';
import '../../../../widgets/weekly_widget.dart';
import '../../models/product_model.dart';
import '../../notifiers/product_searched_notifier.dart';
import '../../notifiers/store_notifier/product_saved_notifier.dart';
import '../../notifiers/store_notifier/store_dashboard_notifier.dart';

class ProductSavedView extends ConsumerStatefulWidget {
  final Store store;

  const ProductSavedView({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  ConsumerState<ProductSavedView> createState() => _ProductSavedViewState();
}

class _ProductSavedViewState extends ConsumerState<ProductSavedView> {
  String dropdownValue = 'This Week';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(productSavedNotifierProvider)
          .fetchWeeklyData(storeId: widget.store.id, week: 'current');
    });
  }

  @override
  Widget build(BuildContext context) {
    final productSavedNotifier = ref.watch(productSavedNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.dark, //change your color here
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            size: 12,
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.transparent,
        title: Text(
          widget.store.name,
          style: const TextStyle(
            color: AppColors.dark,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              horizontalTitleGap: 0,
              dense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              leading: FavoriteContainer(
                height: 28,
                width: 28,
                padding: 5,
                favIcon: SvgPicture.asset(AppSvgs.favorite),
                containerColor: AppColors.shade1,
              ),
              title: const Text(
                'Product Saved',
                style: TextStyle(
                  color: AppColors.grey4,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                '${ref.watch(storeDashboardNotifierProvider).searchAnalytics?.total ?? 0}',
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              trailing: Container(
                height: 32,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.primaryColor,
                  ),
                  color: AppColors.light,
                ),
                child: DropdownButton<String>(
                  value: productSavedNotifier.dropdownValue,
                  icon: const Icon(Icons.arrow_drop_down),
                  elevation: 16,
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                  iconSize: 16,
                  onChanged: (newValue) =>
                      productSavedNotifier.onDropDownChanged(
                    newValue: newValue!,
                    storeId: widget.store.id,
                  ),
                  underline: const SizedBox(),
                  items: <String>[
                    'This Week',
                    'Last week',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            const Spacing.height(20),
            productSavedNotifier.state.isLoading
                ? const CircularProgress()
                : productSavedNotifier.state.isError
                    ? const Center(child: Text('An error occurred'))
                    : productSavedNotifier.weeklyData == null
                        ? const Center(child: Text('Something went wrong'))
                        : Expanded(
                            child: ListView(
                              physics: const ScrollPhysics(),
                              // shrinkWrap: true,
                              children: [
                                WeeklyWidget(
                                  category: 'Sunday',
                                  itemCount: productSavedNotifier
                                          .weeklyData!.sunday.isEmpty
                                      ? 1
                                      : productSavedNotifier
                                          .weeklyData!.sunday.length,
                                  itemBuilder: (context, index) {
                                    return productSavedNotifier
                                            .weeklyData!.sunday.isEmpty
                                        ? const Spacing.empty()
                                        : ProductCount(
                                            productImage: productSavedNotifier
                                                .weeklyData!
                                                .sunday[index]
                                                .image,
                                            productName: productSavedNotifier
                                                .weeklyData!.sunday[index].name,
                                            productNum: productSavedNotifier
                                                .weeklyData!
                                                .sunday[index]
                                                .searches,
                                            type: '',
                                          );
                                  },
                                ),
                                const Spacing.height(20),
                                WeeklyWidget(
                                  category: 'Monday',
                                  itemCount: productSavedNotifier
                                          .weeklyData!.monday.isEmpty
                                      ? 1
                                      : productSavedNotifier
                                          .weeklyData!.monday.length,
                                  itemBuilder: (context, index) {
                                    return productSavedNotifier
                                            .weeklyData!.monday.isEmpty
                                        ? const Spacing.empty()
                                        : ProductCount(
                                            productImage: productSavedNotifier
                                                .weeklyData!
                                                .monday[index]
                                                .image,
                                            productName: productSavedNotifier
                                                .weeklyData!.monday[index].name,
                                            productNum: productSavedNotifier
                                                .weeklyData!
                                                .monday[index]
                                                .searches,
                                            type: '',
                                          );
                                  },
                                ),
                                const Spacing.height(20),
                                WeeklyWidget(
                                  category: 'Tuesday',
                                  itemCount: productSavedNotifier
                                          .weeklyData!.tuesday.isEmpty
                                      ? 1
                                      : productSavedNotifier
                                          .weeklyData!.tuesday.length,
                                  itemBuilder: (context, index) {
                                    return productSavedNotifier
                                            .weeklyData!.tuesday.isEmpty
                                        ? const Spacing.empty()
                                        : ProductCount(
                                            productImage: productSavedNotifier
                                                .weeklyData!
                                                .tuesday[index]
                                                .image,
                                            productName: productSavedNotifier
                                                .weeklyData!
                                                .tuesday[index]
                                                .name,
                                            productNum: productSavedNotifier
                                                .weeklyData!
                                                .tuesday[index]
                                                .searches,
                                            type: '',
                                          );
                                  },
                                ),
                                const Spacing.height(20),
                                WeeklyWidget(
                                  category: 'Wednesday',
                                  itemCount: productSavedNotifier
                                          .weeklyData!.wednesday.isEmpty
                                      ? 1
                                      : productSavedNotifier
                                          .weeklyData!.wednesday.length,
                                  itemBuilder: (context, index) {
                                    return productSavedNotifier
                                            .weeklyData!.wednesday.isEmpty
                                        ? const Spacing.empty()
                                        : ProductCount(
                                            productImage: productSavedNotifier
                                                .weeklyData!
                                                .wednesday[index]
                                                .image,
                                            productName: productSavedNotifier
                                                .weeklyData!
                                                .wednesday[index]
                                                .name,
                                            productNum: productSavedNotifier
                                                .weeklyData!
                                                .wednesday[index]
                                                .searches,
                                            type: '',
                                          );
                                  },
                                ),
                                const Spacing.height(20),
                                WeeklyWidget(
                                  category: 'Thursday',
                                  itemCount: productSavedNotifier
                                          .weeklyData!.thursday.isEmpty
                                      ? 1
                                      : productSavedNotifier
                                          .weeklyData!.thursday.length,
                                  itemBuilder: (context, index) {
                                    return productSavedNotifier
                                            .weeklyData!.thursday.isEmpty
                                        ? const Spacing.empty()
                                        : ProductCount(
                                            productImage: productSavedNotifier
                                                .weeklyData!
                                                .thursday[index]
                                                .image,
                                            productName: productSavedNotifier
                                                .weeklyData!
                                                .thursday[index]
                                                .name,
                                            productNum: productSavedNotifier
                                                .weeklyData!
                                                .thursday[index]
                                                .searches,
                                            type: '',
                                          );
                                  },
                                ),
                                WeeklyWidget(
                                  category: 'Friday',
                                  itemCount: productSavedNotifier
                                          .weeklyData!.friday.isEmpty
                                      ? 1
                                      : productSavedNotifier
                                          .weeklyData!.friday.length,
                                  itemBuilder: (context, index) {
                                    return productSavedNotifier
                                            .weeklyData!.friday.isEmpty
                                        ? const Spacing.empty()
                                        : ProductCount(
                                            productImage: productSavedNotifier
                                                .weeklyData!
                                                .friday[index]
                                                .image,
                                            productName: productSavedNotifier
                                                .weeklyData!.friday[index].name,
                                            productNum: productSavedNotifier
                                                .weeklyData!
                                                .friday[index]
                                                .searches,
                                            type: '',
                                          );
                                  },
                                ),
                                const Spacing.height(20),
                                WeeklyWidget(
                                  category: 'Saturday',
                                  itemCount: productSavedNotifier
                                          .weeklyData!.saturday.isEmpty
                                      ? 1
                                      : productSavedNotifier
                                          .weeklyData!.saturday.length,
                                  itemBuilder: (context, index) {
                                    return productSavedNotifier
                                            .weeklyData!.saturday.isEmpty
                                        ? const Spacing.empty()
                                        : ProductCount(
                                            productImage: productSavedNotifier
                                                .weeklyData!
                                                .saturday[index]
                                                .image,
                                            productName: productSavedNotifier
                                                .weeklyData!
                                                .saturday[index]
                                                .name,
                                            productNum: productSavedNotifier
                                                .weeklyData!
                                                .saturday[index]
                                                .searches,
                                            type: '',
                                          );
                                  },
                                ),
                                const Spacing.height(20),
                              ],
                            ),
                          ),
          ],
        ),
      ),
    );
  }
}
