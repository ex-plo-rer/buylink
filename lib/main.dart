import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:buy_link/features/startup/views/startup_view.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/services/snackbar_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/constants/strings.dart';
import 'core/routes.dart';
import 'core/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      title: AppStrings.appName,
      theme: AppTheme.lightTheme,
      home: StartupView(),
      // home: AddProductView(),
      onGenerateRoute: Routes.generateRoute,
      navigatorKey: ref.read(navigationServiceProvider).navigatorKey,
      scaffoldMessengerKey: ref.read(snackbarService).scaffoldMessengerKey,
    );
  }
}
