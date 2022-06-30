import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/strings.dart';
import '../../../core/routes.dart';
import '../../../core/utilities/alertify.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/view_state.dart';
import '../../../repositories/authentication_repository.dart';
import '../../../services/base/network_exception.dart';
import '../../../services/navigation_service.dart';
import '../../../services/snackbar_service.dart';
import '../../core/notifiers/user_provider.dart';

class LoginNotifier extends BaseChangeNotifier {
  final Reader _reader;

  LoginNotifier(this._reader);

  bool _passwordVisible = false;

  bool get passwordVisible => _passwordVisible;

  void onEmailChanged(String text) {
    notifyListeners();
  }

  void onPasswordChanged(String text) {
    notifyListeners();
  }

  void togglePassword() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      setState(state: ViewState.loading);
      await _reader(authenticationRepository).login(
        email: email,
        password: password,
      );

      Alertify(title: 'User logged in').success();
      _reader(navigationServiceProvider).navigateBack();
      _reader(navigationServiceProvider).navigateOffAllNamed(
        Routes.dashboard,
        (p0) => false,
      );

      // Calling _reader(userProvider); helps to initialize the methods inside
      // the userProvider before we'd need them
      await _reader(userProvider).setUser();
      // await _reader(userProvider).setToken();
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error!).error();
    } finally {
      // setState(state: ViewState.idle);
    }
  }
}

final loginNotifierProvider =
    ChangeNotifierProvider<LoginNotifier>((ref) => LoginNotifier(ref.read));
