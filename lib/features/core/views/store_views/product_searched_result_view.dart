import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/widgets/search_result_stores_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_dragmarker/dragmarker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/constants/colors.dart';
import '../../../../widgets/circular_progress.dart';
import '../../../../widgets/map_search_dialog.dart';
import '../../../../widgets/spacing.dart';
import '../../notifiers/home_notifier.dart';
import '../../notifiers/store_notifier/product_search_notifier.dart';
import '../../notifiers/store_notifier/product_searched_result_notifier.dart';

class ProductSearchedResultView extends ConsumerStatefulWidget {
  const ProductSearchedResultView({Key? key}) : super(key: key);

  @override
  _ProductSearchedResultViewState createState() =>
      _ProductSearchedResultViewState();
}

class _ProductSearchedResultViewState extends ConsumerState {
  final _scrollController = DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
    final productSearchNotifier = ref.watch(productSearchNotifierProvider);

    return Scaffold(
        body: Stack(children: <Widget>[
      FlutterMap(
        options: MapOptions(
          bounds: LatLngBounds(LatLng(58.8, 6.1), LatLng(59, 6.2)),
          boundsOptions: const FitBoundsOptions(padding: EdgeInsets.all(8.0)),
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
            attributionBuilder: (_) {
              return const Text("Got more work to do...");
            },
          ),

          // DragMarkerPluginOptions(
          //   markers: [
          //     DragMarker(
          //         point: LatLng(45.2131, -122.6765),
          //         width: 80.0,
          //         height: 80.0,
          //         offset: Offset(0.0, -8.0),
          //         builder: (ctx) =>
          //             Container(child: Icon(Icons.location_on, size: 50)),
          //         onDragStart: (details, point) =>
          //             print("Start point $point"),
          //         onDragEnd: (details, point) =>
          //             print("End point $point"),
          //         onDragUpdate: (details, point) {},
          //         onTap: (point) {
          //           print("on tap");
          //         },
          //         onLongPress: (point) {
          //           print("on long press");
          //         },
          //         feedbackBuilder: (ctx) => Container(
          //             child: Icon(Icons.edit_location, size: 75)),
          //         feedbackOffset: Offset(0.0, -18.0),
          //         updateMapNearEdge: true,
          //         nearEdgeRatio: 2.0,
          //         nearEdgeSpeed: 1.0,
          //         rotateMarker: true),
          //     DragMarker(
          //         point: LatLng(45.535, -122.675),
          //         width: 80.0,
          //         height: 80.0,
          //         builder: (ctx) =>
          //             Container(child: Icon(Icons.location_on, size: 50)),
          //         onDragEnd: (details, point) {
          //           print('Finished Drag $details $point');
          //         },
          //         updateMapNearEdge: false,
          //         rotateMarker: true)
          //   ],
          // ),

          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(51.5, -0.09),
                builder: (ctx) => Container(
                  child: const FlutterLogo(),
                ),
              ),
            ],
          ),
        ],
      ),
      Container(
        margin: EdgeInsets.fromLTRB(20, 40, 16, 0),
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(15),
            color: AppColors.light),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
                size: 12,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            Text("Mokola",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey)),
            Spacing.smallWidth(),
            Container(
              height: 20,
              width: 1,
              color: AppColors.grey6,
            ),
            Spacing.smallWidth(),
            Text(
              "Black Shirt",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.grey),
            ),
            Spacing.largeWidth(),
            Spacing.largeWidth(),
            Spacing.largeWidth(),
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
                            onMinChanged: (String) {},
                            onSliderChanged: (double) {},
                            value: 2,
                            onMaxChanged: (String) {},
                            onApplyPressed: () {},
                          );
                        });
                  },
                  child: Image.asset("assets/images/filter.png")),
            ),
          ],
        ),
      ),
      DraggableScrollableSheet(
        controller: _scrollController,
        minChildSize: 0.1,
        maxChildSize: 0.9,
        initialChildSize: 0.3,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                color: AppColors.light),
            padding: EdgeInsets.fromLTRB(14, 0, 14, 0),
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),

                        // productSearchNotifier.state.isLoading
                        //     ? const CircularProgress()
                        //     :
                        // productSearchNotifier..isEmpty
                        //     ? Text ("No result found")
                        //     :

                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            controller: scrollController,
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int index) {
                              return Text("I can");
                              // SearchResultContainer(url: "https://api.buylink.app/img/products/apple-2-ii.jpg",
                              //       storeName: productSearchNotifier.searchresult"",
                              //       productName: productSearchNotifier.searchresult[index].name,
                              //       productPrice: productSearchNotifier.searchresult[index].price,
                              //       distance: productSearchNotifier.searchresult[index].store.location,
                              //       isFavorite: false);
                            }),
                      ],
                    ),
                  ),
                ),
                IgnorePointer(
                  child: Container(
                    height: 40,
                    color: AppColors.light,
                    child: Center(
                        child: Column(children: <Widget>[
                      Spacing.tinyHeight(),
                      SizedBox(
                        width: 24,
                        child: Divider(
                          thickness: 3,
                          color: AppColors.grey7,
                        ),
                      ),
                      Text(
                        " stores found",
                        style: TextStyle(
                            color: AppColors.grey1,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ])),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ]));
  }
}
