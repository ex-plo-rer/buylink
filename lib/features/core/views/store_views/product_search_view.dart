import 'dart:async';

import 'package:buy_link/widgets/app_search_dialog.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_dragmarker/dragmarker.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/constants/colors.dart';
import '../../../../widgets/app_button.dart';
import '../../notifiers/store_notifier/product_search_notifier.dart';

class ProductSearchView extends ConsumerStatefulWidget {
  const ProductSearchView({Key? key, required this.searchTerm,}) : super(key: key);
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
    // init();
  }

  @override
  void dispose() {
    _centerCurrentLocationStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputSearchNotifier = ref.watch(productSearchNotifierProvider);

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
            child: SearchProductBottomSheet(),
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
              zoom: 13,
              onPositionChanged: (MapPosition position, bool hasGesture) {
                if (hasGesture) {
                  setState(
                    () =>
                        _centerOnLocationUpdate = CenterOnLocationUpdate.never,
                  );
                }
              },
              center: LatLng(
                inputSearchNotifier.filterLat,
                inputSearchNotifier.filterLon,
              ),
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
            // nonRotatedChildren: [
            //   Positioned(
            //     right: 20,
            //     bottom: 100,
            //     child: FloatingActionButton(
            //       onPressed: () {
            //         // Automatically center the location marker on the map when location updated until user interact with the map.
            //         setState(
            //           () => _centerOnLocationUpdate =
            //               CenterOnLocationUpdate.always,
            //         );
            //         // Center the location marker on the map and zoom the map to level 18.
            //         _centerCurrentLocationStreamController.add(18);
            //       },
            //       child: const Icon(Icons.my_location,
            //           color: Colors.white, size: 30),
            //     ),
            //   )
            // ],
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
                // attributionBuilder: (_) {
                //   return const Text("Got more work to do...");
                // },
              ),
              // MarkerLayerOptions(
              //   markers: [
              //     Marker(
              //       width: 30.33,
              //       height: 43.33,
              //       point: LatLng(
              //         inputSearchNotifier.filterLat ?? 8.17,
              //         inputSearchNotifier.filterLon ?? 4.26,
              //       ),
              //       builder: (ctx) => const Icon(
              //         Icons.location_pin,
              //         color: Color(0xffCD261F),
              //       ),
              //     ),
              //   ],
              // ),
              DragMarkerPluginOptions(
                markers: [
                  DragMarker(
                    point: LatLng(
                      inputSearchNotifier.filterLat,
                      inputSearchNotifier.filterLon,
                    ),
                    width: 80.0,
                    height: 80.0,
                    builder: (ctx) => Icon(
                      Icons.location_on,
                      size: 50,
                      color: Color(0xffCD261F),
                    ),
                    onDragEnd: (details, point) {
                      print('Finished Drag $details $point');
                      inputSearchNotifier.setFilterPosition(
                          lat: point.latitude, lon: point.longitude);
                    },
                    updateMapNearEdge: false,
                    rotateMarker: true,
                  )
                ],
              ),
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
          Container(
            height: 60,
            margin: const EdgeInsets.fromLTRB(10, 40, 10, 0),
            padding: const EdgeInsets.fromLTRB(4, 10, 13, 10),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15),
              color: AppColors.light,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_outlined,
                    size: 12,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                const Spacing.smallWidth(),
                // const SizedBox(
                //   width: 210,
                //   child: TextField(
                //     decoration: InputDecoration(
                //       border: InputBorder.none,
                //       hintText: 'Searching item',
                //     ),
                //   ),
                // ),
                Expanded(child: Text(widget.searchTerm)),
                const Spacing.mediumWidth(),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppColors.shade1,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AppSearchDialog(
                            onClearFilter: () {},
                            onMinChanged: inputSearchNotifier.onMinPriceChanged,
                            onMaxChanged: inputSearchNotifier.onMaxPriceChanged,
                            onSliderChanged: (newValue) =>
                                inputSearchNotifier.onSliderChanged(newValue),
                            value: inputSearchNotifier.sliderValue,
                            sliderLabel: '',
                          );
                        },
                      );
                    },
                    child: Image.asset("assets/images/filter.png"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Automatically center the location marker on the map when location updated until user interact with the map.
          setState(
            () => _centerOnLocationUpdate = CenterOnLocationUpdate.always,
          );
          // Center the location marker on the map and zoom the map to level 18.
          _centerCurrentLocationStreamController.add(18);
        },
        child: const Icon(Icons.my_location, color: Colors.white, size: 30),
      ),
    );
  }
}

class SearchProductBottomSheet extends StatelessWidget {
  const SearchProductBottomSheet({
    Key? key,
  }) : super(key: key);

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
      child: const AppButton(
        text: 'Confirm Location',
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }
}
