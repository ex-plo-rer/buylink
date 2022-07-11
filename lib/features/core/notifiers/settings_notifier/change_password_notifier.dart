import 'package:buy_link/services/navigation_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/alertify.dart';
import '../../../../core/utilities/base_change_notifier.dart';
import '../../../../core/utilities/view_state.dart';
import '../../../../repositories/setting_repository.dart';
import '../../../../services/base/network_exception.dart';

class EditUserPasswordNotifier extends BaseChangeNotifier {
  final Reader _reader;

  EditUserPasswordNotifier(this._reader) {}

  int _currentPage = 1;

  int get currentPage => _currentPage;
  int _totalPage = 2;

  int get totalPage => _totalPage;

  bool _oldPasswordVisible = false;

  bool get oldPasswordVisible => _oldPasswordVisible;

  bool _newPasswordVisible = false;

  bool get newPasswordVisible => _newPasswordVisible;

  String _newpassword = '';

  String get newpassword => _newpassword;

  String _oldpassword = '';

  String get oldpassword => _oldpassword;

  late bool _oldPasswordCorrect;

  bool get oldPasswordCorrect => _oldPasswordCorrect;

  void toggleOldPassword() {
    _oldPasswordVisible = !_oldPasswordVisible;
    notifyListeners();
  }

  void toggleNewPassword() {
    _newPasswordVisible = !_newPasswordVisible;
    notifyListeners();
  }

  void onNewPasswordChanged(String newPassword) {
    _newpassword = newPassword;
    print(_newpassword);
    notifyListeners();
  }

  void onOldPasswordChanged(String oldPassword) {
    _oldpassword = oldPassword;
    print(_oldpassword);
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
    if (_currentPage < _totalPage) {
      _currentPage += 1;
      print('_currentPage: $_currentPage');
    }
    notifyListeners();
  }

  Future<void> changePassword({
    required String newPassword,
  }) async {
    try {
      setState(state: ViewState.loading);
      await _reader(settingRepository).changePassword(
        password: newPassword,
      );
      _reader(navigationServiceProvider).navigateBack();
      _reader(navigationServiceProvider).navigateBack();
      Alertify(title: 'Password changed successfully').success();
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error).error();
      _reader(navigationServiceProvider).navigateBack();
    } finally {
      //  setState(state: ViewState.idle);
    }
  }

  Future<void> checkPassword({
    required String password,
  }) async {
    try {
      setState(state: ViewState.loading);

      _oldPasswordCorrect = await _reader(settingRepository).checkPassword(
        password: password,
      );
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

final editUserPasswordNotifierProvider =
    ChangeNotifierProvider<EditUserPasswordNotifier>(
        (ref) => EditUserPasswordNotifier(ref.read));
