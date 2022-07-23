import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/alertify.dart';
import '../../../../core/utilities/base_change_notifier.dart';
import '../../../../core/utilities/view_state.dart';
import '../../../../repositories/setting_repository.dart';
import '../../../../services/base/network_exception.dart';
import '../../../../services/navigation_service.dart';

class DeleteUserNotifier extends BaseChangeNotifier {
  final Reader _reader;

  DeleteUserNotifier(this._reader);

  final List<String> reasons = [
    "I’m getting too much notifications",
    "I opened another account",
    "The app is buggy",
    "I have a privacy concern",
    "Others",
  ];

  late bool _accountDeleted;

  bool get accountDeleted => _accountDeleted;

  bool _reason1 = false;

  bool get reason1 => _reason1;

  bool _reason2 = false;

  bool get reason2 => _reason2;

  bool _reason3 = false;

  bool get reason3 => _reason3;

  bool _reason4 = false;

  bool get reason4 => _reason4;

  bool _reason5 = false;

  bool get reason5 => _reason5;

  String _reason = '';

  String get reason => _reason;

  bool _passwordVisible = false;

  bool get passwordVisible => _passwordVisible;

  int _currentPage = 1;

  int get currentPage => _currentPage;

  int _totalPage = 3;

  int get totalPage => _totalPage;

  String _detail = '';

  String get detail => _detail;

  String _password = '';

  String get password => _password;

  late bool _passwordCorrect;

  bool get passwordCorrect => _passwordCorrect;

  void toggleCheckbox({required bool? value, required int index}) {
    print('Value :$value');
    switch (index) {
      case 1:
        _reason1 = value!;
        _reason = reasons[0];
        break;
      case 2:
        _reason2 = value!;
        _reason = reasons[1];
        break;
      case 3:
        _reason3 = value!;
        _reason = reasons[2];
        break;
      case 4:
        _reason4 = value!;
        _reason = reasons[3];
        break;
      case 5:
        _reason5 = value!;
        _reason = reasons[4];
        break;
    }
    notifyListeners();
  }

  void onPasswordChanged(String Password) {
    _password = Password;
    print(_password);
    notifyListeners();
  }

  void onDetailChanged(String text) {
    _detail = text;
    print(_detail);
    notifyListeners();
  }

  void onReasonClicked(String text) {
    _reason = text;
    print(_reason);
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

  Future<void> deleteAccount() async {
    try {
      setState(state: ViewState.loading);
      _accountDeleted = await _reader(settingRepository).deleteAccount(
        reason: _reason,
        details: _detail,
      );
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error).error();
      // _reader(navigationServiceProvider).navigateBack();
    } finally {
      //setState(state: ViewState.idle);
    }
  }

  Future<void> checkPassword({
    required String password,
  }) async {
    try {
      setState(state: ViewState.loading);

      _passwordCorrect = await _reader(settingRepository).checkPassword(
        password: password,
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
      //setState(state: ViewState.idle);
    }
  }
}

final deleteUserNotifierProvider =
    ChangeNotifierProvider.autoDispose<DeleteUserNotifier>(
        (ref) => DeleteUserNotifier(ref.read));
