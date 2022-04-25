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
  String? lastPlace;
  // UserModel? user;

  StartupNotifier(this._reader) {
    decideNavigation();
  }

  Future<void> decideNavigation() async {
    print('decide navigation called');
    await Future.delayed(const Duration(seconds: 2));
    _reader(navigationServiceProvider)
        .navigateOffAllNamed(Routes.login, (route) => false);
  }
}

final startUpNotifierProvider =
    ChangeNotifierProvider<StartupNotifier>((ref) => StartupNotifier(ref.read));
