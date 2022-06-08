import 'package:buy_link/repositories/store_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/alertify.dart';
import '../../../../core/utilities/base_change_notifier.dart';
import '../../../../core/utilities/view_state.dart';
import '../../../../services/base/network_exception.dart';

class StoreSettingNotifier extends BaseChangeNotifier {
  final Reader _reader;

  StoreSettingNotifier(this._reader);

  bool _deleted = false;
  bool get deleted => _deleted;

  bool _passwordVisible = false;
  bool get passwordVisible => _passwordVisible;

  void togglePassword() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  void onNameChanged(String text) {
    notifyListeners();
  }

  void onDescriptionChanged(String text) {
    notifyListeners();
  }

  void onPasswordChanged(String text) {
    notifyListeners();
  }

  Future<void> editStore({
    required int storeId,
    required String attribute,
    required String newValue,
  }) async {
    try {
      setState(state: ViewState.loading);
      await _reader(storeRepository).editStore(
        storeId: storeId,
        attribute: attribute,
        newValue: newValue,
      );
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error!).error();
    } finally {}
  }

  Future<void> deleteStore({
    required int storeId,
    required String password,
  }) async {
    try {
      setState(state: ViewState.loading);
      _deleted = await _reader(storeRepository).deleteStore(
        storeId: storeId,
        password: password,
      );
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error!).error();
    } finally {}
  }
}

final storeSettingNotifierProvider =
    ChangeNotifierProvider<StoreSettingNotifier>(
        (ref) => StoreSettingNotifier(ref.read));
