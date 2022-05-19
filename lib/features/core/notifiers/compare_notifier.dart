import 'package:buy_link/core/constants/strings.dart';
import 'package:buy_link/features/core/models/product_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/routes.dart';
import '../../../core/utilities/alertify.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/view_state.dart';
import '../../../repositories/core_repository.dart';
import '../../../services/base/network_exception.dart';
import '../../../services/local_storage_service.dart';
import '../../../services/navigation_service.dart';

class CompareNotifier extends BaseChangeNotifier {
  final Reader _reader;

  CompareNotifier(this._reader) {
    // saveProduct(product: product);
  }

  int _activeIndex = 0;
  int get activeIndex => _activeIndex;

  ProductModel? _product1;
  ProductModel? get product1 => _product1;

  ProductModel? _product2;
  ProductModel? get product2 => _product2;

  void nextPage(index, reason) {
    _activeIndex = index;
    print('$_activeIndex $index');
    notifyListeners();
  }

  Future<void> saveProduct({
    required ProductModel product,
  }) async {
    print('Product1: $product1');
    print('Product2: $product2');
    if (product1 == null) {
      print('product1 == null: ${product1 == null}');
      _product1 = product;
    } else {
      // _product2 = product;
      if (_product1!.id != _product2?.id) {
        print('product1!.id , product2?.id: ${product1!.id}, ${product2?.id}');
        print('product1!.id != product2?.id: ${product1!.id != product2?.id}');
        _product2 = product;
      }
      // else {
      //   _product2 = product;
      // }
    }
    print('Product1: $product1');
    print('Product2: $product2');
    notifyListeners();
  }
}

final compareNotifierProvider = ChangeNotifierProvider<CompareNotifier>(
  (ref) => CompareNotifier(ref.read),
);
