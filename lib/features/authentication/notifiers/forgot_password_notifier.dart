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

class ForgotPasswordNotifier extends BaseChangeNotifier {
  final Reader _reader;

  ForgotPasswordNotifier(this._reader);

  int _currentPage = 1;

  int get currentPage => _currentPage;

  int _totalPage = 3;

  int get totalPage => _totalPage;

  String _minutes = '00';
  String _seconds = '00';

  String get minutes => _minutes;

  String get seconds => _seconds;

  Duration _duration = Duration(seconds: 30);

  Duration get duration => _duration;

  bool _canResendOTP = false;

  bool get canResendOTP => _canResendOTP;

  bool _passwordChanged = false;
  bool get passwordChanged => _passwordChanged;

  void startTimer() async {
    _duration = const Duration(seconds: 30);
    await Future.delayed(const Duration(seconds: 2));
    Timer.periodic(const Duration(seconds: 1), (timer) {
      final sec = _duration.inSeconds - 1;
      if (_duration.inSeconds > 0) {
        _duration = Duration(seconds: sec);
        _canResendOTP = false;
      } else {
        timer.cancel();
        _canResendOTP = true;
      }
      print(_duration.inSeconds);
      twoDig();
    });
  }

  Future<void> resendOTP({required String email}) async {
    startTimer();
    await checkEmail(reason: 'forgot password', email: email);
  }

  void twoDig() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    _minutes = twoDigits(_duration.inMinutes.remainder(60));
    _seconds = twoDigits(_duration.inSeconds.remainder(60));
    notifyListeners();
  }

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
      Alertify(title: e.error).error();
      _reader(navigationServiceProvider).navigateBack();
    } finally {
      // setState(state: ViewState.idle);
    }
  }

  Future<void> changePassword({
    required String email,
    required String password,
  }) async {
    try {
      setState(state: ViewState.loading);

      _passwordChanged = await _reader(authenticationRepository).changePassword(
        email: email,
        password: password,
      );
      _reader(localStorageService).deleteSecureData(AppStrings.otpEmailKey);
      _reader(navigationServiceProvider).navigateOffAllNamed(
        Routes.login,
        (p0) => false,
      );
      Alertify(title: 'Password changed successfully').success();
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error).error();
      _reader(navigationServiceProvider).navigateBack();
    } finally {
      // setState(state: ViewState.idle);
    }
  }
}

final forgotPasswordNotifierProvider =
    ChangeNotifierProvider.autoDispose<ForgotPasswordNotifier>(
        (ref) => ForgotPasswordNotifier(ref.read));
