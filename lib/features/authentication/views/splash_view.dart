import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/colors.dart';
import '../notifiers/splash_notifier.dart';

class SplashView extends ConsumerWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final splashNotifier = ref.watch(splashNotifierProvider);
    return Container(

        child: Image.asset('assets/images/splashscreen.png', fit: BoxFit.cover,));
  }

  }


