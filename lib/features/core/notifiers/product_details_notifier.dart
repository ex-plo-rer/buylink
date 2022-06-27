import 'package:buy_link/core/constants/strings.dart';
import 'package:buy_link/features/core/models/product_model.dart';
import 'package:buy_link/features/core/notifiers/wishlist_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/routes.dart';
import '../../../core/utilities/alertify.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/view_state.dart';
import '../../../repositories/core_repository.dart';
import '../../../services/base/network_exception.dart';
import '../../../services/local_storage_service.dart';
import '../../../services/navigation_service.dart';
import '../models/product_attribute_model.dart';

class ProductDetailsNotifier extends BaseChangeNotifier {
  final Reader _reader;
  // final int productId;

  ProductDetailsNotifier(
    this._reader,
    //     {
    //   required this.productId,
    // }
  ) {
    // fetchSimilarProducts(productId: productId);
  }

  int _activeIndex = 0;

  int get activeIndex => _activeIndex;

  List<ProductModel> _products = [];

  List<ProductModel> get similarProducts => _products;

  ProductAttrModel? _productAttr;
  ProductAttrModel get productAttr => _productAttr!;

  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  bool _addingToFav = false;
  bool get addingToFav => _addingToFav;

  void setFavorite(bool value) {
    _isFavorite = value;
    notifyListeners();
  }

  Future<void> onFavTapped({required int productId}) async {
    _addingToFav = true;
    if (_isFavorite) {
      await _reader(wishlistNotifierProvider)
          .removeFromWishlist(productId: productId);
      _isFavorite = false;
    } else {
      await _reader(wishlistNotifierProvider)
          .addToWishlist(productId: productId);
      _isFavorite = true;
    }
    _addingToFav = false;
    notifyListeners();
  }

  void nextPage(index, reason) {
    _activeIndex = index;
    print('$_activeIndex $index');
    notifyListeners();
  }

  Future<void> fetchSimilarProducts({
    required int productId,
  }) async {
    try {
      setState(state: ViewState.loading);
      _products = await _reader(coreRepository).fetchSimilarProducts(
        productId: productId,
      );
      // Alertify(title: 'User logged in').success();
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      // Alertify(title: e.error!).error();
    } finally {
      // setState(state: ViewState.idle);
    }
  }

  Future<void> fetchProductAttr({
    required int productId,
  }) async {
    try {
      setState(state: ViewState.loading);
      _productAttr =
          await _reader(coreRepository).fetchProductAttr(productId: productId);
      // Alertify(title: 'User logged in').success();
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error).error();
    } finally {
      setState(state: ViewState.idle);
    }
  }
}

final productDetailsNotifierProvider =
    ChangeNotifierProvider<ProductDetailsNotifier>(
  (ref) => ProductDetailsNotifier(
    ref.read,
    // productId: productId,
  ),
);
