import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/constants/colors.dart';
import '../core/constants/svgs.dart';

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
              child: RichText(
                // overflow: TextOverflow.clip(isDetails ? null : TextOverflow.ellipsis,),
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      style: const TextStyle(
                        color: AppColors.grey1,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      child: SvgPicture.asset(
                        AppSvgs.naira,
                        height: 15,
                        width: 15,
                      ),
                    ),
                    TextSpan(
                      text: '${price}',
                      style: const TextStyle(
                        color: AppColors.grey1,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
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
