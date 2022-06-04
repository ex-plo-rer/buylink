import 'package:buy_link/services/local_storage_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/routes.dart';
import '../../../../core/utilities/alertify.dart';
import '../../../../core/utilities/base_change_notifier.dart';
import '../../../../services/navigation_service.dart';
import '../../../../core/utilities/view_state.dart';
import '../../../../repositories/setting_repository.dart';
import '../../../../services/base/network_exception.dart';
import '../../models/user_model.dart';
import '../user_provider.dart';

class SettingNotifier extends BaseChangeNotifier {
  final Reader _reader;

  SettingNotifier(this._reader);

  void logOut() {
    _reader(localStorageService).deleteSecureData(AppStrings.lastPlaceKey);
    _reader(localStorageService).deleteSecureData(AppStrings.tokenKey);
    _reader(localStorageService).deleteSecureData(AppStrings.userKey);
    _reader(localStorageService).deleteSecureData(AppStrings.otpEmailKey);
    _reader(localStorageService).deleteSecureData(AppStrings.recentSearchKey);
    _reader(navigationServiceProvider)
        .navigateOffAllNamed(Routes.login, (p0) => false);
  }
}

final settingNotifierProvider =
    ChangeNotifierProvider<SettingNotifier>((ref) => SettingNotifier(ref.read));
