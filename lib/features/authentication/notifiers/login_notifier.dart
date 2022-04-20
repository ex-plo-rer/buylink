import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/strings.dart';
import '../../../core/routes.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/view_state.dart';
import '../../../services/base/network_exception.dart';
import '../../../services/navigation_service.dart';

class LoginNotifier extends BaseChangeNotifier {
  final Reader _reader;

  LoginNotifier(this._reader);

  bool _passwordVisible = false;
  bool get passwordVisible => _passwordVisible;

  void togglePassword() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }
}

final loginNotifierProvider =
    ChangeNotifierProvider<LoginNotifier>((ref) => LoginNotifier(ref.read));
