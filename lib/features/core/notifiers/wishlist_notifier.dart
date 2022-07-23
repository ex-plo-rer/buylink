import 'package:buy_link/repositories/core_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/alertify.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/view_state.dart';
import '../../../services/base/network_exception.dart';
import '../models/product_model.dart';

class WishlistNotifier extends BaseChangeNotifier {
  final Reader _reader;

  WishlistNotifier(this._reader) {
    // fetchWishlist(category: 'all');
    initCall();
  }

  bool _init = true;

  bool get init => _init;

  void initCall() {
    fetchWishlist(category: 'all');
    _init = false;
  }

  List<ProductModel> _products = [];
  final List<ProductModel> _localProducts = [];

  List<ProductModel> get products => _localProducts;

  final List<bool?> _fav = [];

  List<bool?> get fav => _fav;

  bool _favLoading = false;

  bool get favLoading => _favLoading;

  void setLocalProducts() {
    // for (var product in _products) {
    _localProducts.addAll(_products);
    // }
  }

  void removeFromFav({required int index, required int id}) {
    _localProducts.removeAt(index);
    removeFromWishlist(productId: id);
    notifyListeners();
  }

  Future<void> fetchWishlist({
    required String category,
  }) async {
    try {
      _localProducts.clear();
      _favLoading = true;
      setState(state: ViewState.loading);
      _products = await _reader(coreRepository).fetchWishList(
        category: category,
      );
      setLocalProducts();
      _favLoading = false;
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      _favLoading = false;
      setState(state: ViewState.error);
      Alertify(title: e.error).error();
    } finally {
      //setState(state: ViewState.idle);
    }
  }

  Future<void> addToWishlist({
    required int productId,
  }) async {
    try {
      // setState(state: ViewState.loading);
      await _reader(coreRepository).addToWishList(
        productId: productId,
      );
      // Alertify(title: 'Product Added to wishlist').success();
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      // Alertify(title: e.error).error();
    } finally {
      // setState(state: ViewState.idle);
    }
  }

  Future<void> removeFromWishlist({
    required int productId,
  }) async {
    try {
      setState(state: ViewState.loading);
      await _reader(coreRepository).removeFromWishList(
        productId: productId,
      );
      // Alertify(title: 'Product removed from wishlist').success();
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      // Alertify(title: e.error).error();
    } finally {
      // setState(state: ViewState.idle);
    }
  }

  void dump() {
    _products.clear();
    _localProducts.clear();
    _fav.clear();
    _init = true;
    setState(state: ViewState.idle);
    notifyListeners();
  }
}

final wishlistNotifierProvider = ChangeNotifierProvider<WishlistNotifier>(
  (ref) => WishlistNotifier(ref.read),
);
// final wishlistNotifierProvider =
//     ChangeNotifierProvider.family<WishlistNotifier, String>(
//   (ref, category) => WishlistNotifier(
//     ref.read,
//     category: category,
//   ),
// );
