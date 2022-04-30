import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/constants/images.dart';
import 'package:buy_link/core/constants/strings.dart';
import 'package:buy_link/core/constants/svgs.dart';
import 'package:buy_link/features/core/notifiers/home_notifier.dart';
import 'package:buy_link/features/core/views/single_rating.dart';
import 'package:buy_link/widgets/app_button.dart';
import 'package:buy_link/widgets/app_progress_bar.dart';
import 'package:buy_link/widgets/app_rating_bar.dart';
import 'package:buy_link/widgets/app_text_field.dart';
import 'package:buy_link/widgets/category_container.dart';
import 'package:buy_link/widgets/compare_texts.dart';
import 'package:buy_link/widgets/compare_texts_2.dart';
import 'package:buy_link/widgets/custmised_text.dart';
import 'package:buy_link/widgets/iconNtext_container.dart';
import 'package:buy_link/widgets/product_container.dart';
import 'package:buy_link/widgets/product_image_container.dart';
import 'package:buy_link/widgets/review_text_field.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../widgets/favorite_container.dart';

class StoreDashboardView extends ConsumerStatefulWidget {
  const StoreDashboardView({Key? key}) : super(key: key);

  @override
  _StoreDashboardViewState createState() => _StoreDashboardViewState();
}

class _StoreDashboardViewState extends ConsumerState {
  List<_SplineAreaData>? chartData;

  @override
  void initState() {
    chartData = <_SplineAreaData>[
      _SplineAreaData('Sun', 10.53, 3.3),
      _SplineAreaData('Mon', 9.5, 5.4),
      _SplineAreaData('Tue', 10, 2.65),
      _SplineAreaData('Wed', 9.4, 2.62),
      _SplineAreaData('Thu', 5.8, 1.99),
      _SplineAreaData('Fri', 4.9, 1.44),
      _SplineAreaData('Sat', 4.5, 2),
    ];
    super.initState();
  }

