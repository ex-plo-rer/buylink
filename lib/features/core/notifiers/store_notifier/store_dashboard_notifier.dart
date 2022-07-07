import 'package:buy_link/features/core/models/analytics_model.dart';
import 'package:buy_link/features/core/models/chart_data_model.dart';
import 'package:buy_link/repositories/core_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/alertify.dart';
import '../../../../core/utilities/base_change_notifier.dart';
import '../../../../core/utilities/view_state.dart';
import '../../../../services/base/network_exception.dart';
import '../../models/most_searched_count_model.dart';

//TODO: Save this week products and have another copy that can be modified...
class StoreDashboardNotifier extends BaseChangeNotifier {
  final Reader _reader;

  StoreDashboardNotifier(this._reader);

  MostSearchedModel? _mostSearchedNCount;

  MostSearchedModel? get mostSearchedNCount => _mostSearchedNCount;

  bool _initLoading = false;

  bool get initLoading => _initLoading;

  AnalyticsModel? _searchAnalytics;

  AnalyticsModel? get searchAnalytics => _searchAnalytics;

  List<ChartDataModel> _searchedData = [];

  List<ChartDataModel> get searchedData => _searchedData;

  List<ChartDataModel> _visitsData = [];

  List<ChartDataModel> get visitsData => _visitsData;

  AnalyticsModel? _visitAnalytics;

  AnalyticsModel? get visitAnalytics => _visitAnalytics;

  Future<void> initFetch({required int storeId}) async {
    try {
      _initLoading = true;
      setState(state: ViewState.loading);
      await fetchMostSearchedProducts(storeId: storeId, category: 'all');
      await fetchSearchAnalytics(storeId: storeId, week: 'current');
      await fetchVisitAnalytics(storeId: storeId, week: 'current');
      // await _reader(categoryNotifierProvider)
      //     .fetchStoreCategories(storeId: storeId.toString());
      // await fetchAllProductCount(storeId: storeId, week: 'current');
      // await fetchSavedProductCount(storeId: storeId, week: 'current');
      // await _reader(coreRepository).initDash(
      //   storeId: storeId,
      // );
      _initLoading = false;
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      _initLoading = false;
      setState(state: ViewState.error);
      Alertify(title: e.error).error();
    } finally {
      _initLoading = false;
      // setState(state: ViewState.idle);
    }
  }

  Future<void> fetchMostSearchedProducts({
    required int storeId,
    required String category,
  }) async {
    try {
      setState(state: ViewState.loading);
      _mostSearchedNCount = await _reader(coreRepository).getMostSearchedNCount(
        storeId: storeId,
      );
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error).error();
    } finally {
      // setState(state: ViewState.idle);
    }
  }

  Future<void> fetchSearchAnalytics({
    required int storeId,
    required String week,
  }) async {
    try {
      setState(state: ViewState.loading);
      _searchedData.clear();
      _searchAnalytics = await _reader(coreRepository).getAnalytics(
        type: 'search',
        storeId: storeId,
        week: week,
      );
      _searchedData
          .add(ChartDataModel('Sun', _searchAnalytics!.sunday.toDouble()));
      _searchedData
          .add(ChartDataModel('Mon', _searchAnalytics!.monday.toDouble()));
      _searchedData
          .add(ChartDataModel('Tue', _searchAnalytics!.tuesday.toDouble()));
      _searchedData
          .add(ChartDataModel('Wed', _searchAnalytics!.wednesday.toDouble()));
      _searchedData
          .add(ChartDataModel('Thur', _searchAnalytics!.thursday.toDouble()));
      _searchedData
          .add(ChartDataModel('Fri', _searchAnalytics!.friday.toDouble()));
      _searchedData
          .add(ChartDataModel('Sat', _searchAnalytics!.saturday.toDouble()));

      print('Searched data : $_searchedData');
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error).error();
    } finally {
      // setState(state: ViewState.idle);
    }
  }

  Future<void> fetchVisitAnalytics({
    required int storeId,
    required String week,
  }) async {
    try {
      _visitsData.clear();
      setState(state: ViewState.loading);
      _visitAnalytics = await _reader(coreRepository).getAnalytics(
        type: 'visit',
        storeId: storeId,
        week: week,
      );

      _visitsData
          .add(ChartDataModel('Sun', _visitAnalytics!.sunday.toDouble()));
      _visitsData
          .add(ChartDataModel('Mon', _visitAnalytics!.monday.toDouble()));
      _visitsData
          .add(ChartDataModel('Tue', _visitAnalytics!.tuesday.toDouble()));
      _visitsData
          .add(ChartDataModel('Wed', _visitAnalytics!.wednesday.toDouble()));
      _visitsData
          .add(ChartDataModel('Thur', _visitAnalytics!.thursday.toDouble()));
      _visitsData
          .add(ChartDataModel('Fri', _visitAnalytics!.friday.toDouble()));
      _visitsData
          .add(ChartDataModel('Sat', _visitAnalytics!.saturday.toDouble()));

      print('Visit data : $_visitsData');

      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error).error();
    } finally {
      // setState(state: ViewState.idle);
    }
  }

// Future<void> fetchStoreProducts({
//   required int storeId,
//   required String category,
// }) async {
//   try {
//     setState(state: ViewState.loading);
//     _products = await _reader(storeRepository).fetchStoreProducts(
//       storeId: storeId,
//       category: category,
//     );
//     // }
//     // Alertify(title: 'User logged in').success();
//     setState(state: ViewState.idle);
//   } on NetworkException catch (e) {
//     setState(state: ViewState.error);
//     Alertify(title: e.error).error();
//   } finally {
// //     setState(state: ViewState.idle);
//   }
// }
}

final storeDashboardNotifierProvider =
    ChangeNotifierProvider.autoDispose<StoreDashboardNotifier>(
  (ref) => StoreDashboardNotifier(ref.read),
);
