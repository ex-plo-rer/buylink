import 'dart:async';

import 'package:buy_link/widgets/app_search_dialog.dart';
import 'package:buy_link/widgets/app_text_field.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/routes.dart';
import '../../../../services/navigation_service.dart';
import '../../../../widgets/app_button.dart';
import '../../notifiers/store_notifier/input_search_location_notifier.dart';

class InputSearchLocation extends ConsumerStatefulWidget {
  const InputSearchLocation({Key? key}) : super(key: key);

  @override
  _InputSearchLocationState createState() => _InputSearchLocationState();
}
class _InputSearchLocationState extends ConsumerState {

  final searchFocus = FocusNode();
  final searchController = TextEditingController();
  late CenterOnLocationUpdate _centerOnLocationUpdate;

  late StreamController<double> _centerCurrentLocationStreamController;

  @override
  void initState() {
    super.initState();
    _centerOnLocationUpdate = CenterOnLocationUpdate.always;
    _centerCurrentLocationStreamController = StreamController<double>();
  }

  @override
  void dispose() {
    _centerCurrentLocationStreamController.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final productSearch = ref.watch(inputSearchLocationNotifierProvider);

    return Scaffold(
        bottomSheet: BottomSheet(
          onClosing: () {
          },
          builder: (context) {
            return SingleChildScrollView(child: Container (
             height: 90,
                padding: EdgeInsets.all(20) ,

                decoration: BoxDecoration(shape: BoxShape.rectangle,  borderRadius: BorderRadius.circular(15), color: AppColors.light),

                child:

                AppButton (text: 'Confirm Location', textColor: AppColors.light,
                    backgroundColor: AppColors.primaryColor, onPressed: () async  {

                    ref
                        .read(navigationServiceProvider)
                        .navigateToNamed(Routes.productSearchedResult);

  await productSearch.fetchProductSearch(
                      search_term: "apple", lon: 3.71, lat: 3.406, range: 5, min_price: 0,
            max_price: 10000000000);
                  ref
                      .read(navigationServiceProvider)
                      .navigateToNamed(Routes.productSearchedResult);

                  },
                height: 50,)
            ));
          },
        ),

        body: Stack (children: <Widget>[

          FlutterMap(
            options:
            MapOptions(

              onPositionChanged: (MapPosition position, bool hasGesture) {
                if (hasGesture) {
                  setState(
                        () => _centerOnLocationUpdate = CenterOnLocationUpdate.never,
                  );
                }
              },
              bounds: LatLngBounds(LatLng(58.8, 6.1), LatLng(59, 6.2)),
              boundsOptions:
              const FitBoundsOptions(padding: EdgeInsets.all(8.0)),
            ),
            children: [TileLayerWidget(
              options: TileLayerOptions(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
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
                bottom: 200,
                child: FloatingActionButton(
                  onPressed: () {
                    // Automatically center the location marker on the map when location updated until user interact with the map.
                    setState(
                          () => _centerOnLocationUpdate = CenterOnLocationUpdate.always,
                    );
                    // Center the location marker on the map and zoom the map to level 18.
                    _centerCurrentLocationStreamController.add(18);
                  },
                  child: const Icon(
                    Icons.my_location,
                    color: Colors.white,
                    size: 30
                  ),
                ),
              )
            ],
            layers: [
              TileLayerOptions(
                urlTemplate:
                "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
                attributionBuilder: (_) {
                  return const Text("Got more work to do...");
                },
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: LatLng(51.5, -0.09),
                    builder: (ctx) => Container(
                      child: const FlutterLogo(size: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),

          Positioned (
            bottom: 100,
            left: 20,
            right: 0,
            child:
            Container (
              padding: EdgeInsets.all(20),
              height: 30,
              decoration: BoxDecoration(shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10), ),
              child:
              Text( "Move Marker to specify location" , style:
              TextStyle(color: AppColors.primaryColor, fontSize: 14, fontWeight: FontWeight.w500),),),

          ),
          Container (
              margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(shape: BoxShape.rectangle,  borderRadius: BorderRadius.circular(15), color: AppColors.light),
              child: Row (children: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_outlined,
                    size: 12,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                Spacing.smallWidth(),
                Container (
                    width: 210,
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '',
                      ),
                    )),
                Spacing.mediumWidth(),



                Container (
                  height: 40 ,
                  width: 40,
                  decoration: BoxDecoration(color: AppColors.shade1, shape: BoxShape.rectangle,  borderRadius: BorderRadius.circular(10), )
                  ,child: GestureDetector(onTap: (){
                  showDialog(context: context,
                      builder: (BuildContext context)
                      {
                        return AppSearchDialog(onClearFilter: () {  },
                            onChangedMin: (String ) {  },
                            onChanged: (double ) {  },
                            value: 2, onChangedMax: (String ) {  });
                      }
                  );
                }, child: Image.asset ("assets/images/filter.png")),

                )

              ])),





        ])


    );

  }

  }