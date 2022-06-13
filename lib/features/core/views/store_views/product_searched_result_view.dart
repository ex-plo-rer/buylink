import 'package:buy_link/widgets/app_search_dialog.dart';
import 'package:buy_link/widgets/app_text_field.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


import '../../../../core/constants/colors.dart';


class ProductSearchedResult extends ConsumerStatefulWidget {
  const ProductSearchedResult({Key? key}) : super(key: key);

  @override
  _ProductSearchedResultState createState() => _ProductSearchedResultState();
}
class _ProductSearchedResultState extends ConsumerState {
   final searchFocus = FocusNode();
   final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        bottomSheet: BottomSheet(
          enableDrag: true,
          onClosing: () {  },
          backgroundColor: AppColors.transparent,
          // barrierColor: AppColors.grey4,
          // expand: true,
          builder: (context) =>
              SingleChildScrollView(
            controller: ModalScrollController.of(context),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: AppColors.light,
              ),
              // height: 200,
              child: Column(
                children: [
                  // const SizedBox(
                  //   width: 28,
                  //   child: Divider(
                  //     thickness: 3,
                  //     color: AppColors.grey7,
                  //   ),
                  // ),
                 // Spacing.smallHeight(),
     Container (
       height: 80,
         child:
                  AppTextField(
                    hintText: 'Enter your location',
                    onTap: () async {},
                    prefixIcon: const Icon(Icons.search_outlined),
                    hasBorder: false,
                    isSearch: true,
                    fillColor: AppColors.grey8,
                    focusNode: searchFocus,
                    controller: searchController ,
                  )),

                Align(
                    alignment: Alignment.topLeft,
                    child:  Text ("Use Current Location", style: TextStyle(fontSize: 12,
                        fontWeight: FontWeight.w600, color: AppColors.grey5 ))),
              Align(
                alignment: Alignment.topLeft,
                child:  Text("Mokola", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.grey1, ),)),

                Spacing.smallHeight(),
                  Align(
                alignment: Alignment.topLeft,
                child:  Text ("Recent Search")),
                  Row (children: <Widget>[
                    Text ("Sango"),
                    IconButton(icon: Icon(Icons.cancel_outlined), onPressed: (){

                    },)

                  ],),

                  Row (
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                    Text ("Dugbe"),
                    IconButton(icon: Icon(Icons.cancel_outlined), onPressed: (){

                    },)

                  ],),

                  Row (children: <Widget>[
                    Text ("University of Ibadan"),
                    IconButton(icon: Icon(Icons.cancel_outlined), onPressed: (){

                    },)

                  ],)
                ],
              ),
            ),
          ),
        ),

      body: Stack (children: <Widget>[

        FlutterMap(
          options:
          // MapOptions(
          //   center: LatLng(51.5, -0.09),
          //   zoom: 13.0,
          // ),
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
            margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(shape: BoxShape.rectangle,  borderRadius: BorderRadius.circular(15), color: AppColors.light),
              child: Row (children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
                size: 15,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            Spacing.smallWidth(),

            Container (
                width: 210,
                child: TextField(


            )),
            Spacing.mediumWidth(),

            Container (
              height: 40 ,
              width: 40,
              decoration: BoxDecoration(color: AppColors.shade3, shape: BoxShape.rectangle,  borderRadius: BorderRadius.circular(10), )
              ,child: IconButton(icon: Icon(Icons.filter_list), onPressed: () {
                showDialog(context: context,
                builder: (BuildContext context)
                {
                  return AppSearchDialog(onClearFilter: () {  },
                  onChangedMin: (String ) {  },
                onChanged: (double ) {  },
                value: 2, onChangedMax: (String ) {  });
                }
                );
            },),
    )

          ])),])


    );

  }
}
