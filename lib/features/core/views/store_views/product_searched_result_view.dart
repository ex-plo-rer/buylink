import 'package:buy_link/widgets/search_result_stores_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/constants/colors.dart';
import '../../../../widgets/app_search_dialog.dart';
import '../../../../widgets/spacing.dart';
import '../../notifiers/home_notifier.dart';

class ProductSearchedResultView extends ConsumerStatefulWidget {
  const ProductSearchedResultView({Key? key}) : super(key: key);

  @override
  _ProductSearchedResultViewState createState() => _ProductSearchedResultViewState();
}
class _ProductSearchedResultViewState extends ConsumerState {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack (children: <Widget>[
          FlutterMap(
            options:
            MapOptions(
              bounds: LatLngBounds(LatLng(58.8, 6.1), LatLng(59, 6.2)),
              boundsOptions:
              const FitBoundsOptions(padding: EdgeInsets.all(8.0)),
            ),
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
                      child: const FlutterLogo(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container (
            margin: EdgeInsets.fromLTRB(20, 40, 16, 0),
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
              Text("Mokola", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.grey)),
              Spacing.smallWidth(),
              Container(
                height: 20,
                width: 1,
                color: AppColors.grey6,
              ),
              Spacing.smallWidth(),
              Text("Black Shirt", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.grey),),
              Spacing.largeWidth(),
              Spacing.largeWidth(),
              Spacing.largeWidth(),
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
              ),
            ],),),

          DraggableScrollableSheet(
            minChildSize: 0.1,
            maxChildSize: 0.9,
            initialChildSize: 0.3,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(shape: BoxShape.rectangle,  borderRadius: BorderRadius.circular(20), color: AppColors.light),
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
                            ...List.generate(
                                10,
                                    (index) => SearchResultContainer(url: "https://api.buylink.app/img/products/apple-2-ii.jpg",
                                    storeName: "Atinuke Store",
                                    productName: "Black Shirt",
                                    productPrice: 12000,
                                    distance: "1.2",
                                    isFavorite: false)
                            ),
                          ],
                        ),
                      ),),
                    IgnorePointer(
                      child: Container(
                        height: 40,
                        color: AppColors.light,
                        child:Center (child:Column(children:<Widget>[

                          Spacing.tinyHeight(),
                          SizedBox(
                            width: 24,
                            child: Divider(
                              thickness: 3,
                              color: AppColors.grey7,
                            ),
                          ),
                          Text ("20 stores found",
                            style: TextStyle(color: AppColors.grey1, fontSize: 12, fontWeight: FontWeight.w500),),
                        ])),
                      ),
                    ),

                  ],),);
            },
          ),
        ])
    );}}