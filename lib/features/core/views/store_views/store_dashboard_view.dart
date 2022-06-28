import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/constants/images.dart';
import 'package:buy_link/core/constants/svgs.dart';
import 'package:buy_link/core/routes.dart';
import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/features/core/models/chart_data_model.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/app_button.dart';
import 'package:buy_link/widgets/circular_progress.dart';
import 'package:buy_link/widgets/custmised_text.dart';
import 'package:buy_link/widgets/iconNtext_container.dart';
import 'package:buy_link/widgets/most_searched_product_container.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../widgets/favorite_container.dart';
import '../../../../widgets/iconNtext_container2.dart';
import '../../models/product_model.dart';
import '../../models/store_review_arg_model.dart';
import '../../notifiers/store_notifier/store_dashboard_notifier.dart';

// TODO: Make the product image scrollable and work on the see all reviews widget and also the app bar actions.
class StoreDashboardView extends ConsumerStatefulWidget {
  final Store store;

  const StoreDashboardView({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  ConsumerState<StoreDashboardView> createState() => _StoreDashboardViewState();
}

class _StoreDashboardViewState extends ConsumerState<StoreDashboardView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ref
          .read(storeDashboardNotifierProvider)
          .initFetch(storeId: widget.store.id);
    });
  }

  @override
  void dispose() {
    // chartData!.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final storeDashboardNotifier = ref.watch(storeDashboardNotifierProvider);
    return Scaffold(
      // backgroundColor: AppColors.grey6,
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
          backgroundColor: AppColors.grey9,
          title: Text(
            widget.store.name,
            style: const TextStyle(
              color: AppColors.dark,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          actions: [
            Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        width: 1.1,
                        color: AppColors.primaryColor,
                        style: BorderStyle.solid,
                      ),
                      // borderRadius: BorderRadius.all(),
                    ),
                    child: GestureDetector(
                      child: Icon(
                        Icons.mail_outline_outlined,
                        color: AppColors.primaryColor,
                        size: 20,
                      ),
                      onTap: () {
                        ref.read(navigationServiceProvider).navigateToNamed(
                              Routes.storeMessages,
                              arguments: widget.store,
                            );
                      },
                    )),
                const Spacing.smallWidth(),
                Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        width: 1.1,
                        color: AppColors.primaryColor,
                        style: BorderStyle.solid,
                      ),
                      // borderRadius: BorderRadius.all(),
                    ),
                    child: GestureDetector(
                      child: SvgPicture.asset(
                        AppSvgs.setting2,
                        color: AppColors.primaryColor,
                        width: 20,
                        height: 20,
                      ),
                      onTap: () {
                        ref.read(navigationServiceProvider).navigateToNamed(
                              Routes.storeSettings,
                              arguments: widget.store,
                            );
                      },
                    )),
                const Spacing.smallWidth(),
                const Spacing.mediumWidth(),
              ],
            )
          ]
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: storeDashboardNotifier.state.isError
              ? const Center(child: Text('An error occurred.'))
              : storeDashboardNotifier.initLoading
                  ? const CircularProgress()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 164,
                          child: storeDashboardNotifier
                                  .mostSearchedNCount!.products.isEmpty
                              ? const Center(child: Text('No Product yet'))
                              : ListView.separated(
                                  itemCount: storeDashboardNotifier
                                      .mostSearchedNCount!.products.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) =>
                                      MostSearchedProductContainer(
                                    productName: storeDashboardNotifier
                                        .mostSearchedNCount!
                                        .products[index]
                                        .name,
                                    productImage: storeDashboardNotifier
                                        .mostSearchedNCount!
                                        .products[index]
                                        .image,
                                    rating: storeDashboardNotifier
                                        .mostSearchedNCount!
                                        .products[index]
                                        .star,
                                    noOfSearches: storeDashboardNotifier
                                        .mostSearchedNCount!
                                        .products[index]
                                        .searches,
                                  ),
                                  separatorBuilder: (context, index) =>
                                      const Spacing.smallWidth(),
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
                        GestureDetector(
                          onTap: () => ref
                              .read(navigationServiceProvider)
                              .navigateToNamed(Routes.productSearched,
                                  arguments: widget.store),
                          child: Container(
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
                                    child: GestureDetector(
                                      // onTap: () => print('Chart tapped'),
                                      child: ClipRect(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20.0),
                                          child: OverflowBox(
                                            maxWidth: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: SfCartesianChart(
                                              // onLegendTapped: (_) =>
                                              //     print('onLegendTapped tapped'),
                                              // onAxisLabelTapped: (_) => print(
                                              //     'onAxisLabelTapped tapped'),
                                              // onDataLabelTapped: (_) => print(
                                              //     'onDataLabelTapped tapped'),
                                              // onLegendTapped: (_) => print('Chart tapped'),
                                              // legend: Legend(isVisible: true, opacity: 0.7),
                                              // title: ChartTitle(text: ''),
                                              plotAreaBorderWidth: 0,
                                              primaryXAxis: CategoryAxis(
                                                  interval: 1,
                                                  majorGridLines:
                                                      const MajorGridLines(
                                                    width: 0,
                                                  ),
                                                  edgeLabelPlacement:
                                                      EdgeLabelPlacement.shift),
                                              primaryYAxis: NumericAxis(
                                                // labelFormat: '{value}%',
                                                axisLine:
                                                    const AxisLine(width: 0),
                                                majorTickLines:
                                                    const MajorTickLines(
                                                        size: 0),
                                              ),
                                              series: _getSplieAreaSeries(),
                                              tooltipBehavior:
                                                  TooltipBehavior(enable: true),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              ref
                                                  .read(
                                                      navigationServiceProvider)
                                                  .navigateToNamed(
                                                      Routes.productSearched);
                                            },
                                            child: const Text(
                                              'Product Searched',
                                              style: TextStyle(
                                                color: AppColors.grey4,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            style: TextButton.styleFrom(
                                              minimumSize: Size.zero,
                                              padding: EdgeInsets.zero,
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                          ),
                                          const Text(
                                            'This Week',
                                            style: TextStyle(
                                              color: AppColors.primaryColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        storeDashboardNotifier
                                                .searchAnalytics?.total
                                                .toString() ??
                                            '0',
                                        style: const TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacing.height(20),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => ref
                                    .read(navigationServiceProvider)
                                    .navigateToNamed(
                                      Routes.storeReviews,
                                      arguments: StoreReviewArgModel(
                                        storeName: widget.store.name,
                                        storeId: widget.store.id,
                                      ),
                                    ),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  height: 154,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.light,
                                  ),
                                  child: Column(
                                    //mainAxisAlignment: Main,
                                    children: [
                                      Spacing.tinyHeight(),
                                      FavoriteContainer(
                                        height: 28,
                                        width: 28,
                                        favIcon: SvgPicture.asset(
                                          AppSvgs.addReviewStar,
                                          color: AppColors.primaryColor,
                                          width: 6,
                                          height: 6,
                                        ),
                                        containerColor: AppColors.shade1,
                                        padding: 6,
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
                                        child: Divider(
                                          thickness: 2,
                                          color: AppColors.grey8,
                                        ),
                                      ),
                                      // const Spacing.mediumHeight(),
                                      Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            width: 70,
                                            // color: AppColors.dark,
                                            child: ClipRect(
                                              clipBehavior: Clip.hardEdge,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20.0),
                                                child: OverflowBox(
                                                  maxHeight: 100,
                                                  // maxWidth: 100,
                                                  child: Container(
                                                    // margin: EdgeInsets.only(top: 20),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.light,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        width: 10,
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          IconNTextContainer2(
                                            text: storeDashboardNotifier
                                                .mostSearchedNCount!.storeGrade
                                                .toStringAsFixed(1),
                                            textColor: const Color(0xff5C6475),
                                            fontSize: 12,
                                            icon: SvgPicture.asset(
                                              AppSvgs.starFilled,
                                              width: 12,
                                              height: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacing.tinyHeight(),
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
                            ),
                            const Spacing.smallWidth(),
                            Expanded(
                              child: GestureDetector(
                                // onTap: () => ref
                                //     .read(navigationServiceProvider)
                                //     .navigateToNamed(Routes.savedProducts),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  height: 154,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.light,
                                  ),
                                  child: Column(
                                    children: [
                                      Spacing.tinyHeight(),
                                      FavoriteContainer(
                                        height: 28,
                                        width: 28,
                                        favIcon:
                                            SvgPicture.asset(AppSvgs.favorite),
                                        containerColor: AppColors.shade1,
                                        padding: 6,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          ref
                                              .read(navigationServiceProvider)
                                              .navigateToNamed(
                                                  Routes.savedProducts);
                                        },
                                        child: const Text(
                                          'Saved Products',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.grey4,
                                          ),
                                        ),
                                        style: TextButton.styleFrom(
                                          minimumSize: Size.zero,
                                          padding: EdgeInsets.zero,
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 132,
                                        child: Divider(
                                            thickness: 2,
                                            color: AppColors.grey8),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CustomisedText(
                                            text: storeDashboardNotifier
                                                .mostSearchedNCount!
                                                .storeProductsSaved
                                                .toString(),
                                            height: 40,
                                            verticalPadding: 5,
                                          ),
                                          // Spacing.tinyWidth(),
                                          // CustomisedText(
                                          //   text: '9',
                                          //   height: 40,
                                          //   verticalPadding: 7,
                                          // ),
                                          // Spacing.tinyWidth(),
                                          // CustomisedText(
                                          //   text: '0',
                                          //   height: 40,
                                          //   verticalPadding: 7,
                                          // ),
                                        ],
                                      ),
                                      const Spacing.smallHeight(),
                                      const Text(
                                        // 'See all saved products',
                                        '',
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
                            ),
                          ],
                        ),
                        const Spacing.height(20),
                        GestureDetector(
                          onTap: () => ref
                              .read(navigationServiceProvider)
                              .navigateToNamed(Routes.storeVisits,
                                  arguments: widget.store),
                          child: Container(
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
                                    child: ClipRect(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20.0),
                                        child: OverflowBox(
                                          maxWidth:
                                              MediaQuery.of(context).size.width,
                                          child: SfCartesianChart(
                                            plotAreaBorderWidth: 0,
                                            title: ChartTitle(text: ''),
                                            primaryXAxis: CategoryAxis(
                                              majorGridLines:
                                                  const MajorGridLines(
                                                      width: 0),
                                            ),
                                            primaryYAxis: NumericAxis(
                                              axisLine:
                                                  const AxisLine(width: 0),
                                              majorTickLines:
                                                  const MajorTickLines(size: 0),
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
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              ref
                                                  .read(
                                                      navigationServiceProvider)
                                                  .navigateToNamed(
                                                      Routes.storeVisits);
                                            },
                                            child: const Text(
                                              'Store Visits',
                                              style: TextStyle(
                                                color: AppColors.grey4,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            style: TextButton.styleFrom(
                                              minimumSize: Size.zero,
                                              padding: EdgeInsets.zero,
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                          ),
                                          const Text(
                                            'This Week',
                                            style: TextStyle(
                                              color: AppColors.primaryColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        storeDashboardNotifier
                                                .visitAnalytics?.total
                                                .toString() ??
                                            '0',
                                        style: const TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacing.height(20),
                        GestureDetector(
                          onTap: () => ref
                              .read(navigationServiceProvider)
                              .navigateToNamed(
                                Routes.productList,
                                arguments: widget.store,
                              ),
                          child: Container(
                            height: 120,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.light,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          children: [
                                            CustomisedText(
                                              text: storeDashboardNotifier
                                                  .mostSearchedNCount!
                                                  .storeProductCount
                                                  .toString(),
                                              fontSize: 32,
                                              verticalPadding: 5,
                                            ),
                                            // Spacing.tinyWidth(),
                                            // CustomisedText(
                                            //   text: '9',
                                            //   fontSize: 32,
                                            // ),
                                            // Spacing.tinyWidth(),
                                            // CustomisedText(
                                            //   text: '0',
                                            //   fontSize: 32,
                                            // ),
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
                        ),
                        const Spacing.height(50),
                      ],
                    ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: storeDashboardNotifier.state.isIdle,
        child: AppButton(
          text: 'Add Product',
          backgroundColor: AppColors.primaryColor,
          hasIcon: true,
          icon: SvgPicture.asset(AppSvgs.addProduct),
          width: null,
          onPressed: () {
            ref.read(navigationServiceProvider).navigateToNamed(
                  Routes.addProduct,
                  arguments: widget.store,
                );
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => AddProductView(),
            //   ),
            // );
          },
        ),
      ),
    );
  }

  /// Get default column series
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

  List<ChartSeries<ChartDataModel, String>> _getSplieAreaSeries() {
    return <ChartSeries<ChartDataModel, String>>[
      SplineAreaSeries<ChartDataModel, String>(
        dataSource: ref.read(storeDashboardNotifierProvider).searchedData,
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
