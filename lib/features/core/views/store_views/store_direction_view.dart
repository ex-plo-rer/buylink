import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/utilities/extensions/strings.dart';
import 'package:buy_link/core/utilities/map/circle.dart';
import 'package:buy_link/features/core/notifiers/store_notifier/store_direction_notifier.dart';
import 'package:buy_link/services/location_service.dart';
import 'package:buy_link/widgets/back_arrow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/svgs.dart';
import '../../../../widgets/distance_container.dart';
import '../../../../widgets/favorite_container.dart';
import '../../../../widgets/spacing.dart';
import '../../models/product_model.dart';

class StoreDirectionView extends ConsumerStatefulWidget {
  const StoreDirectionView({
    Key? key,
    required this.store,
  }) : super(key: key);
  final Store store;

  @override
  ConsumerState<StoreDirectionView> createState() => _StoreDirectionViewState();
}

class _StoreDirectionViewState extends ConsumerState<StoreDirectionView> {
  MapController? mapController;

  @override
  void initState() {
    // TODO: implement initState
    mapController = MapController();
    ref
        .read(storeDirectionNotifierProvider)
        .getLocationUpdate(); // TODO: Replace with live uppppp (comment out)
    // init();
    super.initState();
  }

  @override
  void dispose() {
    ref.read(locationService).updateLocationAfterLeavingMap(
          newLat: ref.read(storeDirectionNotifierProvider).userLat!,
          newLon: ref.read(storeDirectionNotifierProvider).userLon!,
        );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final storeDirNotifier = ref.watch(storeDirectionNotifierProvider);
    return SafeArea(
      child: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                height:
                    (constraints.maxHeight / 2) + (constraints.maxHeight / 4),
                child: FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    zoom: Dimensions.zoom,
                    minZoom: Dimensions.minZoom,
                    maxZoom: Dimensions.maxZoom,
                    interactiveFlags:
                        InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                    center:
                        // LatLng(8.17, 4.26),
                        LatLng(
                      storeDirNotifier.userLat ?? 8.17,
                      storeDirNotifier.userLon ?? 4.26,
                    ),
                    // bounds: LatLngBounds(LatLng(8.17, 4.26), LatLng(8.27, 4.36)),
                    boundsOptions:
                        const FitBoundsOptions(padding: EdgeInsets.all(8.0)),
                    // onPositionChanged: (position, hasGesture) {},
                  ),
                  layers: [
                    TileLayerOptions(
                      tileProvider: NetworkTileProvider(),
                      urlTemplate:
                          "http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}",
                      subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],
                      attributionBuilder: (_) {
                        return Text(
                          "Testing purpose... ${storeDirNotifier.userLat}, ${ref.read(locationService).getDist(
                                // startLat: ref
                                //     .watch(storeDirectionNotifierProvider)
                                //     .userLat!,
                                // startLon: ref
                                //     .watch(storeDirectionNotifierProvider)
                                //     .userLon!,
                                endLat: widget.store.lat,
                                endLon: widget.store.lon,
                              )}",
                          style: TextStyle(fontSize: 15),
                        );
                      },
                    ),
                    CircleRegion(
                            LatLng(storeDirNotifier.userLat ?? 8.17,
                                storeDirNotifier.userLon ?? 4.26),
                            10)
                        .toDrawable(
                      fillColor: AppColors.primaryColor.withOpacity(0.5),
                    ),
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                          point: LatLng(storeDirNotifier.userLat ?? 8.17,
                              storeDirNotifier.userLon ?? 4.26),
                          width: 50.0,
                          height: 50.0,
                          builder: (ctx) => SvgPicture.asset(AppSvgs.redMarker),
                        ),
                        Marker(
                          point: LatLng(widget.store.lat, widget.store.lon),
                          width: 50.0,
                          height: 50.0,
                          builder: (ctx) =>
                              SvgPicture.asset(AppSvgs.blueMarker),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          DraggableScrollableSheet(
              initialChildSize: 0.40,
              minChildSize: 0.26,
              maxChildSize: 0.5,
              builder: (context, scrollController) {
                return StoreDirectionBottomSheet(
                  scrollController: scrollController,
                  distance: ref.read(locationService).getDist(
                        endLat: widget.store.lat,
                        endLon: widget.store.lon,
                      ),
                  // storeRating: widget.store.star,
                  storeRating: ''.extractDouble(widget.store.star),
                  storeName: widget.store.name,
                  storeImage: widget.store.logo,
                );
              }),
          const BackArrow(),
        ],
      ),
    );
  }
}

