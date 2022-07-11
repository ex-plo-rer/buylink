import 'package:buy_link/features/core/notifiers/store_notifier/store_notifier.dart';
import 'package:buy_link/repositories/store_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/routes.dart';
import '../../../../core/utilities/alertify.dart';
import '../../../../core/utilities/base_change_notifier.dart';
import '../../../../core/utilities/view_state.dart';
import '../../../../services/base/network_exception.dart';
import '../../../../services/navigation_service.dart';

class StoreSettingNotifier extends BaseChangeNotifier {
  final Reader _reader;

  StoreSettingNotifier(this._reader);

  bool _deleted = false;

  bool get deleted => _deleted;

  bool _passwordVisible = false;

  bool get passwordVisible => _passwordVisible;

  double _storeLat = 0;
  double _storeLon = 0;

  double get storeLat => _storeLat;

  double get storeLon => _storeLon;

  void initLocation(double lat, double lon) {
    // // Uses the initial location of when the app was lauched first.
    _storeLat = lat;
    _storeLon = lon;
    notifyListeners();
  }

  void setStorePosition({
    required double lat,
    required double lon,
  }) {
    _storeLat = lat;
    _storeLon = lon;
    notifyListeners();
  }

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
      await _reader(storeNotifierProvider).fetchMyStores();
      // _reader(navigationServiceProvider).navigateBack();
      _reader(navigationServiceProvider)
          .navigateOffAllNamed(Routes.dashboard, (p0) => false);
      Alertify(title: 'Your changes have been saved').success();
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error).error();
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
