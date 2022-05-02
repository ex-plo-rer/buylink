import 'package:buy_link/features/authentication/views/onboarding_view.dart';
import 'package:buy_link/features/core/views/store_views/product_searched_view.dart';
import 'package:buy_link/features/core/views/store_views/store_dashboard_view.dart';
import 'package:buy_link/features/core/views/store_views/store_details_view.dart';
import 'package:buy_link/features/core/views/store_views/store_visits_view.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/services/snackbar_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/constants/strings.dart';
import 'core/routes.dart';
import 'core/theme.dart';

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
      home: StoreDetailsView(),
      // home: SplineArea(key),
      onGenerateRoute: Routes.generateRoute,
      navigatorKey: ref.read(navigationServiceProvider).navigatorKey,
      scaffoldMessengerKey: ref.read(snackbarService).scaffoldMessengerKey,
    );
  }
}
