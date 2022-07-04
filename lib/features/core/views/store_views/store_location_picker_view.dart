import 'dart:async';

import 'package:buy_link/services/location_service.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_dragmarker/dragmarker.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/back_arrow.dart';
import '../../notifiers/store_notifier/store_location_picker_notifier.dart';

class StoreLocationPicker extends ConsumerStatefulWidget {
  const StoreLocationPicker({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<StoreLocationPicker> createState() =>
      _StoreLocationPickerState();
}

class _StoreLocationPickerState extends ConsumerState<StoreLocationPicker> {
  final searchFocus = FocusNode();
  final searchController = TextEditingController();
  late CenterOnLocationUpdate _centerOnLocationUpdate;

  late StreamController<double> _centerCurrentLocationStreamController;

  @override
  void initState() {
    super.initState();
    // ref.read(storeDirectionNotifierProvider).initLocation();
    ref.read(storeLocationPickerNotifierProvider).initLocation();
    ref.read(storeLocationPickerNotifierProvider).startTimer();
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
    final storeLocationPickerNotifier =
        ref.watch(storeLocationPickerNotifierProvider);

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
                ref.read(navigationServiceProvider).navigateBack();
              },
            ),
          );
        },
      ),
      body: SafeArea(
        child: Stack(
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
                      () => _centerOnLocationUpdate =
                          CenterOnLocationUpdate.never,
                    );
                  }
                },
                center: LatLng(
                  storeLocationPickerNotifier.storeLat,
                  storeLocationPickerNotifier.storeLon,
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
                        storeLocationPickerNotifier.storeLat,
                        storeLocationPickerNotifier.storeLon,
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
                        storeLocationPickerNotifier.setStorePosition(
                          lat: point.latitude,
                          lon: point.longitude,
                        );
                      },
                      updateMapNearEdge: false,
                      rotateMarker: true,
                    )
                  ],
                ),
              ],
            ),
            if (storeLocationPickerNotifier.showInstruction)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: AppButton(
                      height: 41,
                      width: MediaQuery.of(context).size.width - 100,
                      text: 'Place the Red Marker above your store',
                      fontSize: 14,
                      backgroundColor: AppColors.grey4,
                    ),
                  ),
                ],
              ),
            const BackArrow()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Automatically center the location marker on the map when location updated until user interact with the map.
          setState(
            () => _centerOnLocationUpdate = CenterOnLocationUpdate.always,
          );
          // Center the location marker on the map and zoom the map to level 18.
          _centerCurrentLocationStreamController.add(Dimensions.zoom);
          ref.read(locationService).getCurrentLocation();
          storeLocationPickerNotifier.setStorePosition(
            lat: ref.read(locationService).lat!,
            lon: ref.read(locationService).lon!,
          );
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
        text: 'Confirm store location',
        backgroundColor: AppColors.primaryColor,
        onPressed: onConfirmPressed,
      ),
    );
  }
}
