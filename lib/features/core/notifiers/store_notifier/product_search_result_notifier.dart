import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/utilities/base_change_notifier.dart';
import 'package:buy_link/features/core/models/auto_complete_model.dart';
import 'package:buy_link/features/core/models/search_result_model.dart';
import 'package:flutter/painting.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/alertify.dart';
import '../../../../core/utilities/view_state.dart';
import '../../../../repositories/core_repository.dart';
import '../../../../services/base/network_exception.dart';
import '../../../../services/location_service.dart';
import '../../../../services/navigation_service.dart';

class ProductSearchResultNotifier extends BaseChangeNotifier {
  final Reader _reader;

  ProductSearchResultNotifier(this._reader);

  SearchResultModel? _searchResult;

  SearchResultModel? get searchResult => _searchResult;

  double _filterLat = 0;
  double _filterLon = 0;

  double get filterLat => _filterLat;

  double get filterLon => _filterLon;

  int _activeIndex = 0;

  int get activeIndex => _activeIndex;

  void nextPage(index, reason) {
    _activeIndex = index;
    print('$_activeIndex $index');
    notifyListeners();
  }

  void initLocation() {
    // // Uses the initial location of when the app was lauched first.
    _filterLat = _reader(locationService).lat!;
    _filterLon = _reader(locationService).lon!;
    notifyListeners();
  }

  double _sliderValue = 10;

  double get sliderValue => _sliderValue;

  double? _minPrice;
  double? _maxPrice;

  AutoCompleteModel? _autoComplete;

  AutoCompleteModel? get autoComplete => _autoComplete;

  bool _searchLoading = false;

  bool get searchLoading => _searchLoading;
  bool _isHorizontal = false;

  bool get isHorizontal => _isHorizontal;

  late List<Color> markerColors;
  late List<Color> markerTextColors;

  void changeViewToHorizontal() {
    _isHorizontal = true;
  }

  void initColors({
    required int length,
  }) {
    markerColors = List.generate(length, (index) => AppColors.light);
    markerTextColors = List.generate(length, (index) => AppColors.primaryColor);
    notifyListeners();
  }

  void changeColor({required int index}) {
    markerColors =
        List.generate(markerColors.length, (index) => AppColors.light);
    markerColors[index] = markerColors[index] == AppColors.light
        ? AppColors.primaryColor
        : AppColors.light;
    notifyListeners();
  }

  void changeTextColor({required int index}) {
    markerTextColors = List.generate(
        markerTextColors.length, (index) => AppColors.primaryColor);
    markerTextColors[index] = markerTextColors[index] == AppColors.light
        ? AppColors.primaryColor
        : AppColors.light;
    notifyListeners();
  }

  void setFilterPosition({
    required double lat,
    required double lon,
  }) {
    _filterLat = lat;
    _filterLon = lon;
    notifyListeners();
  }

  void clearFilter() {
    _minPrice = null;
    _maxPrice = null;
    _sliderValue = 10;
    notifyListeners();
  }

  void onMinPriceChanged(String value) => _minPrice = value as double?;

  void onMaxPriceChanged(String value) => _maxPrice = value as double?;

  void onSliderChanged(double newValue) {
    _sliderValue = newValue;
    notifyListeners();
  }

  Future<void> fetchProductSearch({
    required String searchTerm,
  }) async {
    try {
      setState(state: ViewState.loading);
      _searchResult = await _reader(coreRepository).fetchProductSearch(
        searchTerm: 'a',
        lon: _filterLon,
        lat: _filterLat,
        distanceRange: _sliderValue,
        minPrice: _minPrice ?? 0,
        maxPrice: _maxPrice ?? 1000000000,
      );
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error).error();
      _reader(navigationServiceProvider).navigateBack();
    } finally {
      //Do something...
    }
  }
}

final productSearchResultNotifierProvider =
    ChangeNotifierProvider<ProductSearchResultNotifier>(
        (ref) => ProductSearchResultNotifier(ref.read));
