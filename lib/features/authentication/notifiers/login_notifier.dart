import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/strings.dart';
import '../../../core/routes.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/view_state.dart';
import '../../../repositories/authentication_repository.dart';
import '../../../services/base/network_exception.dart';
import '../../../services/navigation_service.dart';
import '../../../services/snackbar_service.dart';

class LoginNotifier extends BaseChangeNotifier {
  final Reader _reader;

  LoginNotifier(this._reader);

  bool _passwordVisible = false;
  bool get passwordVisible => _passwordVisible;

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

      _reader(navigationServiceProvider)
          .navigateToNamed(Routes.dashboard);
      // UserModel loggedInUser = await _reader(authenticationRepository).login(
      //   email: email,
      //   password: password,
      // );
      // // Calling _reader(userProvider); helps to initialize the methods inside
      // // the userProvider before we'd need them
      // await _reader(userProvider).setUser();
      // await _reader(userProvider).setToken();
      // // await Future.delayed(const Duration(seconds: 1));
      //
      // if (loggedInUser.emailVerifiedAt == null) {
      //   _reader(snackbarService)
      //       .showErrorSnackBar('Kindly verify your account.');
      // } else {
      //   if (loggedInUser.mode == Mode.author.name) {
      //     _reader(navigationServiceProvider)
      //         .navigateOffAllNamed(Routes.dashboardViewAuthor, (p0) => false);
      //   } else {
      //     if (loggedInUser.isSubscribed) {
      //       _reader(navigationServiceProvider)
      //           .navigateOffAllNamed(Routes.dashboardView, (p0) => false);
      //     } else {
      //       _reader(navigationServiceProvider)
      //           .navigateOffNamed(Routes.subscriptionListView);
      //     }
      //   }
      // }
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      _reader(snackbarService).showErrorSnackBar(e.error!);
    } finally {
      setState(state: ViewState.idle);
    }
  }
}

final loginNotifierProvider =
    ChangeNotifierProvider<LoginNotifier>((ref) => LoginNotifier(ref.read));
