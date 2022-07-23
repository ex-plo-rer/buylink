import 'package:buy_link/features/core/notifiers/dashboard_notifier.dart';
import 'package:buy_link/features/core/notifiers/wishlist_notifier.dart';
import 'package:buy_link/services/local_storage_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/routes.dart';
import '../../../../core/utilities/base_change_notifier.dart';
import '../../../../services/navigation_service.dart';
import '../home_notifier.dart';
import '../message_notifier/message_list_notifier.dart';
import '../notification_notifier/notification_notifier.dart';
import '../store_notifier/store_notifier.dart';

class SettingNotifier extends BaseChangeNotifier {
  final Reader _reader;

  SettingNotifier(this._reader);

  void parentDump() {
    // _reader(dashboardChangeNotifier).resetIndex();
    _reader(dashboardChangeNotifier).dump();
    _reader(homeNotifierProvider(null)).dump();
    _reader(wishlistNotifierProvider).dump();
    _reader(storeNotifierProvider).dump();
    _reader(messageListNotifierProvider).dump();
    _reader(notificationNotifierProvider).dump();
    // BaseChangeNotifier().dispose();
  }

  void logOut() {
    _reader(localStorageService).deleteSecureData(AppStrings.lastPlaceKey);
    _reader(localStorageService).deleteSecureData(AppStrings.tokenKey);
    _reader(localStorageService).deleteSecureData(AppStrings.userKey);
    _reader(localStorageService).deleteSecureData(AppStrings.otpEmailKey);
    _reader(localStorageService).deleteSecureData(AppStrings.recentSearchKey);
    parentDump();
    _reader(navigationServiceProvider)
        .navigateOffAllNamed(Routes.login, (p0) => false);
  }
}

final settingNotifierProvider =
    ChangeNotifierProvider<SettingNotifier>((ref) => SettingNotifier(ref.read));
