import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/constants/svgs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppRatingBar extends ConsumerWidget {
  const AppRatingBar({
    Key? key,
    this.itemSize = 20,
    this.initialRating = 3,
    this.minRating = 0,
    this.direction = Axis.horizontal,
    this.allowHalfRating = true,
    this.itemCount = 5,
    this.itemPadding = 10,
    this.ignoreGestures = false,
    required this.onRatingUpdate,
  }) : super(key: key);

  final double itemSize;
  final double initialRating;
  final double minRating;
  final Axis direction;
  final bool allowHalfRating;
  final int itemCount;
  final double itemPadding;
  final void Function(double) onRatingUpdate;
  final bool ignoreGestures;

  @override
  Widget build(BuildContext context, ref) {
    return RatingBar.builder(
      itemSize: itemSize,
      initialRating: initialRating,
      minRating: minRating,
      direction: direction,
      allowHalfRating: allowHalfRating,
      itemCount: itemCount,
      ignoreGestures: ignoreGestures,
      unratedColor: AppColors.grey7,
      itemPadding: EdgeInsets.symmetric(horizontal: itemPadding),
      itemBuilder: (context, _) => SvgPicture.asset(
        AppSvgs.star,
        color: Colors.amber,
        //  width: ,
      ),
      onRatingUpdate: onRatingUpdate,
    );
  }
}
