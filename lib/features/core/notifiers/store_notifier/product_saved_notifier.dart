import 'package:buy_link/features/core/notifiers/store_notifier/store_dashboard_notifier.dart';
import 'package:buy_link/repositories/store_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/alertify.dart';
import '../../../../core/utilities/base_change_notifier.dart';
import '../../../../core/utilities/view_state.dart';
import '../../../../services/base/network_exception.dart';
import '../../models/weekly_data_model.dart';

class ProductSavedNotifier extends BaseChangeNotifier {
  final Reader _reader;

  ProductSavedNotifier(this._reader);

  WeeklyDataModel? _weeklyData;
  WeeklyDataModel? get weeklyData => _weeklyData;

  String _dropdownValue = 'This Week';
  String get dropdownValue => _dropdownValue;

  void onDropDownChanged({required String newValue, required int storeId}) {
    print('New Value : $newValue');
    _dropdownValue = newValue;
    String week = newValue == 'This Week' ? 'current' : 'previous';
    _reader(storeDashboardNotifierProvider)
        .fetchSearchAnalytics(storeId: storeId, week: week);
    fetchWeeklyData(storeId: storeId, week: week);
    notifyListeners();
  }

  Future<void> fetchWeeklyData({
    required int storeId,
    required String week,
  }) async {
    try {
      setState(state: ViewState.loading);
      _weeklyData = await _reader(storeRepository).fetchWeeklyData(
        storeId: storeId,
        week: week,
        domain: 'Looks',
      );
      // Alertify(title: 'Your product has been added').success();
      // _reader(navigationServiceProvider).navigateBack();
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error!).error();
      // Alertify(title: 'There\'s a problem adding your product').error();
    } finally {
      // setState(state: ViewState.idle);
    }
  }
}

final productSavedNotifierProvider =
    ChangeNotifierProvider.autoDispose<ProductSavedNotifier>(
        (ref) => ProductSavedNotifier(ref.read));
