import 'package:buy_link/core/routes.dart';
import 'package:buy_link/features/core/models/store_quick_model.dart';
import 'package:buy_link/features/core/models/weekly_data_model.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/strings.dart';
import '../features/core/models/my_store_model.dart';
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

  Future<List<Store>> fetchMyStores() async {
    print(
        '_reader(userProvider).currentUser?.id ${_reader(userProvider).currentUser?.id}');
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
    };
    print('Fetch my stores params sent to server $body');

    var response = await networkService.post(
      'users/load-stores',
      body: body,
      headers: headers,
    );

    print('Fetch my stores response ${response}');
    List<Store> _myStores = [];
    for (var product in response) {
      _myStores.add(Store.fromJson(product));
    }

    print('Fetch my stores response $response');
    return _myStores;
  }

  Future<void> createStore({
    required String storeName,
    required String storeDescription,
    required double lon,
    required double lat,
    required String storeLogo,
    required String storeImage,
  }) async {
    print(
        '_reader(userProvider).currentUser?.id ${_reader(userProvider).currentUser?.id}');
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
      'name': storeName,
      'desc': storeDescription,
      'lon': lon,
      'lat': lat,
    };

    final files = {
      'logo': storeLogo,
      'bg': storeImage,
    };
    print('Create store params sent to server $body $files');

    var response = await networkService.postMultipart(
      'users/create-store',
      body: body,
      files: files,
      headers: headers,
    );

    print('Create store response $response');
    // return _myStores;
  }

  Future<void> editStore({
    required int storeId,
    required String attribute,
    required String newValue,
  }) async {
    print(
        '_reader(userProvider).currentUser?.id ${_reader(userProvider).currentUser?.id}');
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
      'store_id': storeId,
      'attr': attribute,
      'new': newValue,
    };
    print('Edit store params sent to server $body');

    var response = await networkService.post(
      'users/edit-store',
      body: body,
      headers: headers,
    );

    print('Edit store response $response');
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

  Future<WeeklyDataModel> fetchWeeklyData({
    required int storeId,
    required String week,
    required String domain,
  }) async {
    // await _reader(userProvider).setUser();
    print(
        '_reader(userProvider).currentUser?.id ${_reader(userProvider).currentUser?.id}');
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
      'store_id': storeId,
      'week': week,
      'domain': domain,
    };
    print('Fetch weekly data params sent to server $body');

    var response = await networkService.post(
      'users/load-data',
      body: body,
      headers: headers,
    );

    print('Fetch weekly data response ${response}');

    return WeeklyDataModel.fromJson(response);
  }

  Future<bool> deleteStore({
    required int storeId,
    required String password,
  }) async {
    print(
        '_reader(userProvider).currentUser?.id ${_reader(userProvider).currentUser?.id}');
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
      'store_id': storeId,
      'password': password,
    };
    print('Delete store params sent to server $body');

    var response = await networkService.post(
      'users/del-store',
      body: body,
      headers: headers,
    );

    print('Delete store response $response');
    return response['success'];
  }
}

final storeRepository = Provider(
  ((ref) => StoreRepository(
        ref.read,
        networkService: NetworkService(),
        storageService: LocalStorageService(),
      )),
);
