import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/alertify.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/view_state.dart';
import '../../../repositories/store_repository.dart';
import '../../../services/base/network_exception.dart';
import '../models/product_model.dart';

class ProductListNotifier extends BaseChangeNotifier {
  final Reader _reader;

  ProductListNotifier(this._reader) {
    // fetchWishlist(category: category);
  }

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  Future<void> fetchStoreProducts({
    required int storeId,
    required String category,
  }) async {
    try {
      setState(state: ViewState.loading);
      _products = await _reader(storeRepository).fetchStoreProducts(
        storeId: storeId,
        category: category,
      );
      // }
      // Alertify(title: 'User logged in').success();
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error!).error();
    } finally {
      // setState(state: ViewState.idle);
    }
  }
}

final productListNotifierProvider = ChangeNotifierProvider<ProductListNotifier>(
  (ref) => ProductListNotifier(ref.read),
);
// final wishlistNotifierProvider =
//     ChangeNotifierProvider.family<ProductListNotifier, String>(
//   (ref, category) => ProductListNotifier(
//     ref.read,
//     category: category,
//   ),
// );
