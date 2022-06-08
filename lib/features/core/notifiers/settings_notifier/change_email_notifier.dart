import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/routes.dart';
import '../../../../core/utilities/alertify.dart';
import '../../../../core/utilities/base_change_notifier.dart';
import '../../../../core/utilities/view_state.dart';
import '../../../../repositories/setting_repository.dart';
import '../../../../services/base/network_exception.dart';
import '../../../../services/navigation_service.dart';

class EditUserEmailNotifier extends BaseChangeNotifier {
  final Reader _reader;

  EditUserEmailNotifier(this._reader);

  int _currentPage = 1;
  int get currentPage => _currentPage;
  int _totalPage = 2;
  int get totalPage => _totalPage;
  bool _passwordVisible = false;
  bool get passwordVisible => _passwordVisible;

  String _email = '';
  String get email => _email;

  void onEmailChanged(String email) {
    _email = email;
    print(_email);
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

  Future<void> changeEmail({
    required String email,
  }) async {
    try {
      setState(state: ViewState.loading);
      await _reader(settingRepository).changeEmail(
        email: email,
      );
      _reader(navigationServiceProvider)
          .navigateOffAllNamed(Routes.dashboard, (p0) => false);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error!).error();
    } finally {
      setState(state: ViewState.idle);
    }
  }

  Future<void> checkEmail({
    required String reason,
    required String email,
  }) async {
    try {
      setState(state: ViewState.loading);

      // _code =
      await _reader(settingRepository).checkEmail(
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
}

final editUserEmailNotifierProvider =
    ChangeNotifierProvider<EditUserEmailNotifier>(
        (ref) => EditUserEmailNotifier(ref.read));
