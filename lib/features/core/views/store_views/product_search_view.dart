import 'dart:async';

import 'package:buy_link/core/constants/dimensions.dart';
import 'package:buy_link/core/utilities/alertify.dart';
import 'package:buy_link/core/utilities/loader.dart';
import 'package:buy_link/features/core/models/search_result_arg_model.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/map_search_dialog.dart';
import 'package:buy_link/widgets/map_search_term_container.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_dragmarker/dragmarker.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/routes.dart';
import '../../../../core/utilities/map/circle.dart';
import '../../../../widgets/app_button.dart';
import '../../notifiers/store_notifier/product_search_notifier.dart';

class ProductSearchView extends ConsumerStatefulWidget {
  const ProductSearchView({
    Key? key,
    required this.searchTerm,
  }) : super(key: key);
  final String searchTerm;

  @override
  ConsumerState<ProductSearchView> createState() => _ProductSearchViewState();
}

class _ProductSearchViewState extends ConsumerState<ProductSearchView> {
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
    init();
  }

  init() async {
    print('ProSV INIT');
    await ref
        .read(productSearchNotifierProvider)
        .saveToRecentSearches(widget.searchTerm);
  }

  @override
  void dispose() {
    _centerCurrentLocationStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productSearchNotifier = ref.watch(productSearchNotifierProvider);

    return Scaffold(
      bottomSheet: BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            // height: 90,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15),
                color: AppColors.light),
            child: SearchProductBottomSheet(
              onConfirmPressed: () async {
                Loader(context).showLoader(text: 'Loading');
                await productSearchNotifier.fetchProductSearch(
                  searchTerm: widget.searchTerm,
                );
                if (productSearchNotifier.searchResult!.result.isEmpty) {
                  Alertify(
                          title:
                              'The searched product is not available in this area.')
                      .error();
                  Loader(context).hideLoader();
                } else {
                  Loader(context).hideLoader();
                  ref.read(navigationServiceProvider).navigateToNamed(
                        Routes.productSearchResult,
                        arguments: SearchResultArgModel(
                          filterPosition: LatLng(
                            productSearchNotifier.filterLat,
                            productSearchNotifier.filterLon,
                          ),
                          radius: productSearchNotifier.sliderValue,
                          searchResult: productSearchNotifier.searchResult!,
                          searchTerm: widget.searchTerm,
                        ),
                      );
                }
              },
            ),
          );
          //   SingleChildScrollView(
          //   child: Container(
          //     height: 90,
          //     padding: const EdgeInsets.all(20),
          //     decoration: BoxDecoration(
          //         shape: BoxShape.rectangle,
          //         borderRadius: BorderRadius.circular(15),
          //         color: AppColors.light),
          //     child: AppButton(
          //       text: 'Confirm Location',
          //       textColor: AppColors.light,
          //       backgroundColor: AppColors.primaryColor,
          //       onPressed: () async {
          //         ref
          //             .read(navigationServiceProvider)
          //             .navigateToNamed(Routes.productSearchedResult);
          //
          //         await productSearch.fetchProductSearch(
          //             search_term: "apple",
          //             lon: 3.71,
          //             lat: 3.406,
          //             range: 5,
          //             min_price: 0,
          //             max_price: 10000000000);
          //         ref
          //             .read(navigationServiceProvider)
          //             .navigateToNamed(Routes.productSearchedResult);
          //       },
          //       height: 50,
          //     ),
          //   ),
          // );
        },
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              allowPanningOnScrollingParent: false,
              plugins: [
                DragMarkerPlugin(),
              ],
              zoom: Dimensions.zoom,
              minZoom: Dimensions.minZoom,
              maxZoom: Dimensions.maxZoom,
              interactiveFlags:
                  InteractiveFlag.pinchZoom | InteractiveFlag.drag,
              onPositionChanged: (MapPosition position, bool hasGesture) {
                if (hasGesture) {
                  setState(
                    () =>
                        _centerOnLocationUpdate = CenterOnLocationUpdate.never,
                  );
                }
              },
              center: LatLng(
                productSearchNotifier.filterLat,
                productSearchNotifier.filterLon,
              ),
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
            layers: [
              TileLayerOptions(
                tileProvider: NetworkTileProvider(),
                urlTemplate:
                    "http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}",
                subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],
              ),
              DragMarkerPluginOptions(
                markers: [
                  DragMarker(
                    point: LatLng(
                      productSearchNotifier.filterLat,
                      productSearchNotifier.filterLon,
                    ),
                    width: 80.0,
                    height: 80.0,
                    builder: (ctx) => const Icon(
                      Icons.location_on,
                      size: 50,
                      color: Color(0xffCD261F),
                    ),
                    onDragEnd: (details, point) {
                      print('Finished Drag $details $point');
                      productSearchNotifier.setFilterPosition(
                          lat: point.latitude, lon: point.longitude);
                    },
                    updateMapNearEdge: false,
                    rotateMarker: true,
                  )
                ],
              ),
              // CircleRegion(
              //   LatLng(
              //     productSearchNotifier.filterLat,
              //     productSearchNotifier.filterLon,
              //   ),
              //   productSearchNotifier.searchResult != null
              //       ? productSearchNotifier.searchResult!.range.toDouble()
              //       : 10,
              // ).toDrawable(
              //   fillColor: AppColors.primaryColor.withOpacity(0.5),
              // ),
            ],
          ),
          // Positioned(
          //   bottom: 100,
          //   left: 20,
          //   right: 0,
          //   child: Container(
          //     padding: const EdgeInsets.all(20),
          //     height: 30,
          //     decoration: BoxDecoration(
          //       shape: BoxShape.rectangle,
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //     child: const Text(
          //       "Move Marker to specify location",
          //       style: TextStyle(
          //           color: AppColors.primaryColor,
          //           fontSize: 14,
          //           fontWeight: FontWeight.w500),
          //     ),
          //   ),
          // ),
          MapSearchTermContainer(
              searchTerm: widget.searchTerm,
              onMinChanged: productSearchNotifier.onMinPriceChanged,
              onMaxChanged: productSearchNotifier.onMaxPriceChanged,
              onSliderChanged: (newValue) =>
                  productSearchNotifier.onSliderChanged(newValue),
              sliderValue: productSearchNotifier.sliderValue,
              onApplyPressed: () async {
                if (productSearchNotifier.minPrice! >=
                    productSearchNotifier.maxPrice!) {
                  Alertify(
                          title:
                              'Minimum price should not be greater than maximum price.')
                      .error();
                } else {
                  Loader(context).showLoader(text: 'Loading');
                  await productSearchNotifier.fetchProductSearch(
                    searchTerm: widget.searchTerm,
                    isConfirmButton: false,
                  );
                  if (productSearchNotifier.searchResult!.result.isEmpty) {
                    Alertify(
                            title:
                                'The searched product is not available in this area.')
                        .error();
                    Loader(context).hideLoader();
                    ref.read(navigationServiceProvider).navigateBack();
                  } else {
                    Loader(context).hideLoader();
                    ref.read(navigationServiceProvider).navigateToNamed(
                          Routes.productSearchResult,
                          arguments: SearchResultArgModel(
                            filterPosition: LatLng(
                              productSearchNotifier.filterLat,
                              productSearchNotifier.filterLon,
                            ),
                            radius: productSearchNotifier.sliderValue,
                            searchResult: productSearchNotifier.searchResult!,
                            searchTerm: widget.searchTerm,
                          ),
                        );
                  }
                }
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Automatically center the location marker on the map when location updated until user interact with the map.
          setState(
            () => _centerOnLocationUpdate = CenterOnLocationUpdate.always,
          );
          // Center the location marker on the map and zoom the map to level 18.
          _centerCurrentLocationStreamController.add(Dimensions.zoom);
        },
        child: const Icon(Icons.my_location, color: Colors.white, size: 30),
      ),
    );
  }
}

class SearchProductBottomSheet extends StatelessWidget {
  const SearchProductBottomSheet({
    Key? key,
    required this.onConfirmPressed,
  }) : super(key: key);

  final void Function()? onConfirmPressed;

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
      child: AppButton(
        text: 'Confirm location to search',
        backgroundColor: AppColors.primaryColor,
        onPressed: onConfirmPressed,
      ),
    );
  }
}
