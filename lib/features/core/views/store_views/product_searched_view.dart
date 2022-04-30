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
import 'package:buy_link/widgets/product_no_of_searches.dart';
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

class ProductSearchedView extends ConsumerStatefulWidget {
  const ProductSearchedView({Key? key}) : super(key: key);

  @override
  _ProductSearchedViewState createState() => _ProductSearchedViewState();
}

class _ProductSearchedViewState extends ConsumerState {
  List<_SplineAreaData>? chartData;
  String dropdownValue = 'This Week';

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
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                        favIcon: const Icon(
                          Icons.search_outlined,
                          size: 16,
                          color: AppColors.primaryColor,
                        ),
                        containerColor: AppColors.shade1,
                      ),
                      title: const Text(
                        'Product Searched',
                        style: const TextStyle(
                          color: AppColors.grey4,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: const Text(
                        '9,500',
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
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          elevation: 16,
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                          iconSize: 16,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          underline: const SizedBox(),
                          items: <String>['This Week', 'Two', 'Free', 'Four']
                              .map<DropdownMenuItem<String>>((String value) {
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Sunday',
                    style: TextStyle(
                      color: AppColors.grey4,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'searches',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'searches',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'searches',
                  ),
                ],
              ),
              const Spacing.height(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Monday',
                    style: TextStyle(
                      color: AppColors.grey4,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'searches',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'searches',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'searches',
                  ),
                ],
              ),
              const Spacing.height(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Tuesday',
                    style: TextStyle(
                      color: AppColors.grey4,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'searches',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'searches',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'searches',
                  ),
                ],
              ),
              const Spacing.height(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Wednesday',
                    style: TextStyle(
                      color: AppColors.grey4,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'searches',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'searches',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'searches',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
