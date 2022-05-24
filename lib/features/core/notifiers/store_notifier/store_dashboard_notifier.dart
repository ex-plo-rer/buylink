import 'package:buy_link/features/core/models/analytics_model.dart';
import 'package:buy_link/features/core/models/category_model.dart';
import 'package:buy_link/features/core/models/most_searched_model.dart';
import 'package:buy_link/features/core/models/product_attribute_model.dart';
import 'package:buy_link/features/core/models/spline_data_model.dart';
import 'package:buy_link/features/core/models/store_quick_model.dart';
import 'package:buy_link/repositories/core_repository.dart';
import 'package:buy_link/repositories/store_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/alertify.dart';
import '../../../../core/utilities/base_change_notifier.dart';
import '../../../../core/utilities/view_state.dart';
import '../../../../services/base/network_exception.dart';
import '../../models/product_model.dart';

class StoreDashboardNotifier extends BaseChangeNotifier {
  final Reader _reader;

  StoreDashboardNotifier(this._reader);

  List<MostSearchedProductModel> _mostSearchedProducts = [];
  List<MostSearchedProductModel> get mostSearchedProducts =>
      _mostSearchedProducts;

  // List<ProductModel> _products = [];
  // List<ProductModel> get products => _products;

  bool _initLoading = false;
  bool get initLoading => _initLoading;

  AnalyticsModel? _searchAnalytics;
  AnalyticsModel? get searchAnalytics => _searchAnalytics;

  List<SplineDataModel> _splineDataModel = [];
  List<SplineDataModel> get splineDataModel => _splineDataModel;

  AnalyticsModel? _visitAnalytics;
  AnalyticsModel? get visitAnalytics => _visitAnalytics;

  int _allProductCount = 0;
  int get allProductCount => _allProductCount;

  int _savedProductCount = 0;
  int get savedProductCount => _savedProductCount;

  Future<void> initFetch({required int storeId}) async {
    try {
      _initLoading = true;
      setState(state: ViewState.loading);
      await fetchMostSearchedProducts(storeId: storeId, category: 'all');
      await fetchSearchAnalytics(storeId: storeId, week: 'current');
      await fetchVisitAnalytics(storeId: storeId, week: 'current');
      await fetchAllProductCount(storeId: storeId, week: 'current');
      await fetchSavedProductCount(storeId: storeId, week: 'current');
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
      _mostSearchedProducts = await _reader(coreRepository).getMostSearched(
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
      _splineDataModel.clear();
      _searchAnalytics = await _reader(coreRepository).getAnalytics(
        type: 'search',
        storeId: storeId,
        week: week,
      );
      _splineDataModel
          .add(SplineDataModel('SUN', _searchAnalytics!.sunday.toDouble()));
      _splineDataModel
          .add(SplineDataModel('MON', _searchAnalytics!.monday.toDouble()));
      _splineDataModel
          .add(SplineDataModel('TUE', _searchAnalytics!.tuesday.toDouble()));
      _splineDataModel
          .add(SplineDataModel('WED', _searchAnalytics!.wednesday.toDouble()));
      _splineDataModel
          .add(SplineDataModel('THUR', _searchAnalytics!.thursday.toDouble()));
      _splineDataModel
          .add(SplineDataModel('FRI', _searchAnalytics!.friday.toDouble()));
      _splineDataModel
          .add(SplineDataModel('SAT', _searchAnalytics!.saturday.toDouble()));

      print('Spline data : $_splineDataModel');
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
      setState(state: ViewState.loading);
      _visitAnalytics = await _reader(coreRepository).getAnalytics(
        type: 'visit',
        storeId: storeId,
        week: week,
      );
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error).error();
    } finally {
      // setState(state: ViewState.idle);
    }
  }

  Future<void> fetchAllProductCount({
    required int storeId,
    required String week,
  }) async {
    try {
      setState(state: ViewState.loading);
      _allProductCount = await _reader(coreRepository).getProductCount(
        type: 'all',
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

  Future<void> fetchSavedProductCount({
    required int storeId,
    required String week,
  }) async {
    try {
      setState(state: ViewState.loading);
      _savedProductCount = await _reader(coreRepository).getProductCount(
        type: 'saved',
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
