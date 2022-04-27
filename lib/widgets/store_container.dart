import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/constants/colors.dart';

class StoreContainer extends ConsumerWidget {
  final String storeImage;
  final String storeName;
  final int starRate;
  final void Function()? onStoreTapped;

  const StoreContainer({
    Key? key,
    required this.storeImage,
    required this.storeName,
    required this.starRate,
    this.onStoreTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return SizedBox(
      height: 226,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: onStoreTapped,
              child: Container(
                height: 176,
                // width: 156,
                decoration: BoxDecoration(
                  image: DecorationImage( image:NetworkImage(storeImage) ),
                  borderRadius: BorderRadius.circular(20),
                ),
              )),
          const Spacing.tinyHeight(),
          Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Text( storeName,
                    style: TextStyle(
                        color: AppColors.light, fontSize: 16, fontWeight: FontWeight.bold)
                ),
              ),
              Positioned(
                bottom: 40,
                right: 0,
                child: Row(
                    children: <Widget>[
                      Icon(Icons.star_rate_rounded, color: AppColors.star,),
                      Text (starRate.toString())

                    ]

                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
