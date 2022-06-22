import 'package:flutter/material.dart';

import '../core/constants/colors.dart';

class MapPriceMarker extends StatelessWidget {
  const MapPriceMarker({
    Key? key,
    required this.price,
    this.containerColor = AppColors.light,
    this.textColor = AppColors.primaryColor,
    this.onMarkerTapped,
  }) : super(key: key);
  final int price;
  final Color containerColor;
  final Color textColor;
  final void Function()? onMarkerTapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onMarkerTapped,
      child: Stack(
        children: [
          Container(
            height: 33,
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: Center(
              child: Text(
                '$price',
                style: TextStyle(color: textColor),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Icon(
              Icons.arrow_drop_down,
              size: 36,
              color: containerColor,
            ),
          ),
        ],
      ),
    );
  }
}
