import 'package:buy_link/core/utilities/base_change_notifier.dart';
import 'package:buy_link/features/core/models/search_result_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/alertify.dart';
import '../../../../core/utilities/view_state.dart';
import '../../../../repositories/store_repository.dart';
import '../../../../services/base/network_exception.dart';
import '../../../../services/location_service.dart';
import '../../../../services/navigation_service.dart';

class InputSearchLocationNotifier extends BaseChangeNotifier {
  final Reader _reader;

  InputSearchLocationNotifier(this._reader);

  LoadResultsModel? _searchResult;

  LoadResultsModel? get searchResult => _searchResult;

  //LoadResultsModel get searchresult => _searchresult;
  double _filterLat = 0;
  double _filterLon = 0;

  double get filterLat => _filterLat;

  double get filterLon => _filterLon;

  void initLocation() {
    // Uses the initial location of when the app was lauched first.
    _filterLat = _reader(locationService).lat!;
    _filterLon = _reader(locationService).lon!;
    notifyListeners();
  }

  double _sliderValue = 10;

  double get sliderValue => _sliderValue;

  double? _minPrice;
  double? _maxPrice;

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
      _searchResult = await _reader(storeRepository).fetchProductSearch(
        searchTerm: searchTerm,
        lon: _filterLon,
        lat: _filterLat,
        distanceRange: _sliderValue,
        minPrice: _minPrice ?? 0,
        maxPrice: _maxPrice ?? 1000000000,
      );
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      // Alertify(title: e.error!).error();
    } finally {}
  }
}

final inputSearchLocationNotifierProvider =
    ChangeNotifierProvider<InputSearchLocationNotifier>(
        (ref) => InputSearchLocationNotifier(ref.read));
