import 'dart:async';

import 'package:buy_link/core/constants/strings.dart';
import 'package:buy_link/core/utilities/alertify.dart';
import 'package:buy_link/services/local_storage_service.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/routes.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/view_state.dart';
import '../../../repositories/authentication_repository.dart';
import '../../../services/base/network_exception.dart';
import '../../../services/snackbar_service.dart';

class ForgotPasswordNotifier extends BaseChangeNotifier {
  final Reader _reader;

  ForgotPasswordNotifier(this._reader);
  int _currentPage = 1;
  int get currentPage => _currentPage;

  int _totalPage = 3;
  int get totalPage => _totalPage;

  bool _passwordVisible = false;
  bool get passwordVisible => _passwordVisible;

  void moveBackward() {
    if (_currentPage > 1) {
      _currentPage -= 1;
      print('_currentPage: $_currentPage');
    }
    notifyListeners();
  }

  void moveForward() async {
    if (_currentPage < _totalPage) {
      _currentPage += 1;
      print('_currentPage: $_currentPage');
    }
    notifyListeners();
  }

  void togglePassword() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  void onEmailChanged(String text) {
    notifyListeners();
  }

  void onPasswordChanged(String text) {
    notifyListeners();
  }

  Future<void> delay({required int sec}) async {
    setState(state: ViewState.loading);
    await Future.delayed(Duration(seconds: sec));
    setState(state: ViewState.idle);
  }

  Future<void> checkEmail({
    required String reason,
    required String email,
  }) async {
    try {
      setState(state: ViewState.loading);

      await _reader(authenticationRepository).checkEmail(
        reason: reason,
        email: email,
      );

      // _reader(snackbarService).showSuccessSnackBar('Success');
      // _reader(navigationServiceProvider)
      //     .navigateOffAllNamed(Routes.dashboard, (p0) => false);
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error!).error();
    } finally {
      setState(state: ViewState.idle);
    }
  }

  Future<void> changePassword({
    required String email,
    required String password,
  }) async {
    try {
      setState(state: ViewState.loading);

      await _reader(authenticationRepository).changePassword(
        email: email,
        password: password,
      );

      Alertify(title: 'Password changed successfully').success();
      _reader(localStorageService).deleteSecureData(AppStrings.otpEmailKey);
      _reader(navigationServiceProvider).navigateOffAllNamed(
        Routes.login,
            (p0) => false,
      );
      Alertify(title: 'Password changed successfully').success();
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error!).error();
    } finally {
      setState(state: ViewState.idle);
    }
  }
}

final forgotPasswordNotifierProvider =
ChangeNotifierProvider.autoDispose<ForgotPasswordNotifier>(
        (ref) => ForgotPasswordNotifier(ref.read));