import 'package:buy_link/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/constants/colors.dart';

class BackArrow extends ConsumerWidget {
  const BackArrow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onTap: () => ref.read(navigationServiceProvider).navigateBack(),
      child: Container(
        padding: const EdgeInsets.only(
          left: 20,
          top: 20,
        ),
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
      ),
    );
  }
}
