import 'package:buy_link/core/utilities/base_change_notifier.dart';
import 'package:buy_link/features/core/models/auto_complete_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/view_state.dart';
import '../../../../repositories/core_repository.dart';
import '../../../../services/base/network_exception.dart';
import '../../../../services/location_service.dart';
import '../../models/product_model.dart';

class CompareSearchNotifier extends BaseChangeNotifier {
  final Reader _reader;

  CompareSearchNotifier(this._reader);

  List<ProductModel> get products => _products;
  List<ProductModel> _products = [];

  List<ProductModel> get itemsToCompare => _itemsToCompare;
  List<ProductModel> _itemsToCompare = [];

  bool _haveProductToCompare = false;

  bool get haveProductToCompare => _haveProductToCompare;

  double _filterLat = 0;
  double _filterLon = 0;

  double get filterLat => _filterLat;

  double get filterLon => _filterLon;

  // void haveToComp() {
  //   _haveProductToCompare = _itemsToCompare.length > 1;
  //   notifyListeners();
  // }

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

  double? get minPrice => _minPrice;

  double? get maxPrice => _maxPrice;

  AutoCompleteModel? _autoComplete;

  AutoCompleteModel? get autoComplete => _autoComplete;

  bool _searchLoading = false;

  bool get searchLoading => _searchLoading;

  bool _productsLoading = false;

  bool get productsLoading => _productsLoading;

  bool _itemsToCompareLoading = false;

  bool get itemsToCompareLoading => _itemsToCompareLoading;

  int _activeIndex = 0;

  int get activeIndex => _activeIndex;

  void nextPage(index, reason) {
    _activeIndex = index;
    print('$_activeIndex $index');
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
    _sliderValue = 5;
    notifyListeners();
  }

  void onMinPriceChanged(String value) {
    _minPrice = double.parse(value);
    notifyListeners();
  }

  void onMaxPriceChanged(String value) {
    print('max price :$value');
    _maxPrice = double.parse(value);
    print('_maxPrice :$_maxPrice');
    notifyListeners();
  }

  void onSliderChanged(double newValue) {
    _sliderValue = newValue;

    notifyListeners();
  }

  Future<void> fetchCompareSearch({
    required String searchTerm,
    bool isInitialLoading = true,
  }) async {
    try {
      _productsLoading = true;
      setState(state: ViewState.loading);
      _products = await _reader(coreRepository).fetchCompareSearch(
        searchTerm: searchTerm,
        lon: _filterLon,
        lat: _filterLat,
        distanceRange: isInitialLoading ? 10 : _sliderValue,
        minPrice: isInitialLoading ? 0 : _minPrice ?? 0,
        maxPrice: isInitialLoading ? 10000000000 : _maxPrice ?? 10000000000,
      );
      _productsLoading = false;
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      _productsLoading = false;
      setState(state: ViewState.error);
      // Alertify(title: e.error!).error();
    } finally {
      //Do something...
    }
  }

  Future<void> fetchItemsToCompare() async {
    try {
      _itemsToCompareLoading = true;
      setState(state: ViewState.loading);
      _itemsToCompare = await _reader(coreRepository).fetchItemsToCompare();
      _haveProductToCompare = _itemsToCompare.length > 1;
      _itemsToCompareLoading = false;
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      _itemsToCompareLoading = false;
      setState(state: ViewState.error);
      // Alertify(title: e.error!).error();
    } finally {
      //Do something...
    }
  }

  Future<void> autoCompleteM({
    required String query,
  }) async {
    print('Query......: $query');
    try {
      _searchLoading = true;
      setState(state: ViewState.loading);
      _autoComplete = await _reader(coreRepository).autoComplete(query: query);
      // return _autoComplete;
      // setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      _searchLoading = false;
      setState(state: ViewState.idle);
    } finally {
      _searchLoading = false;
    }
  }
}

final compareSearchNotifierProvider =
    ChangeNotifierProvider<CompareSearchNotifier>(
        (ref) => CompareSearchNotifier(ref.read));
