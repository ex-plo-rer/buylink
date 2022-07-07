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
    return Scaffold(
      body: Center(
        // child:
        // SvgPicture.asset(
        //   AppSvgs.splash,
        //   width: 60,
        //   height: 20,
        // ),
        child: Text(
          'Buylink',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 50,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
