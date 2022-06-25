import 'package:buy_link/core/utilities/base_change_notifier.dart';
import 'package:buy_link/features/core/models/auto_complete_model.dart';
import 'package:buy_link/features/core/models/search_result_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/utilities/alertify.dart';
import '../../../../core/utilities/view_state.dart';
import '../../../../repositories/core_repository.dart';
import '../../../../repositories/store_repository.dart';
import '../../../../services/base/network_exception.dart';
import '../../../../services/location_service.dart';
import '../../../../services/navigation_service.dart';

class StoreLocationPickerNotifier extends BaseChangeNotifier {
  final Reader _reader;

  StoreLocationPickerNotifier(this._reader);

  SearchResultModel? _searchResult;

  SearchResultModel? get searchResult => _searchResult;

  double _filterLat = 0;
  double _filterLon = 0;

  double get filterLat => _filterLat;

  double get filterLon => _filterLon;

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

  void onMinPriceChanged(String value) {
    _minPrice = double.parse(value);
    notifyListeners();
  }

  void onMaxPriceChanged(String value) {
    _maxPrice = double.parse(value);
    notifyListeners();
  }

  void onSliderChanged(double newValue) {
    _sliderValue = newValue;
    notifyListeners();
  }

  Future<void> fetchProductSearch({
    required String searchTerm,
    bool isConfirmButton = true,
  }) async {
    try {
      setState(state: ViewState.loading);
      _searchResult = await _reader(storeRepository).fetchProductSearch(
        searchTerm: searchTerm,
        lon: _filterLon,
        lat: _filterLat,
        distanceRange: isConfirmButton ? 10 : _sliderValue,
        minPrice: isConfirmButton ? 0 : _minPrice ?? 0,
        maxPrice: isConfirmButton ? 10000000000 : _maxPrice ?? 10000000000,
      );
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
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

  // TODO: Modify this code and separate the shared preference to the local storage service
  Future<List<String>> getRecentSearchesLike(String query) async {
    final pref = await SharedPreferences.getInstance();
    final allSearches = pref.getStringList(AppStrings.recentSearchKey);
    return allSearches!.where((search) => search.startsWith(query)).toList();
  }

  Future<void> saveToRecentSearches(String searchText) async {
    final pref = await SharedPreferences.getInstance();

    //Use `Set` to avoid duplication of recentSearches
    Set<String> allSearches =
        pref.getStringList(AppStrings.recentSearchKey)?.toSet() ?? {};

    //Place it at first in the set
    allSearches = {searchText, ...allSearches};
    pref.setStringList(AppStrings.recentSearchKey, allSearches.toList());
  }
}

final storeLocationPickerNotifierProvider =
    ChangeNotifierProvider<StoreLocationPickerNotifier>(
        (ref) => StoreLocationPickerNotifier(ref.read));
