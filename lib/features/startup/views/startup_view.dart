import 'package:buy_link/core/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/svgs.dart';
import '../notifiers/startup_notifier.dart';

class StartupView extends ConsumerWidget {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(startUpNotifierProvider);
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: 150.0),
          //   child: Image.asset(
          //     AppImages.splash,
          //     width: MediaQuery.of(context).size.width - 110,
          //     height: 70,
          //   ),
          child: Text(
            'Buylink',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 70,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
