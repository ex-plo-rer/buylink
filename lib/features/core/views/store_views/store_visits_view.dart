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
import '../../models/chart_data_model.dart';
import '../../notifiers/store_notifier/store_dashboard_notifier.dart';

class StoreVisitsView extends ConsumerStatefulWidget {
  const StoreVisitsView({Key? key}) : super(key: key);

  @override
  _StoreVisitsViewState createState() => _StoreVisitsViewState();
}

class _StoreVisitsViewState extends ConsumerState {
  String dropdownValue = 'This Week';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
                      subtitle: const Text(
                        '2,500',
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
                    type: 'visits',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'visits',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'visits',
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
                    type: 'visits',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'visits',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'visits',
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
                    type: 'visits',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'visits',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'visits',
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
                    type: 'visits',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'visits',
                  ),
                  Spacing.smallHeight(),
                  ProductCount(
                    productImage: AppImages.bag,
                    productName: 'Black Levi Jeans',
                    productNum: 300,
                    type: 'visits',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<ColumnSeries<ChartDataModel, String>> _getDefaultColumnSeries() {
    return <ColumnSeries<ChartDataModel, String>>[
      ColumnSeries<ChartDataModel, String>(
        dataSource: ref.read(storeDashboardNotifierProvider).visitsData,
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
