import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../notifiers/startup_notifier.dart';

class StartupView extends ConsumerWidget {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(startUpNotifierProvider);
    return Scaffold(
      body:Container(

          child: Image.asset('assets/images/splashscreen.png', fit: BoxFit.cover,)
      )

          //child: Image.asset('assets/images/splashscreen.png', fit: BoxFit.cover,)),

      //Center(child: CircularProgressIndicator()),
    );
  }
}
