import 'package:buy_link/features/authentication/views/onboarding_view.dart';
import 'package:buy_link/features/core/notifiers/no_product_search_notifier.dart';
import 'package:buy_link/features/core/views/no_product_search_view.dart';
import 'package:buy_link/features/core/views/store_views/empty_state.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/services/snackbar_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/constants/strings.dart';
import 'core/routes.dart';
import 'core/theme.dart';
import 'features/authentication/views/login_view.dart';
import 'features/authentication/views/notification_view.dart';
import 'features/authentication/views/setting_view.dart';
import 'features/authentication/views/splash_view.dart';
import 'features/core/views/store_views/add_store.dart';
import 'features/core/views/store_views/store_view.dart';

import 'features/startup/views/startup_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: AppTheme.lightTheme,
      home: EmptyStateView(),
      onGenerateRoute: Routes.generateRoute,
      navigatorKey: ref.read(navigationServiceProvider).navigatorKey,
      scaffoldMessengerKey: ref.read(snackbarService).scaffoldMessengerKey,
    );
  }
}
