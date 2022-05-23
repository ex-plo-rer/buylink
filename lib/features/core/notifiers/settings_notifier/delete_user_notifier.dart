import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/alertify.dart';
import '../../../../core/utilities/base_change_notifier.dart';
import '../../../../core/utilities/view_state.dart';
import '../../../../repositories/setting_repository.dart';
import '../../../../services/base/network_exception.dart';

class DeleteUserNotifier extends BaseChangeNotifier {
  final Reader _reader;
  DeleteUserNotifier(this._reader);

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


  Future<void> deleteAccount({
    //required int id,
    required String reason,
    required String detail,

  }) async {
    try {
      setState(state: ViewState.loading);
      await _reader(settingRepository).deleteAccount(
        // id : id,
        reason : reason,
        detail : detail
      );

    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error!).error();
    } finally {
      setState(state: ViewState.idle);
    }
  }


  Future<void> checkPassword({
    required String password,
  }) async {
    try {
      setState(state: ViewState.loading);

      await _reader(settingRepository).checkPassword(
        password: password,
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

}

final deleteUserNotifierProvider =
ChangeNotifierProvider<DeleteUserNotifier>((ref) => DeleteUserNotifier(ref.read));