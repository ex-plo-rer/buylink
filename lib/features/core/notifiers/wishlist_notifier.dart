import 'package:buy_link/features/core/models/product_attribute_model.dart';
import 'package:buy_link/repositories/core_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/strings.dart';
import '../../../core/routes.dart';
import '../../../core/utilities/alertify.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/view_state.dart';
import '../../../services/base/network_exception.dart';
import '../../../services/navigation_service.dart';
import '../models/product_model.dart';

class WishlistNotifier extends BaseChangeNotifier {
  final Reader _reader;

  WishlistNotifier(this._reader);

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  ProductAttrModel? _productAttr;
  ProductAttrModel get productAttr => _productAttr!;

  Future<void> addToWishlist({
    required int productId,
  }) async {
    try {
      setState(state: ViewState.loading);
      await _reader(coreRepository).addToWishList(
        productId: productId,
      );
      Alertify(title: 'Product Added to wishlist').success();
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error!).error();
    } finally {
      setState(state: ViewState.idle);
    }
  }

  Future<void> fetchProductAttr({
    required int productId,
  }) async {
    try {
      setState(state: ViewState.loading);
      _productAttr = await _reader(coreRepository).fetchProductAttr(
        productId: productId,
      );
      // Alertify(title: 'User logged in').success();
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error!).error();
    } finally {
      setState(state: ViewState.idle);
    }
  }

  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }
}

final wishlistNotifierProvider = ChangeNotifierProvider<WishlistNotifier>(
  (ref) => WishlistNotifier(ref.read),
);
