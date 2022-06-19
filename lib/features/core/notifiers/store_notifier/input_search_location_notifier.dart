import 'package:buy_link/core/utilities/base_change_notifier.dart';
import 'package:buy_link/features/core/models/search_result_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/alertify.dart';
import '../../../../core/utilities/view_state.dart';
import '../../../../repositories/store_repository.dart';
import '../../../../services/base/network_exception.dart';
import '../../../../services/navigation_service.dart';

class InputSearchLocationNotifier extends BaseChangeNotifier {
  final Reader _reader;
  InputSearchLocationNotifier(this._reader) {
  }


  LoadResultsModel?  searchresult;
  //LoadResultsModel get searchresult => _searchresult;

  Future<void> fetchProductSearch({
    required String search_term,
    required double lon,
    required double lat,
    required int range,
    required int min_price,
    required int max_price,

  }) async {
    try {
      setState(state: ViewState.loading);
      searchresult = await _reader(storeRepository).fetchProductSearch(
          search_term: search_term,
          lon: lon,
          lat: lat,
          range: range,
          min_price: min_price,
          max_price: max_price);
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error!).error();
    } finally {}
  }

}

final inputSearchLocationNotifierProvider =
ChangeNotifierProvider<InputSearchLocationNotifier>((ref) => InputSearchLocationNotifier(ref.read));