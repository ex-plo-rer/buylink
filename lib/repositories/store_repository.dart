import 'package:buy_link/core/routes.dart';
import 'package:buy_link/features/core/models/store_quick_model.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/strings.dart';
import '../features/core/models/product_model.dart';
import '../features/core/models/user_model.dart';
import '../features/core/notifiers/user_provider.dart';
import '../services/local_storage_service.dart';
import '../services/network/network_service.dart';

class StoreRepository {
  final Reader _reader;
  final NetworkService networkService;
  final LocalStorageService storageService;

  StoreRepository(
    this._reader, {
    required this.networkService,
    required this.storageService,
  });

  var headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
  };

  Future<StoreQuickModel> fetchStoreQuickDetails({
    required int storeId,
  }) async {
    print(
        '_reader(userProvider).currentUser?.id ${_reader(userProvider).currentUser?.id}');
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
      'store_id': storeId,
    };
    print('Fetch store quick details params sent to server $body');

    var response = await networkService.post(
      'users/load-store',
      body: body,
      headers: headers,
    );

    print('Fetch store quick details response ${response}');

    return StoreQuickModel.fromJson(response);
  }

  Future<List<ProductModel>> fetchStoreProducts({
    required int storeId,
    required String category,
  }) async {
    // await _reader(userProvider).setUser();
    print(
        '_reader(userProvider).currentUser?.id ${_reader(userProvider).currentUser?.id}');
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
      'store_id': storeId,
      'category': category,
    };
    print('Fetch store products params sent to server $body');

    var response = await networkService.post(
      'users/store-products/1',
      body: body,
      headers: headers,
    );

    print('Fetch store products response ${response}');
    List<ProductModel> _products = [];
    for (var product in response) {
      _products.add(ProductModel.fromJson(product));
    }

    print('Fetch store products response $response');
    return _products;
  }
}

final storeRepository = Provider(
  ((ref) => StoreRepository(
        ref.read,
        networkService: NetworkService(),
        storageService: LocalStorageService(),
      )),
);
