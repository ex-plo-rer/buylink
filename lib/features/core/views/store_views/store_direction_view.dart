import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/widgets/back_arrow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../core/constants/svgs.dart';
import '../../../../widgets/distance_container.dart';
import '../../../../widgets/favorite_container.dart';
import '../../../../widgets/spacing.dart';

class StoreDirectionView extends ConsumerStatefulWidget {
  const StoreDirectionView({Key? key}) : super(key: key);

  @override
  _StoreDirectionViewState createState() => _StoreDirectionViewState();
}

class _StoreDirectionViewState extends ConsumerState {
  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  init() async {
    await Future.delayed(const Duration(seconds: 1));
    showMaterialModalBottomSheet(
      backgroundColor: AppColors.transparent,
      // barrierColor: AppColors.grey4,
      // expand: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Container(
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
              const SizedBox(
                width: 28,
                child: Divider(
                  thickness: 3,
                  color: AppColors.grey7,
                ),
              ),
              const Spacing.mediumHeight(),
              const Text(
                'Estimated Time',
                style: TextStyle(
                  color: AppColors.grey5,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              const Spacing.tinyHeight(),
              const Text(
                '20 mins',
                style: TextStyle(
                  color: AppColors.grey1,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              // const Spacing.smallHeight(),
              ListTile(
                horizontalTitleGap: 8,
                dense: false,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                leading: const CircleAvatar(radius: 30),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Atinuke Stores',
                        style: TextStyle(
                          color: AppColors.grey4,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacing.smallWidth(),
                      SvgPicture.asset(AppSvgs.favoriteFilled),
                      const Spacing.tinyWidth(),
                      const Text(
                        '4.6',
                        style: TextStyle(
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
                    const DistanceContainer(
                      distance: '4.3',
                      containerColor: AppColors.grey1,
                      textColor: AppColors.light,
                      iconColor: AppColors.light,
                    ),
                    Container(),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    FavoriteContainer(
                      height: 32,
                      width: 32,
                      padding: 7,
                      favIcon: Icon(
                        Icons.add_ic_call_outlined,
                        size: 16,
                      ),
                      hasBorder: true,
                    ),
                    Spacing.smallWidth(),
                    FavoriteContainer(
                      height: 32,
                      width: 32,
                      padding: 7,
                      favIcon: Icon(
                        Icons.mail_outline_outlined,
                        size: 16,
                      ),
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
                      offset: const Offset(0, 3), // changes position of shadow
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
                                'Onireke Street',
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
                            children: const [
                              Text(
                                'To',
                                style: TextStyle(
                                  color: AppColors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacing.smallHeight(),
                              Text(
                                'Shop 3, Maxdot, Ikeja, Lagos',
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
                  ],
                ),
              ),
              const Spacing.height(20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Directions',
                      style: TextStyle(
                        color: AppColors.grey1,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacing.smallHeight(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.arrow_back_outlined,
                              size: 14,
                            ),
                            const Spacing.smallWidth(),
                            const Text(
                              'Turn right onto Emotan Lane',
                              style: TextStyle(
                                color: AppColors.grey1,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          '250 m',
                          style: TextStyle(
                            color: AppColors.grey1,
                            fontSize: 12,
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          FlutterMap(
            options:
                // MapOptions(
                //   center: LatLng(51.5, -0.09),
                //   zoom: 13.0,
                // ),
                MapOptions(
              bounds: LatLngBounds(LatLng(8.17, 4.26), LatLng(8.27, 4.36)),
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
                    point: LatLng(8.17, 4.26),
                    builder: (ctx) => Container(
                      child: const FlutterLogo(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const BackArrow(),
        ],
      ),
    );
  }
}
