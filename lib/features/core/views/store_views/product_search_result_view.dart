import 'dart:async';

import 'package:buy_link/core/utilities/alertify.dart';
import 'package:buy_link/core/utilities/loader.dart';
import 'package:buy_link/features/core/models/product_model.dart';
import 'package:buy_link/widgets/app_search_dialog.dart';
import 'package:buy_link/widgets/product_container.dart';
import 'package:buy_link/widgets/product_container_search.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_dragmarker/dragmarker.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utilities/map/circle.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/map_search_term_container.dart';
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

  @override
  void initState() {
    super.initState();
    // ref.read(storeDirectionNotifierProvider).initLocation();
    ref.read(productSearchNotifierProvider).initLocation();
    _centerOnLocationUpdate = CenterOnLocationUpdate.always;
    _centerCurrentLocationStreamController = StreamController<double>();
    ref.read(productSearchNotifierProvider).initLocation();
    // init();
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
      // bottomSheet: BottomSheet(
      //   onClosing: () {},
      //   builder: (context) {
      //     return Container(
      //       // height: 90,
      //       padding: const EdgeInsets.all(20),
      //       decoration: BoxDecoration(
      //           shape: BoxShape.rectangle,
      //           borderRadius: BorderRadius.circular(15),
      //           color: AppColors.light),
      //       child: SearchProductBottomSheet(
      //         products: widget.args.searchResult.result,
      //       ),
      //     );
      //     //   SingleChildScrollView(
      //     //   child: Container(
      //     //     height: 90,
      //     //     padding: const EdgeInsets.all(20),
      //     //     decoration: BoxDecoration(
      //     //         shape: BoxShape.rectangle,
      //     //         borderRadius: BorderRadius.circular(15),
      //     //         color: AppColors.light),
      //     //     child: AppButton(
      //     //       text: 'Confirm Location',
      //     //       textColor: AppColors.light,
      //     //       backgroundColor: AppColors.primaryColor,
      //     //       onPressed: () async {
      //     //         ref
      //     //             .read(navigationServiceProvider)
      //     //             .navigateToNamed(Routes.productSearchedResult);
      //     //
      //     //         await productSearch.fetchProductSearch(
      //     //             search_term: "apple",
      //     //             lon: 3.71,
      //     //             lat: 3.406,
      //     //             range: 5,
      //     //             min_price: 0,
      //     //             max_price: 10000000000);
      //     //         ref
      //     //             .read(navigationServiceProvider)
      //     //             .navigateToNamed(Routes.productSearchedResult);
      //     //       },
      //     //       height: 50,
      //     //     ),
      //     //   ),
      //     // );
      //   },
      // ),
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                height:
                    (constraints.maxHeight / 2) + (constraints.maxHeight / 4),
                child: FlutterMap(
                  options: MapOptions(
                    zoom: 11.5,
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
                    TileLayerWidget(
                      options: TileLayerOptions(
                        urlTemplate:
                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: ['a', 'b', 'c'],
                        maxZoom: 19,
                      ),
                    ),
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
                          _centerCurrentLocationStreamController.add(18);
                        },
                        child: const Icon(Icons.my_location,
                            color: Colors.white, size: 30),
                      ),
                    )
                  ],
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
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
                        Marker(
                          width: 80,
                          height: 80,
                          point: widget.args.filterPosition,
                          builder: (ctx) => const Icon(
                            Icons.location_pin,
                            size: 50,
                            color: Color(0xffCD261F),
                          ),
                        ),
                        ...widget.args.searchResult.result
                            .map(
                              (product) => Marker(
                                width: 80,
                                height: 80,
                                point: LatLng(
                                  product.store.lat,
                                  product.store.lon,
                                ),
                                builder: (ctx) => const Icon(
                                  Icons.chat,
                                  size: 50,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            )
                            .toList(),
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
                  child: Expanded(
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
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
                            itemCount: widget.args.searchResult.result.length,
                            itemBuilder: (context, index) {
                              final product =
                                  widget.args.searchResult.result[index];
                              //TODO: Just return the product and fill the details inside ProductContainerSearch
                              return ProductContainerSearch(
                                url: product.image.first,
                                storeName: product.store.name,
                                productName: product.name,
                                productPrice: product.price,
                                distance: '4.3',
                                isFavorite: product.isFav!,
                                product: product,
                                activeIndex:
                                    productSearchResultNotifier.activeIndex,
                                onPageChanged:
                                    productSearchResultNotifier.nextPage,
                              );
                            },
                            separatorBuilder: (_, __) =>
                                const Spacing.smallHeight(),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
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
      child: ProductContainer(
        url: products[1].image.first,
        storeName: products[1].store.name,
        productName: products[1].name,
        productPrice: products[1].price,
        distance: '4.3',
        isFavorite: products[1].isFav!,
      ),
    );
  }
}
