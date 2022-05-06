import 'package:flutter/material.dart';
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

      _reader(snackbarService).showSuccessSnackBar('Success');
      _reader(navigationServiceProvider)
          .navigateOffAllNamed(Routes.dashboard, (p0) => false);

      // I should not have anything material in my notifier(viewmodel)
      Alertify(
        title: 'Success',
        // message: 'Mode selection failed. Kindly restart the app',
        // icon: Icons.check,
      ).success();

      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      _reader(snackbarService).showErrorSnackBar(e.error!);
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

      // _reader(snackbarService).showSuccessSnackBar('Success');
      // _reader(navigationServiceProvider)
      //     .navigateOffAllNamed(Routes.dashboard, (p0) => false);
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      _reader(snackbarService).showErrorSnackBar(e.error!);
    } finally {
      setState(state: ViewState.idle);
    }
  }
}

final signupNotifierProvider =
    ChangeNotifierProvider.autoDispose<SignupNotifier>(
        (ref) => SignupNotifier(ref.read));