class StoreDirectionBottomSheet extends StatelessWidget {
  const StoreDirectionBottomSheet({
    Key? key,
    required this.distance,
    // required this.normalDistance,
    required this.storeRating,
    required this.storeName,
    required this.storeImage,
    required this.scrollController,
  }) : super(key: key);
  final String distance;

  // final String normalDistance;
  final String storeRating;
  final String storeName;
  final String storeImage;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: AppColors.transparent,
        ),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: AppColors.light,
          ),
          // height: 200,
          child: Expanded(
            child: ListView(
              controller: scrollController,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      width: 28,
                      child: Divider(
                        thickness: 3,
                        color: AppColors.grey7,
                      ),
                    ),
                    const Spacing.mediumHeight(),
                    const Text(
                      'Estimated Distance',
                      style: TextStyle(
                        color: AppColors.grey5,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    const Spacing.tinyHeight(),
                    Text(
                      '$distance km',
                      style: const TextStyle(
                        color: AppColors.grey1,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    // const Spacing.smallHeight(),
                    ListTile(
                      horizontalTitleGap: 8,
                      dense: false,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 20),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: CachedNetworkImageProvider(storeImage),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              storeName,
                              style: const TextStyle(
                                color: AppColors.grey4,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacing.smallWidth(),
                            SvgPicture.asset(AppSvgs.starFilled),
                            const Spacing.tinyWidth(),
                            Text(
                              '$storeRating',
                              style: const TextStyle(
                                color: AppColors.grey4,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          DistanceContainer(
                            distance: distance,
                            containerColor: AppColors.grey1,
                            textColor: AppColors.light,
                            iconColor: AppColors.light,
                          ),
                          Container(),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FavoriteContainer(
                            height: 32,
                            width: 32,
                            padding: 7,
                            favIcon: SvgPicture.asset(AppSvgs.telephone),
                            hasBorder: true,
                          ),
                          Spacing.smallWidth(),
                          FavoriteContainer(
                            height: 32,
                            width: 32,
                            padding: 7,
                            favIcon: SvgPicture.asset(AppSvgs.envelope,
                                color: AppColors.primaryColor),
                            hasBorder: true,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // height: 120,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        color: AppColors.light,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 18,
                              left: 16,
                              bottom: 4,
                            ),
                            child: Row(
                              children: [
                                const FavoriteContainer(
                                  favIcon: Icon(
                                    Icons.location_on_rounded,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'From',
                                      style: TextStyle(
                                        color: AppColors.shade5,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Spacing.smallHeight(),
                                    Text(
                                      'You',
                                      style: TextStyle(
                                        color: AppColors.grey2,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 60,
                            child: const Divider(thickness: 2),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                              left: 16,
                              bottom: 16,
                            ),
                            child: Row(
                              children: [
                                const FavoriteContainer(
                                  favIcon: Icon(
                                    Icons.location_on_rounded,
                                    color: AppColors.red,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'To',
                                      style: TextStyle(
                                        color: AppColors.red,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Spacing.smallHeight(),
                                    Text(
                                      storeName,
                                      style: const TextStyle(
                                        color: AppColors.grey2,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacing.height(20),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //     vertical: 20,
                    //     horizontal: 20,
                    //   ),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       const Text(
                    //         'Directions',
                    //         style: TextStyle(
                    //           color: AppColors.grey1,
                    //           fontSize: 12,
                    //           fontWeight: FontWeight.w600,
                    //         ),
                    //       ),
                    //       const Spacing.smallHeight(),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Row(
                    //             children: [
                    //               const Icon(
                    //                 Icons.arrow_back_outlined,
                    //                 size: 14,
                    //               ),
                    //               const Spacing.smallWidth(),
                    //               const Text(
                    //                 'Turn right onto Emotan Lane',
                    //                 style: TextStyle(
                    //                   color: AppColors.grey1,
                    //                   fontSize: 12,
                    //                   fontWeight: FontWeight.w600,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //           const Text(
                    //             '250 m',
                    //             style: TextStyle(
                    //               color: AppColors.grey1,
                    //               fontSize: 12,
                    //               fontWeight: FontWeight.w600,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
