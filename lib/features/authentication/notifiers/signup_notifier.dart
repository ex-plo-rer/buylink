import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/strings.dart';
import '../../../core/routes.dart';
import '../../../core/utilities/alertify.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/view_state.dart';
import '../../../repositories/authentication_repository.dart';
import '../../../services/base/network_exception.dart';
import '../../../services/local_storage_service.dart';
import '../../../services/navigation_service.dart';
import '../../../services/snackbar_service.dart';
import '../../core/notifiers/user_provider.dart';

class SignupNotifier extends BaseChangeNotifier {
  final Reader _reader;

  SignupNotifier(this._reader);

  int _currentPage = 1;

  int get currentPage => _currentPage;

  int _totalPage = 4;

  int get totalPage => _totalPage;

  bool _passwordVisible = false;

  bool get passwordVisible => _passwordVisible;

  String _name = '';

  String get name => _name;

  // // static const maxSeconds = 60;
  // int _seconds = 30;
  // int get seconds => _seconds;

  String _minutes = '00';
  String _seconds = '00';

  String get minutes => _minutes;

  String get seconds => _seconds;

  Timer? timer;
  Duration _duration = Duration(seconds: 30);

  Duration get duration => _duration;

  bool _canResendOTP = false;

  bool get canResendOTP => _canResendOTP;

  bool _emailUnique = false;

  bool get emailUnique => _emailUnique;

  void startTimer() async {
    await Future.delayed(const Duration(seconds: 2));
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final sec = _duration.inSeconds - 1;
      if (_duration.inSeconds > 0) {
        _duration = Duration(seconds: sec);
      } else {
        _canResendOTP = true;
      }
      print(_duration.inSeconds);
      twoDig();
    });
  }

  void twoDig() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    _minutes = twoDigits(_duration.inMinutes.remainder(60));
    _seconds = twoDigits(_duration.inSeconds.remainder(60));
    notifyListeners();
  }

  void moveBackward() {
    if (_currentPage > 1) {
      _currentPage -= 1;
      print('_currentPage: $_currentPage');
    }
    notifyListeners();
  }

  void moveForward() async {
    if (_currentPage < _totalPage + 1) {
      _currentPage += 1;
      print('_currentPage: $_currentPage');
    }
    notifyListeners();
  }

  void togglePassword() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  void onNameChanged(String text) {
    _name = text;
    print(_name);
    notifyListeners();
  }

  void onEmailChanged(String text) {
    notifyListeners();
  }

  void onPasswordChanged(String text) {
    notifyListeners();
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      setState(state: ViewState.loading);
      await _reader(authenticationRepository).signUp(
        name: name,
        email: email,
        password: password,
      );

      timer?.cancel();
      Alertify(
        title: 'Wellcome to Buylink',
      ).success();
      _reader(localStorageService).deleteSecureData(AppStrings.otpEmailKey);
      _reader(navigationServiceProvider)
          .navigateOffAllNamed(Routes.dashboard, (p0) => false);

      await _reader(userProvider).setUser();

      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error!).error();
    } finally {
      setState(state: ViewState.idle);
    }
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
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error!).error();
    } finally {
      // setState(state: ViewState.idle);
    }
  }

  Future<void> checkEmailUniqueness({
    required String email,
  }) async {
    try {
      setState(state: ViewState.loading);
      _emailUnique =
          await _reader(authenticationRepository).checkEmailUniqueness(
        email: email,
      );
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error!).error();
    } finally {
      // setState(state: ViewState.idle);
    }
  }
}

final signupNotifierProvider =
    ChangeNotifierProvider.autoDispose<SignupNotifier>(
        (ref) => SignupNotifier(ref.read));
