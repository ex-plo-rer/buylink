import 'package:buy_link/core/routes.dart';
import 'package:buy_link/features/core/models/product_attribute_model.dart';
import 'package:buy_link/features/core/models/product_model.dart';
import 'package:buy_link/features/core/notifiers/user_provider.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/strings.dart';
import '../features/core/models/user_model.dart';
import '../services/local_storage_service.dart';
import '../services/network/network_service.dart';

class CoreRepository {
  final Reader _reader;
  final NetworkService networkService;
  final LocalStorageService storageService;

  CoreRepository(
    this._reader, {
    required this.networkService,
    required this.storageService,
  });

  var headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
  };

  Future<List<ProductModel>> fetchProducts({
    required double lat,
    required double lon,
    String? category,
  }) async {
    // await _reader(userProvider).setUser();
    print(
        '_reader(userProvider).currentUser?.id ${_reader(userProvider).currentUser?.id}');
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
      'lat': lat,
      'lon': lon,
      'cat': category ?? 'all',
    };
    print('Fetch products params sent to server $body');

    var response = await networkService.post(
      'users/load-products',
      body: body,
      headers: headers,
    );

    print('Fetch products response $response');
    List<ProductModel> _products = [];
    for (var product in response) {
      _products.add(ProductModel.fromJson(product));
    }

    print('Fetch products response $response');
    return _products;
  }

  Future<ProductAttrModel> fetchProductAttr({
    required int productId,
  }) async {
    // await _reader(userProvider).setUser();
    print(
        '_reader(userProvider).currentUser?.id ${_reader(userProvider).currentUser?.id}');
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
      'product_id': productId,
    };
    print('Fetch product attribute params sent to server $body');

    var response = await networkService.post(
      'users/load-attributes',
      body: body,
      headers: headers,
    );

    print('Fetch product attribute response $response');

    return ProductAttrModel.fromJson(response);
  }

  Future<List<ProductModel>> fetchSimilarProducts({
    required int productId,
  }) async {
    // await _reader(userProvider).setUser();
    print(
        '_reader(userProvider).currentUser?.id ${_reader(userProvider).currentUser?.id}');
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
      'product_id': productId,
    };
    print('Fetch similar products params sent to server $body');

    var response = await networkService.post(
      'users/similar-products',
      body: body,
      headers: headers,
    );

    print('Fetch similar products attribute response $response');
    List<ProductModel> _products = [];
    for (var product in response) {
      _products.add(ProductModel.fromJson(product));
    }

    return _products;
  }

  Future<List<ProductModel>> fetchWishList({
    required String category,
  }) async {
    print(
        '_reader(userProvider).currentUser?.id ${_reader(userProvider).currentUser?.id}');
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
      'category': category,
    };
    print('Fetch wishlist params sent to server $body');

    var response = await networkService.post(
      'users/wishlist/1',
      body: body,
      headers: headers,
    );

    print('Fetch wishlist response $response');
    List<ProductModel> _products = [];
    for (var product in response) {
      _products.add(ProductModel.fromJson(product));
    }

    return _products;
  }

  Future<String> addToWishList({
    required int productId,
  }) async {
    // await _reader(userProvider).setUser();
    print(
        '_reader(userProvider).currentUser?.id ${_reader(userProvider).currentUser?.id}');
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
      'product_id': productId,
    };
    print('Add to wishlist params sent to server $body');

    var response = await networkService.post(
      'users/add-wish',
      body: body,
      headers: headers,
    );

    print('Add to wishlist response $response');
    // List<ProductModel> _products = [];
    // for (var product in response) {
    //   _products.add(ProductModel.fromJson(product));
    // }

    return '';
  }

  Future<String> removeFromWishList({
    required int productId,
  }) async {
    // await _reader(userProvider).setUser();
    print(
        '_reader(userProvider).currentUser?.id ${_reader(userProvider).currentUser?.id}');
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
      'product_id': productId,
    };
    print('Remove from wishlist params sent to server $body');

    var response = await networkService.post(
      'users/remove-wish',
      body: body,
      headers: headers,
    );

    print('Remove from wishlist response $response');
    // List<ProductModel> _products = [];
    // for (var product in response) {
    //   _products.add(ProductModel.fromJson(product));
    // }

    return '';
  }
}

final coreRepository = Provider(
  ((ref) => CoreRepository(
        ref.read,
        networkService: NetworkService(),
        storageService: LocalStorageService(),
      )),
);
