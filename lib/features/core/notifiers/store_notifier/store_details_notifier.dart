import 'package:buy_link/features/core/models/store_quick_model.dart';
import 'package:buy_link/repositories/store_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/alertify.dart';
import '../../../../core/utilities/base_change_notifier.dart';
import '../../../../core/utilities/view_state.dart';
import '../../../../services/base/network_exception.dart';
import '../../models/product_model.dart';
import '../wishlist_notifier.dart';

class StoreDetailsNotifier extends BaseChangeNotifier {
  final Reader _reader;
  final int storeId;

  StoreDetailsNotifier(this._reader, {required this.storeId}) {
    fetchStoreQuickDetails(
      storeId: storeId,
    );
  }

  late StoreQuickModel _storeDetails;

  StoreQuickModel get storeDetails => _storeDetails;

  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  bool _detailsLoading = false;

  bool get detailsLoading => _detailsLoading;

  final List<bool?> _fav = [];

  List<bool?> get fav => _fav;

  void setFav() {
    for (var product in _products) {
      _fav.add(product.isFav);
    }
  }

  void toggleFav({required int index, required int id}) {
    if (_fav[index]!) {
      _fav[index] = false;
      _reader(wishlistNotifierProvider).removeFromWishlist(productId: id);
    } else {
      _fav[index] = true;
      _reader(wishlistNotifierProvider).addToWishlist(productId: id);
    }
    // fetchProducts(category: category);
    notifyListeners();
  }

  Future<void> fetchStoreQuickDetails({
    required int storeId,
  }) async {
    try {
      _detailsLoading = true;
      setState(state: ViewState.loading);
      _storeDetails = await _reader(storeRepository).fetchStoreQuickDetails(
        storeId: storeId,
      );
      _detailsLoading = false;
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      _detailsLoading = false;
      setState(state: ViewState.error);
      Alertify(title: e.error).error();
    } finally {
      _detailsLoading = false;
      // setState(state: ViewState.idle);
    }
  }

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
      setFav();
      // }
      // Alertify(title: 'User logged in').success();
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error).error();
    } finally {
      // setState(state: ViewState.idle);
    }
  }
}

final storeDetailsNotifierProvider =
    ChangeNotifierProvider.family<StoreDetailsNotifier, int>(
  (ref, storeId) => StoreDetailsNotifier(
    ref.read,
    storeId: storeId,
  ),
);
