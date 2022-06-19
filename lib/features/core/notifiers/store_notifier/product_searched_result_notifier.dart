import 'package:buy_link/features/core/models/search_result_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/base_change_notifier.dart';

class ProductSearchResultNotifier extends BaseChangeNotifier {
  final Reader _reader;

  ProductSearchResultNotifier(this._reader) {

  }

  List<LoadResultsModel> _searchresult = [];
  List<LoadResultsModel> get searchresult => _searchresult;

}

final productSearchResultNotifierProvider =
ChangeNotifierProvider<ProductSearchResultNotifier>((ref) => ProductSearchResultNotifier(ref.read));
