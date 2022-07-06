import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/features/core/notifiers/store_notifier/store_dashboard_notifier.dart';
import 'package:buy_link/widgets/circular_progress.dart';
import 'package:buy_link/widgets/product_no_of_searches.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../widgets/favorite_container.dart';
import '../../../../widgets/weekly_widget.dart';
import '../../models/chart_data_model.dart';
import '../../models/product_model.dart';
import '../../notifiers/product_searched_notifier.dart';

class ProductSearchedView extends ConsumerStatefulWidget {
  final Store store;

  const ProductSearchedView({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  ConsumerState<ProductSearchedView> createState() =>
      _ProductSearchedViewState();
}

class _ProductSearchedViewState extends ConsumerState<ProductSearchedView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(productSearchedNotifierProvider)
          .fetchWeeklyData(storeId: widget.store.id, week: 'current');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productSearchedNotifier = ref.watch(productSearchedNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.dark),
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
            Container(
              height: 243,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.light,
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 171,
                      // width: MediaQuery.of(context).size.width - 40,
                      child: SfCartesianChart(
                        plotAreaBorderWidth: 0,
                        primaryXAxis: CategoryAxis(
                            interval: 1,
                            majorGridLines: const MajorGridLines(
                              width: 0,
                            ),
                            edgeLabelPlacement: EdgeLabelPlacement.shift),
                        primaryYAxis: NumericAxis(
                          // labelFormat: '{value}%',
                          axisLine: const AxisLine(width: 0),
                          majorTickLines: const MajorTickLines(size: 0),
                        ),
                        series: _getSplieAreaSeries(),
                        tooltipBehavior: TooltipBehavior(enable: true),
                      ),
                    ),
                  ),
                  ListTile(
                    horizontalTitleGap: 0,
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 20,
                    ),
                    leading: const FavoriteContainer(
                      height: 28,
                      width: 28,
                      padding: 5,
                      favIcon: Icon(
                        Icons.search_outlined,
                        size: 16,
                        color: AppColors.primaryColor,
                      ),
                      containerColor: AppColors.shade1,
                    ),
                    title: const Text(
                      'Product Searched',
                      style: TextStyle(
                        color: AppColors.grey4,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      '${ref.watch(storeDashboardNotifierProvider).searchAnalytics?.total ?? 0}',
                      style: TextStyle(
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
                        value: productSearchedNotifier.dropdownValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                        iconSize: 16,
                        onChanged: (newValue) =>
                            productSearchedNotifier.onDropDownChanged(
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
                ],
              ),
            ),
            const Spacing.height(20),
            productSearchedNotifier.state.isLoading
                ? const CircularProgress()
                : productSearchedNotifier.state.isError
                    ? const Center(child: Text('An error occurred'))
                    : productSearchedNotifier.weeklyData == null
                        ? const Center(child: Text('Something went wrong'))
                        : Expanded(
                            child: ListView(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                WeeklyWidget(
                                  category: 'Sunday',
                                  itemCount: productSearchedNotifier
                                          .weeklyData!.sunday.isEmpty
                                      ? 1
                                      : productSearchedNotifier
                                          .weeklyData!.sunday.length,
                                  itemBuilder: (context, index) {
                                    return productSearchedNotifier
                                            .weeklyData!.sunday.isEmpty
                                        ? const Center(child: Text('Empty'))
                                        : ProductCount(
                                            productImage:
                                                productSearchedNotifier
                                                    .weeklyData!
                                                    .sunday[index]
                                                    .image,
                                            productName: productSearchedNotifier
                                                .weeklyData!.sunday[index].name,
                                            productNum: productSearchedNotifier
                                                .weeklyData!
                                                .sunday[index]
                                                .searches,
                                            type: 'searches',
                                          );
                                  },
                                ),
                                const Spacing.height(20),
                                WeeklyWidget(
                                  category: 'Monday',
                                  itemCount: productSearchedNotifier
                                          .weeklyData!.monday.isEmpty
                                      ? 1
                                      : productSearchedNotifier
                                          .weeklyData!.monday.length,
                                  itemBuilder: (context, index) {
                                    return productSearchedNotifier
                                            .weeklyData!.monday.isEmpty
                                        ? const Center(child: Text('Empty'))
                                        : ProductCount(
                                            productImage:
                                                productSearchedNotifier
                                                    .weeklyData!
                                                    .monday[index]
                                                    .image,
                                            productName: productSearchedNotifier
                                                .weeklyData!.monday[index].name,
                                            productNum: productSearchedNotifier
                                                .weeklyData!
                                                .monday[index]
                                                .searches,
                                            type: 'searches',
                                          );
                                  },
                                ),
                                const Spacing.height(20),
                                WeeklyWidget(
                                  category: 'Tuesday',
                                  itemCount: productSearchedNotifier
                                          .weeklyData!.tuesday.isEmpty
                                      ? 1
                                      : productSearchedNotifier
                                          .weeklyData!.tuesday.length,
                                  itemBuilder: (context, index) {
                                    return productSearchedNotifier
                                            .weeklyData!.tuesday.isEmpty
                                        ? const Center(child: Text('Empty'))
                                        : ProductCount(
                                            productImage:
                                                productSearchedNotifier
                                                    .weeklyData!
                                                    .tuesday[index]
                                                    .image,
                                            productName: productSearchedNotifier
                                                .weeklyData!
                                                .tuesday[index]
                                                .name,
                                            productNum: productSearchedNotifier
                                                .weeklyData!
                                                .tuesday[index]
                                                .searches,
                                            type: 'searches',
                                          );
                                  },
                                ),
                                const Spacing.height(20),
                                WeeklyWidget(
                                  category: 'Wednesday',
                                  itemCount: productSearchedNotifier
                                          .weeklyData!.wednesday.isEmpty
                                      ? 1
                                      : productSearchedNotifier
                                          .weeklyData!.wednesday.length,
                                  itemBuilder: (context, index) {
                                    return productSearchedNotifier
                                            .weeklyData!.wednesday.isEmpty
                                        ? const Center(child: Text('Empty'))
                                        : ProductCount(
                                            productImage:
                                                productSearchedNotifier
                                                    .weeklyData!
                                                    .wednesday[index]
                                                    .image,
                                            productName: productSearchedNotifier
                                                .weeklyData!
                                                .wednesday[index]
                                                .name,
                                            productNum: productSearchedNotifier
                                                .weeklyData!
                                                .wednesday[index]
                                                .searches,
                                            type: 'searches',
                                          );
                                  },
                                ),
                                const Spacing.height(20),
                                WeeklyWidget(
                                  category: 'Thursday',
                                  itemCount: productSearchedNotifier
                                          .weeklyData!.thursday.isEmpty
                                      ? 1
                                      : productSearchedNotifier
                                          .weeklyData!.thursday.length,
                                  itemBuilder: (context, index) {
                                    return productSearchedNotifier
                                            .weeklyData!.thursday.isEmpty
                                        ? const Center(child: Text('Empty'))
                                        : ProductCount(
                                            productImage:
                                                productSearchedNotifier
                                                    .weeklyData!
                                                    .thursday[index]
                                                    .image,
                                            productName: productSearchedNotifier
                                                .weeklyData!
                                                .thursday[index]
                                                .name,
                                            productNum: productSearchedNotifier
                                                .weeklyData!
                                                .thursday[index]
                                                .searches,
                                            type: 'searches',
                                          );
                                  },
                                ),
                                WeeklyWidget(
                                  category: 'Friday',
                                  itemCount: productSearchedNotifier
                                          .weeklyData!.friday.isEmpty
                                      ? 1
                                      : productSearchedNotifier
                                          .weeklyData!.friday.length,
                                  itemBuilder: (context, index) {
                                    return productSearchedNotifier
                                            .weeklyData!.friday.isEmpty
                                        ? const Center(child: Text('Empty'))
                                        : ProductCount(
                                            productImage:
                                                productSearchedNotifier
                                                    .weeklyData!
                                                    .friday[index]
                                                    .image,
                                            productName: productSearchedNotifier
                                                .weeklyData!.friday[index].name,
                                            productNum: productSearchedNotifier
                                                .weeklyData!
                                                .friday[index]
                                                .searches,
                                            type: 'searches',
                                          );
                                  },
                                ),
                                const Spacing.height(20),
                                WeeklyWidget(
                                  category: 'Saturday',
                                  itemCount: productSearchedNotifier
                                          .weeklyData!.saturday.isEmpty
                                      ? 1
                                      : productSearchedNotifier
                                          .weeklyData!.saturday.length,
                                  itemBuilder: (context, index) {
                                    return productSearchedNotifier
                                            .weeklyData!.saturday.isEmpty
                                        ? const Center(child: Text('Empty'))
                                        : ProductCount(
                                            productImage:
                                                productSearchedNotifier
                                                    .weeklyData!
                                                    .saturday[index]
                                                    .image,
                                            productName: productSearchedNotifier
                                                .weeklyData!
                                                .saturday[index]
                                                .name,
                                            productNum: productSearchedNotifier
                                                .weeklyData!
                                                .saturday[index]
                                                .searches,
                                            type: 'searches',
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

  List<ChartSeries<ChartDataModel, String>> _getSplieAreaSeries() {
    return <ChartSeries<ChartDataModel, String>>[
      SplineAreaSeries<ChartDataModel, String>(
        dataSource: ref.watch(storeDashboardNotifierProvider).searchedData,
        borderColor: AppColors.primaryColor,
        color: const Color.fromRGBO(65, 103, 178, 0.69),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xff4167B2).withOpacity(0.9),
            const Color(0xff4167B2).withOpacity(0.6),
            AppColors.light.withOpacity(0.5),
          ],
        ),
        borderWidth: 3,
        // splineType: SplineType.cardinal,
        // name: 'China',
        xValueMapper: (ChartDataModel data, _) => data.day,
        yValueMapper: (ChartDataModel data, _) => data.value,
        dataLabelSettings: const DataLabelSettings(
          isVisible: true,
          textStyle: TextStyle(
            fontSize: 10,
            color: Color(0xff4267B2),
            fontWeight: FontWeight.w600,
          ),
        ),
      )
    ];
  }
}
