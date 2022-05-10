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

  Future<void> removeFromWishlist({
    required int productId,
  }) async {
    try {
      setState(state: ViewState.loading);
      await _reader(coreRepository).removeFromWishList(
        productId: productId,
      );
      Alertify(title: 'Product removed from wishlist').success();
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error!).error();
    } finally {
      setState(state: ViewState.idle);
    }
  }
}

final wishlistNotifierProvider = ChangeNotifierProvider<WishlistNotifier>(
  (ref) => WishlistNotifier(ref.read),
);
