import 'dart:async';

import 'package:buy_link/core/constants/dimensions.dart';
import 'package:buy_link/core/utilities/loader.dart';
import 'package:buy_link/features/core/models/product_model.dart';
import 'package:buy_link/widgets/product_container.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/svgs.dart';
import '../../../../core/utilities/map/circle.dart';
import '../../../../widgets/map_price_marker.dart';
import '../../../../widgets/map_search_term_container.dart';
import '../../../../widgets/product_container_search_horizontal.dart';
import '../../models/search_result_arg_model.dart';
import '../../notifiers/store_notifier/product_search_notifier.dart';
import '../../notifiers/store_notifier/product_search_result_notifier.dart';

class ProductSearchResultView extends ConsumerStatefulWidget {
  const ProductSearchResultView({
    Key? key,
    required this.args,
  }) : super(key: key);
  final SearchResultArgModel args;

  @override
  ConsumerState<ProductSearchResultView> createState() =>
      _ProductSearchResultViewState();
}

class _ProductSearchResultViewState
    extends ConsumerState<ProductSearchResultView> {
  final searchFocus = FocusNode();
  final searchController = TextEditingController();
  late CenterOnLocationUpdate _centerOnLocationUpdate;

  late StreamController<double> _centerCurrentLocationStreamController;

  late ItemScrollController itemScrollController;
  late ItemPositionsListener itemPositionsListener;

  @override
  void initState() {
    super.initState();
    // ref.read(storeDirectionNotifierProvider).initLocation();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productSearchNotifierProvider).initLocation();
      _centerOnLocationUpdate = CenterOnLocationUpdate.always;
      _centerCurrentLocationStreamController = StreamController<double>();
      ref
          .watch(productSearchResultNotifierProvider)
          .initColors(length: widget.args.searchResult.result.length);
      itemScrollController = ItemScrollController();
      itemPositionsListener = ItemPositionsListener.create();
    });
  }

  @override
  void dispose() {
    _centerCurrentLocationStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productSearchResultNotifier =
        ref.watch(productSearchResultNotifierProvider);

    return Scaffold(
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                height: productSearchResultNotifier.isHorizontal
                    ? constraints.maxHeight
                    : (constraints.maxHeight / 2) + (constraints.maxHeight / 4),
                child: FlutterMap(
                  options: MapOptions(
                    zoom: Dimensions.zoom,
                    minZoom: Dimensions.minZoom,
                    maxZoom: Dimensions.maxZoom,
                    interactiveFlags:
                        InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                    onPositionChanged: (MapPosition position, bool hasGesture) {
                      if (hasGesture) {
                        setState(
                          () => _centerOnLocationUpdate =
                              CenterOnLocationUpdate.never,
                        );
                      }
                    },
                    center: widget.args.filterPosition,
                    // bounds: LatLngBounds(LatLng(58.8, 6.1), LatLng(59, 6.2)),
                    boundsOptions:
                        const FitBoundsOptions(padding: EdgeInsets.all(8.0)),
                  ),
                  children: [
                    LocationMarkerLayerWidget(
                      plugin: LocationMarkerPlugin(
                        centerCurrentLocationStream:
                            _centerCurrentLocationStreamController.stream,
                        centerOnLocationUpdate: _centerOnLocationUpdate,
                      ),
                    ),
                  ],
                  nonRotatedChildren: [
                    Positioned(
                      right: 20,
                      bottom: 20,
                      child: FloatingActionButton(
                        onPressed: () {
                          // Automatically center the location marker on the map when location updated until user interact with the map.
                          setState(
                            () => _centerOnLocationUpdate =
                                CenterOnLocationUpdate.always,
                          );
                          // Center the location marker on the map and zoom the map to level 18.
                          _centerCurrentLocationStreamController
                              .add(Dimensions.zoom);
                        },
                        backgroundColor: AppColors.light,
                        child: const Icon(
                          Icons.my_location,
                          color: AppColors.grey2,
                          size: 15,
                        ),
                      ),
                    )
                  ],
                  layers: [
                    TileLayerOptions(
                      tileProvider: NetworkTileProvider(),
                      urlTemplate:
                          "http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}",
                      // "http://{s}.google.com/vt/lyrs=s,h&x={x}&y={y}&z={z}",
                      subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],
                      // attributionBuilder: (_) {
                      //   return const Text("Got more work to do...");
                      // },
                    ),
                    CircleRegion(
                      widget.args.filterPosition,
                      widget.args.radius,
                    ).toDrawable(
                      fillColor: AppColors.primaryColor.withOpacity(0.5),
                    ),
                    MarkerLayerOptions(
                      markers: [
                        ...widget.args.searchResult.result.map((product) {
                          final index = widget.args.searchResult.result
                              .indexWhere((pdct) => pdct.id == product.id);
                          return Marker(
                            width: 80,
                            height: 54,
                            point: LatLng(
                              product.store.lat,
                              product.store.lon,
                            ),
                            builder: (ctx) => MapPriceMarker(
                              onMarkerTapped: () {
                                if (!productSearchResultNotifier.isHorizontal) {
                                  productSearchResultNotifier
                                      .changeViewToHorizontal();
                                }
                                if (itemScrollController.isAttached) {
                                  productSearchResultNotifier.changeColor(
                                      index: index);
                                  productSearchResultNotifier.changeTextColor(
                                      index: index);
                                  print(
                                      'Scroll controller attached ${itemScrollController.isAttached}');
                                  itemScrollController.scrollTo(
                                    index: index,
                                    duration: const Duration(seconds: 2),
                                    curve: Curves.easeInOutCubic,
                                  );
                                }
                              },
                              price: product.price,
                              containerColor: productSearchResultNotifier
                                  .markerColors[index],
                              textColor: productSearchResultNotifier
                                  .markerTextColors[index],
                            ),
                          );
                        }).toList(),
                        Marker(
                          point: widget.args.filterPosition,
                          width: 50.0,
                          height: 50.0,
                          builder: (ctx) => SvgPicture.asset(AppSvgs.redMarker),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          MapSearchTermContainer(
            searchTerm: widget.args.searchTerm,
            onMinChanged: productSearchResultNotifier.onMinPriceChanged,
            onMaxChanged: productSearchResultNotifier.onMaxPriceChanged,
            onSliderChanged: (newValue) =>
                productSearchResultNotifier.onSliderChanged(newValue),
            sliderValue: productSearchResultNotifier.sliderValue,
            onApplyPressed: () async {
              Loader(context).showLoader(text: 'Loading');
              await productSearchResultNotifier.fetchProductSearch(
                searchTerm: widget.args.searchTerm,
              );
              Loader(context).hideLoader();
            },
            hideFilter: true,
          ),
          if (!productSearchResultNotifier.isHorizontal)
            DraggableScrollableSheet(
                initialChildSize: 0.25,
                minChildSize: 0.25,
                builder: (context, scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: AppColors.light,
                    ),
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 12,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: AppColors.light,
                      ),
                      child: Expanded(
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: AppColors.grey7,
                              ),
                              height: 4,
                              width: 28,
                              // color: AppColors.grey7,
                            ),
                            const Spacing.mediumHeight(),
                            Text(
                              '${widget.args.searchResult.result.length} stores found',
                              style: const TextStyle(
                                color: AppColors.grey1,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            // const Spacing.mediumHeight(),
                            Expanded(
                              child: ListView.separated(
                                controller: scrollController,
                                itemCount:
                                    widget.args.searchResult.result.length,
                                itemBuilder: (context, index) {
                                  final product =
                                      widget.args.searchResult.result[index];
                                  //TODO: Just return the product and fill the details inside ProductContainerSearch
                                  return ProductContainerSearchHorizontal(
                                    url: product.image.first,
                                    storeName: product.store.name,
                                    productName: product.name,
                                    productPrice: product.price,
                                    distance: '4.3',
                                    isFavorite: product.isFav!,
                                  );
                                },
                                separatorBuilder: (_, __) =>
                                    const Spacing.smallHeight(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          if (productSearchResultNotifier.isHorizontal)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 120,
                color: AppColors.transparent,
                margin: const EdgeInsets.only(bottom: 32),
                child: ScrollablePositionedList.separated(
                  // controller: scrollController,
                  // shrinkWrap: true,
                  itemScrollController: itemScrollController,
                  itemPositionsListener: itemPositionsListener,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.args.searchResult.result.length,
                  itemBuilder: (context, index) {
                    final product = widget.args.searchResult.result[index];
                    //TODO: Just return the product and fill the details inside ProductContainerSearch
                    return ProductContainerSearchHorizontal(
                      url: product.image.first,
                      storeName: product.store.name,
                      productName: product.name,
                      productPrice: product.price,
                      distance: '4.3',
                      isFavorite: product.isFav!,
                    );
                  },
                  separatorBuilder: (_, __) => const Spacing.smallWidth(),
                ),
              ),
            ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Automatically center the location marker on the map when location updated until user interact with the map.
      //     setState(
      //       () => _centerOnLocationUpdate = CenterOnLocationUpdate.always,
      //     );
      //     // Center the location marker on the map and zoom the map to level 18.
      //     _centerCurrentLocationStreamController.add(18);
      //   },
      //   child: const Icon(Icons.my_location, color: Colors.white, size: 30),
      // ),
    );
  }
}

class SearchProductBottomSheet extends StatelessWidget {
  const SearchProductBottomSheet({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: AppColors.light,
      ),
      // height: 200,
      child: SingleChildScrollView(
        child: ListView.separated(
          itemCount: products.length,
          itemBuilder: (context, index) => ProductContainer(
            product: products[index],
            isFavorite: products[index].isFav!,
          ),
          separatorBuilder: (context, index) => const Spacing.tinyHeight(),
        ),
      ),
    );
  }
}
