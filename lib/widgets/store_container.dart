import 'package:buy_link/features/core/views/store_views/store_dashboard_view.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/constants/colors.dart';

class StoreContainer extends ConsumerWidget {
  final String storeImage;
  final String storeName;
  final int starRate;

  const StoreContainer({
    Key? key,
    required this.storeImage,
    required this.storeName,
    required this.starRate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      //margin: EdgeInsets.all(10),
      height: 160,
      // width: 164,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            storeImage,
          ),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 70,
            left: 10,
            right: 10,
            child: TextButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StoreDashboardView(),
                ),
              );
            },
            child: Text( storeName,
                style: TextStyle(
                    color: AppColors.light,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),

            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: Row(children: <Widget>[
              Icon(
                Icons.star,
                color: Colors.amber,
              ),
              Text(
                starRate.toString(),
                style: TextStyle(color: AppColors.light, fontSize: 16),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