  @override
  void dispose() {
    chartData!.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        title: const Text(
          'Atinuke Stores',
          style: TextStyle(
            color: AppColors.dark,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        // actions: [
        //   FavoriteContainer(
        //     hasBorder: true,
        //     favIcon: SvgPicture.asset(AppSvgs.favorite),
        //     containerColor: AppColors.light,
        //     height: 32,
        //   ),
        //   const Spacing.tinyWidth(),
        //   FavoriteContainer(
        //     hasBorder: true,
        //     favIcon: SvgPicture.asset(AppSvgs.settings),
        //     containerColor: AppColors.light,
        //     height: 32,
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                height: 164,
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: CachedNetworkImageProvider(
                      AppStrings.ronaldo,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Most searched product',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.grey8,
                          ),
                        ),
                        AppRatingBar(
                          itemPadding: 4,
                        ),
                      ],
                    ),
                    const Spacing.mediumHeight(),
                    const Text(
                      '7843',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey8,
                      ),
                    ),
                    const Spacing.tinyHeight(),
                    const Text(
                      'Nike Kyrie 2',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey8,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacing.mediumHeight(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Overview',
                  style: TextStyle(
                    color: AppColors.grey4,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacing.smallHeight(),
              Container(
                height: 243,
                padding: const EdgeInsets.all(10),
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
                        child: SfCartesianChart(
                          // legend: Legend(isVisible: true, opacity: 0.7),
                          // title: ChartTitle(text: ''),
                          plotAreaBorderWidth: 0,
                          primaryXAxis: CategoryAxis(
                              interval: 1,
                              majorGridLines: const MajorGridLines(width: 0),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Product Searched',
                              style: TextStyle(
                                color: AppColors.grey4,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'This Week',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          '9,400',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacing.height(20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      height: 154,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.light,
                      ),
                      child: Column(
                        children: [
                          FavoriteContainer(
                            favIcon: SvgPicture.asset(AppSvgs.star),
                            containerColor: AppColors.shade1,
                          ),
                          const Text(
                            'Reviews',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.grey4,
                            ),
                          ),
                          const SizedBox(
                            width: 132,
                            child: Divider(thickness: 2),
                          ),
                          // const Spacing.mediumHeight(),
                          const Text(
                            'See all reviews',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacing.smallWidth(),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      height: 154,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.light,
                      ),
                      child: Column(
                        children: [
                          FavoriteContainer(
                            favIcon: SvgPicture.asset(AppSvgs.favorite),
                            containerColor: AppColors.shade1,
                          ),
                          const Text(
                            'Saved Products',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.grey4,
                            ),
                          ),
                          const SizedBox(
                            width: 132,
                            child: Divider(thickness: 2),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CustomisedText(
                                text: '0',
                                height: 40,
                                verticalPadding: 7,
                              ),
                              Spacing.tinyWidth(),
                              CustomisedText(
                                text: '9',
                                height: 40,
                                verticalPadding: 7,
                              ),
                              Spacing.tinyWidth(),
                              CustomisedText(
                                text: '0',
                                height: 40,
                                verticalPadding: 7,
                              ),
                            ],
                          ),
                          const Spacing.smallHeight(),
                          const Text(
                            'See all saved products',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Spacing.height(20),
              Container(
                height: 243,
                padding: const EdgeInsets.all(10),
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
                        child: SfCartesianChart(
                          plotAreaBorderWidth: 0,
                          title: ChartTitle(text: ''),
                          primaryXAxis: CategoryAxis(
                            majorGridLines: const MajorGridLines(width: 0),
                          ),
                          primaryYAxis: NumericAxis(
                              axisLine: const AxisLine(width: 0),
                              labelFormat: '{value}%',
                              majorTickLines: const MajorTickLines(size: 0)),
                          series: _getDefaultColumnSeries(),
                          tooltipBehavior: TooltipBehavior(
                              enable: true, header: '', canShowMarker: false),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Store Visits',
                              style: TextStyle(
                                color: AppColors.grey4,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'This Week',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          '9,400',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacing.height(20),
              Container(
                height: 120,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.light,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacing.smallHeight(),
                            const Text(
                              'Products',
                              style: TextStyle(
                                color: AppColors.grey4,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacing.height(8),
                            Row(
                              children: const [
                                CustomisedText(
                                  text: '0',
                                  fontSize: 32,
                                ),
                                Spacing.tinyWidth(),
                                CustomisedText(
                                  text: '9',
                                  fontSize: 32,
                                ),
                                Spacing.tinyWidth(),
                                CustomisedText(
                                  text: '0',
                                  fontSize: 32,
                                ),
                              ],
                            ),
                            const Spacing.height(10),
                            const Text(
                              'See all products',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Image.asset(
                          AppImages.bag,
                          height: 120,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacing.height(50),
            ],
          ),
        ),
      ),
      floatingActionButton: AppButton(
        text: 'Add Product',
        backgroundColor: AppColors.primaryColor,
        hasIcon: true,
        icon: SvgPicture.asset(AppSvgs.addProduct),
        width: null,
      ),
    );
  }

  /// Get default column series
  List<ColumnSeries<ChartSampleData, String>> _getDefaultColumnSeries() {
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        dataSource: <ChartSampleData>[
          ChartSampleData(x: 'China', y: 0.541),
          ChartSampleData(x: 'Brazil', y: 0.818),
          ChartSampleData(x: 'Bolivia', y: 1.51),
          ChartSampleData(x: 'Mexico', y: 1.302),
          ChartSampleData(x: 'Egypt', y: 2.017),
          ChartSampleData(x: 'Mongolia', y: 1.683),
        ],
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, textStyle: TextStyle(fontSize: 10)),
      )
    ];
  }

  List<ChartSeries<_SplineAreaData, String>> _getSplieAreaSeries() {
    return <ChartSeries<_SplineAreaData, String>>[
      SplineAreaSeries<_SplineAreaData, String>(
        dataSource: chartData!,
        borderColor: AppColors.primaryColor,
        color: const Color.fromRGBO(192, 108, 132, 0.6),
        // borderWidth: 1,
        // splineType: SplineType.cardinal,
        // name: 'China',
        xValueMapper: (_SplineAreaData sales, _) => sales.year,
        yValueMapper: (_SplineAreaData sales, _) => sales.y2,
      )
    ];
  }
}

// class ChartData {
//   ChartData(this.x, this.y);
//   final int x;
//   final double? y;
// }

/// Private class for storing the spline area chart datapoints.
class _SplineAreaData {
  _SplineAreaData(this.year, this.y1, this.y2);
  final String year;
  final double y1;
  final double y2;
}

class ChartSampleData {
  ChartSampleData({
    required this.x,
    required this.y,
  });
  final String x;
  final double y;
}
