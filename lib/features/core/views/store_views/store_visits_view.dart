import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/constants/svgs.dart';
import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/widgets/product_no_of_searches.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../widgets/circular_progress.dart';
import '../../../../widgets/favorite_container.dart';
import '../../../../widgets/weekly_widget.dart';
import '../../models/chart_data_model.dart';
import '../../models/product_model.dart';
import '../../notifiers/store_notifier/store_dashboard_notifier.dart';
import '../../notifiers/store_notifier/store_visits_notifier.dart';

class StoreVisitsView extends ConsumerStatefulWidget {
  final Store store;

  const StoreVisitsView({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  ConsumerState<StoreVisitsView> createState() => _StoreVisitsViewState();
}

class _StoreVisitsViewState extends ConsumerState<StoreVisitsView> {
  String dropdownValue = 'This Week';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(storeVisitsNotifierProvider)
          .fetchWeeklyData(storeId: widget.store.id, week: 'current');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final storeVisitsNotifier = ref.watch(storeVisitsNotifierProvider);
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
                        title: ChartTitle(text: ''),
                        primaryXAxis: CategoryAxis(
                          majorGridLines: const MajorGridLines(width: 0),
                        ),
                        primaryYAxis: NumericAxis(
                          axisLine: const AxisLine(width: 0),
                          majorTickLines: const MajorTickLines(size: 0),
                        ),
                        series: _getDefaultColumnSeries(),
                        tooltipBehavior: TooltipBehavior(
                          enable: true,
                          header: '',
                          canShowMarker: false,
                        ),
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
                    leading: FavoriteContainer(
                      height: 28,
                      width: 28,
                      padding: 5,
                      favIcon: SvgPicture.asset(
                        AppSvgs.store,
                        height: 16,
                        width: 16,
                      ),
                      containerColor: AppColors.shade1,
                    ),
                    title: const Text(
                      'Store Visits',
                      style: TextStyle(
                        color: AppColors.grey4,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      '${ref.watch(storeDashboardNotifierProvider).visitAnalytics?.total ?? 0}',
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
                        value: storeVisitsNotifier.dropdownValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                        iconSize: 16,
                        onChanged: (newValue) =>
                            storeVisitsNotifier.onDropDownChanged(
                          newValue: newValue!,
                          storeId: widget.store.id,
                        ),
                        underline: const SizedBox(),
                        items: <String>[
                          'This Week',
                          'Last Week',
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
            storeVisitsNotifier.state.isLoading
                ? const CircularProgress()
                : storeVisitsNotifier.state.isError
                    ? const Center(child: Text('An error occurred'))
                    : storeVisitsNotifier.weeklyData == null
                        ? const Center(child: Text('Something went wrong'))
                        : Expanded(
                            child: ListView(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                WeeklyWidget(
                                  category: 'Sunday',
                                  itemCount: storeVisitsNotifier
                                          .weeklyData!.sunday.isEmpty
                                      ? 1
                                      : storeVisitsNotifier
                                          .weeklyData!.sunday.length,
                                  itemBuilder: (context, index) {
                                    return storeVisitsNotifier
                                            .weeklyData!.sunday.isEmpty
                                        ? const Center(child: Text('Empty'))
                                        : ProductCount(
                                            productImage: storeVisitsNotifier
                                                .weeklyData!
                                                .sunday[index]
                                                .image,
                                            productName: storeVisitsNotifier
                                                .weeklyData!.sunday[index].name,
                                            productNum: storeVisitsNotifier
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
                                  itemCount: storeVisitsNotifier
                                          .weeklyData!.monday.isEmpty
                                      ? 1
                                      : storeVisitsNotifier
                                          .weeklyData!.monday.length,
                                  itemBuilder: (context, index) {
                                    return storeVisitsNotifier
                                            .weeklyData!.monday.isEmpty
                                        ? const Center(child: Text('Empty'))
                                        : ProductCount(
                                            productImage: storeVisitsNotifier
                                                .weeklyData!
                                                .monday[index]
                                                .image,
                                            productName: storeVisitsNotifier
                                                .weeklyData!.monday[index].name,
                                            productNum: storeVisitsNotifier
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
                                  itemCount: storeVisitsNotifier
                                          .weeklyData!.tuesday.isEmpty
                                      ? 1
                                      : storeVisitsNotifier
                                          .weeklyData!.tuesday.length,
                                  itemBuilder: (context, index) {
                                    return storeVisitsNotifier
                                            .weeklyData!.tuesday.isEmpty
                                        ? const Center(child: Text('Empty'))
                                        : ProductCount(
                                            productImage: storeVisitsNotifier
                                                .weeklyData!
                                                .tuesday[index]
                                                .image,
                                            productName: storeVisitsNotifier
                                                .weeklyData!
                                                .tuesday[index]
                                                .name,
                                            productNum: storeVisitsNotifier
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
                                  itemCount: storeVisitsNotifier
                                          .weeklyData!.wednesday.isEmpty
                                      ? 1
                                      : storeVisitsNotifier
                                          .weeklyData!.wednesday.length,
                                  itemBuilder: (context, index) {
                                    return storeVisitsNotifier
                                            .weeklyData!.wednesday.isEmpty
                                        ? const Center(child: Text('Empty'))
                                        : ProductCount(
                                            productImage: storeVisitsNotifier
                                                .weeklyData!
                                                .wednesday[index]
                                                .image,
                                            productName: storeVisitsNotifier
                                                .weeklyData!
                                                .wednesday[index]
                                                .name,
                                            productNum: storeVisitsNotifier
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
                                  itemCount: storeVisitsNotifier
                                          .weeklyData!.thursday.isEmpty
                                      ? 1
                                      : storeVisitsNotifier
                                          .weeklyData!.thursday.length,
                                  itemBuilder: (context, index) {
                                    return storeVisitsNotifier
                                            .weeklyData!.thursday.isEmpty
                                        ? const Center(child: Text('Empty'))
                                        : ProductCount(
                                            productImage: storeVisitsNotifier
                                                .weeklyData!
                                                .thursday[index]
                                                .image,
                                            productName: storeVisitsNotifier
                                                .weeklyData!
                                                .thursday[index]
                                                .name,
                                            productNum: storeVisitsNotifier
                                                .weeklyData!
                                                .thursday[index]
                                                .searches,
                                            type: 'searches',
                                          );
                                  },
                                ),
                                WeeklyWidget(
                                  category: 'Friday',
                                  itemCount: storeVisitsNotifier
                                          .weeklyData!.friday.isEmpty
                                      ? 1
                                      : storeVisitsNotifier
                                          .weeklyData!.friday.length,
                                  itemBuilder: (context, index) {
                                    return storeVisitsNotifier
                                            .weeklyData!.friday.isEmpty
                                        ? const Center(child: Text('Empty'))
                                        : ProductCount(
                                            productImage: storeVisitsNotifier
                                                .weeklyData!
                                                .friday[index]
                                                .image,
                                            productName: storeVisitsNotifier
                                                .weeklyData!.friday[index].name,
                                            productNum: storeVisitsNotifier
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
                                  itemCount: storeVisitsNotifier
                                          .weeklyData!.saturday.isEmpty
                                      ? 1
                                      : storeVisitsNotifier
                                          .weeklyData!.saturday.length,
                                  itemBuilder: (context, index) {
                                    return storeVisitsNotifier
                                            .weeklyData!.saturday.isEmpty
                                        ? const Center(child: Text('Empty'))
                                        : ProductCount(
                                            productImage: storeVisitsNotifier
                                                .weeklyData!
                                                .saturday[index]
                                                .image,
                                            productName: storeVisitsNotifier
                                                .weeklyData!
                                                .saturday[index]
                                                .name,
                                            productNum: storeVisitsNotifier
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

  List<ColumnSeries<ChartDataModel, String>> _getDefaultColumnSeries() {
    return <ColumnSeries<ChartDataModel, String>>[
      ColumnSeries<ChartDataModel, String>(
        dataSource: ref.watch(storeDashboardNotifierProvider).visitsData,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xff4167B2).withOpacity(0.9),
            const Color(0xff4167B2).withOpacity(0.6),
            // AppColors.light.withOpacity(0.5),
          ],
        ),
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
