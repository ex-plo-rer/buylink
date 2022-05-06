import 'package:buy_link/services/local_storage_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/strings.dart';
import '../../../core/routes.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/view_state.dart';
import '../../../services/base/network_exception.dart';
import '../../../services/navigation_service.dart';

class StartupNotifier extends BaseChangeNotifier {
  final Reader _reader;
  String? isOnboarded;

  StartupNotifier(this._reader) {
    decideNavigation();
  }

  Future<void> decideNavigation() async {
    print('decide navigation called');
    await Future.delayed(const Duration(seconds: 2));
    if (await _reader(localStorageService)
            .readSecureData(AppStrings.onboardedKey) !=
        'true') {
      _reader(navigationServiceProvider)
          .navigateOffAllNamed(Routes.onboarding, (route) => false);
    } else {
      // TODO: Probably check if user is logged in
      _reader(navigationServiceProvider)
          .navigateOffAllNamed(Routes.dashboard, (route) => false);
    }
  }
}

final startUpNotifierProvider =
    ChangeNotifierProvider<StartupNotifier>((ref) => StartupNotifier(ref.read));
