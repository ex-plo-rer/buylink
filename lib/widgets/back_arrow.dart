import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/constants/colors.dart';
import '../core/constants/svgs.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: onFavoriteTapped,
      child: Container(
        height: 36,
        width: 36,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.black.withOpacity(0.41),
        ),
        child: const SizedBox(
          width: 20,
          height: 18,
          child: Icon(
            Icons.arrow_back_ios_outlined,
            size: 12,
            color: AppColors.light,
          ),
        ),
      ),
    );
  }
}
