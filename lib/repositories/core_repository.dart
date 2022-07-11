import 'package:buy_link/core/routes.dart';
import 'package:buy_link/features/core/models/analytics_model.dart';
import 'package:buy_link/features/core/models/auto_complete_model.dart';
import 'package:buy_link/features/core/models/category_model.dart';
import 'package:buy_link/features/core/models/product_attribute_model.dart';
import 'package:buy_link/features/core/models/product_model.dart';
import 'package:buy_link/features/core/models/review_stats_model.dart';
import 'package:buy_link/features/core/models/reviews_model.dart';
import 'package:buy_link/features/core/models/saved_session_model.dart';
import 'package:buy_link/features/core/notifiers/user_provider.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/strings.dart';
import '../features/core/models/most_searched_count_model.dart';
import '../features/core/models/most_searched_model.dart';
import '../features/core/models/product_edit_model.dart';
import '../features/core/models/search_result_model.dart';
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

  Future<bool> deleteProduct({
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
    print('Delete product params sent to server $body');

    var response = await networkService.post(
      'users/del-product',
      body: body,
      headers: headers,
    );

    print('Delete product response $response');

    return response['success'];
  }

  Future<ProductEditModel> loadEdit({
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
    print('Load edit params sent to server $body');

    var response = await networkService.post(
      'users/load-edit',
      body: body,
      headers: headers,
    );

    print('Load edit response $response');

    return ProductEditModel.fromJson(response);
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

  Future<List<CategoryModel>> fetchRandomCategories() async {
    print(
        '_reader(userProvider).currentUser?.id ${_reader(userProvider).currentUser?.id}');
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
    };
    print('Fetch random categories params sent to server $body');

    var response = await networkService.post(
      'users/load-categories?no=5',
      body: body,
      headers: headers,
    );

    print('Fetch categories response $response');
    List<CategoryModel> _category = [];
    for (var category in response) {
      _category.add(CategoryModel.fromJson(category));
    }

    return _category;
  }

  Future<List<String>> fetchStoreCategories({required String storeId}) async {
    print(
        '_reader(userProvider).currentUser?.id ${_reader(userProvider).currentUser?.id}');
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
      'store_id': storeId,
    };
    print('Fetch store categories params sent to server $body');

    var response = await networkService.post(
      'users/in-cats/store',
      body: body,
      headers: headers,
    );

    print('Fetch store categories response $response');
    List<String> _category = [];
    for (var category in response['categories']) {
      _category.add(category);
    }

    return _category;
  }

  Future<List<String>> fetchAllCategories() async {
    print(
        '_reader(userProvider).currentUser?.id ${_reader(userProvider).currentUser?.id}');
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
    };
    print('Fetch all categories params sent to server $body');

    var response = await networkService.post(
      'users/all-categories',
      body: body,
      headers: headers,
    );

    print('Fetch all categories response $response');
    List<String> _category = [];
    for (var category in response) {
      _category.add(category);
    }

    return _category;
  }

  Future<List<String>> fetchUserCategories() async {
    print(
        '_reader(userProvider).currentUser?.id ${_reader(userProvider).currentUser?.id}');
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
    };
    print('Fetch user categories params sent to server $body');

    var response = await networkService.post(
      'users/in-cats/wish',
      body: body,
      headers: headers,
    );

    print('Fetch user categories response $response');
    List<String> _category = [];
    for (var category in response['categories']) {
      _category.add(category);
    }

    return _category;
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
    return '';
  }

  Future<void> addReview({
    required int storeId,
    required double star,
    String? title,
    String? body,
  }) async {
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final routeBody = {
      // TODO: Uncomment this
      // 'id': id,
      // 'store_id': storeId,
      'id': 1,
      'store_id': 1,
      'star': star,
      'title': title,
      'body': body,
    };
    print('Add review body sent to server $routeBody');
    var response = await networkService.post(
      'users/add-review',
      body: routeBody,
      headers: headers,
    );
    print('Add review response $response');
  }

  Future<ReviewStatsModel> fetchReviewStats({
    required int storeId,
  }) async {
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
      'store_id': storeId,
    };
    print('Fetch review stat body sent to server $body');
    var response = await networkService.post(
      'users/review-stats',
      body: body,
      headers: headers,
    );
    print('Fetch review stat response $response');
    return ReviewStatsModel.fromJson(response);
  }

  Future<List<ReviewsModel>> fetchReviews({
    required int storeId,
  }) async {
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
      'store_id': storeId,
    };
    print('Fetch reviews body sent to server $body');
    var response = await networkService.post(
      'users/load-reviews/1',
      body: body,
      headers: headers,
    );

    print('Fetch reviews response $response');

    List<ReviewsModel> _reviews = [];
    for (var review in response) {
      _reviews.add(ReviewsModel.fromJson(review));
    }

    print('Fetch reviews response $response');
    return _reviews;
  }

  Future<String> addProduct({
    required int storeId,
    required String name,
    // required List<String?> images,
    required String? image1,
    required String? image2,
    required String? image3,
    required String? image4,
    required String? price,
    required String? oldPrice,
    required String? category,
    required String? description,
    required String? brand,
    required String? colors,
    required String? minAge,
    required String? maxAge,
    required String? minWeight,
    required String? maxWeight,
    required String? size,
    required String? model,
    required String? material,
    required String? care,
  }) async {
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
      'name': name,
      'store_id': storeId,
      'price': price,
      'old_price': oldPrice,
      'cat': category,
      'desc': description,
      'brand': brand,
      'colors': colors,
      'age_min': minAge,
      'age_max': maxAge,
      'w_min': minWeight,
      'w_max': maxWeight,
      'size': size,
      'model': model,
      'material': material,
      'care': care,
    };
    final files = {
      'image1': image1,
      'image2': image2,
      'image3': image3,
      'image4': image4,
    };
    print('Add product params sent to server $body. Files: $files');

    var response = await networkService.postMultipart(
      'users/add-product',
      body: body,
      files: files,
      headers: headers,
    );

    print('Add product response $response');

    return '';
  }

  Future<String> updateProduct({
    required int productId,
    required String name,
    required String? price,
    required String? oldPrice,
    required String? category,
    required String? description,
    required String? brand,
    required String? colors,
    required String? minAge,
    required String? maxAge,
    required String? minWeight,
    required String? maxWeight,
    required String? size,
    required String? model,
    required String? material,
    required String? care,
  }) async {
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
      'name': name,
      'product_id': productId,
      'price': price,
      'old_price': oldPrice,
      'cat': category,
      'desc': description,
      'brand': brand,
      'colors': colors,
      'age_min': minAge,
      'age_max': maxAge,
      'w_min': minWeight,
      'w_max': maxWeight,
      'size': size,
      'model': model,
      'material': material,
      'care': care,
    };
    print('Add product params sent to server $body.');

    var response = await networkService.post(
      'users/update-product',
      body: body,
      headers: headers,
    );

    print('Add product response $response');

    return '';
  }

  Future<MostSearchedModel> getMostSearchedNCount({
    required int storeId,
  }) async {
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
      'store_id': storeId,
    };
    print('Get most searched body sent to server $body');
    var response = await networkService.post(
      'users/most-searched',
      body: body,
      headers: headers,
    );

    print('Get most searched response $response');

    // List<MostSearchedModel> _products = [];
    // for (var review in response) {
    //   _products.add(MostSearchedModel.fromJson(review));
    // }
    //
    // print('Get most searched response $response');
    // return _products;
    return MostSearchedModel.fromJson(response);
  }

  Future<AnalyticsModel> getAnalytics({
    required String type,
    required int storeId,
    required String? week,
  }) async {
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
      'store_id': storeId,
      'week': week ?? 'current',
    };
    print('Get analytics body sent to server $body');
    var response = await networkService.post(
      'users/get-analytics/${type.toLowerCase() == 'search' ? 'search' : 'visit'}',
      body: body,
      headers: headers,
    );

    print('Get analytics response $response');

    return AnalyticsModel.fromJson(response);
  }

  // Future<int> getProductCount({
  //   required String type,
  //   required int storeId,
  // }) async {
  //   var id = _reader(userProvider).currentUser?.id ?? 0;
  //   final body = {
  //     'id': id,
  //     'store_id': storeId,
  //   };
  //   print('Get product count body sent to server $body');
  //   var response = await networkService.post(
  //     'users/${type.toLowerCase() == 'saved' ? 'get-saved' : 'get-count'}',
  //     body: body,
  //     headers: headers,
  //   );
  //
  //   print('Get product count response $response');
  //
  //   return response['no'];
  // }

  Future<void> initDash({required int storeId}) async {
    await getMostSearchedNCount(storeId: storeId);
    await getAnalytics(type: 'search', storeId: storeId, week: 'current');
    await getAnalytics(type: 'visit', storeId: storeId, week: 'current');
    // await getProductCount(type: 'all', storeId: storeId);
    // await getProductCount(type: 'saved', storeId: storeId);
  }

  Future<AutoCompleteModel> autoComplete({
    required String query,
  }) async {
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
      'search_term': query,
      'domain': 'front',
    };
    print('Auto complete body sent to server $body');
    var response = await networkService.post(
      'users/auto-complete/4?no=5',
      body: body,
      headers: headers,
    );

    print('Auto complete response $response');

    // List<String> _autoComplete = [];
    // for (var text in response) {
    //   _autoComplete.add(text);
    // }
    //
    // print('Auto complete response $response');
    return AutoCompleteModel.fromJson(response);
  }

  Future<void> saveSession({
    required String chatId,
    required String message,
    required String actor,
  }) async {
    final body = {
      'chat_id': chatId,
      'msg': message,
      'actor': actor,
    };
    print('Save session body sent to server $body');
    var response = await networkService.post(
      'users/save-session',
      body: body,
      headers: headers,
    );

    print('Save session response $response');
  }

  Future<List<SavedSessionModel>> getSessions({
    required String sessionId,
    required String suffix,
  }) async {
    final body = {
      'sess_id': sessionId,
      'suffix': suffix,
    };
    print('Get session body sent to server $body');
    var response = await networkService.post(
      'users/get-sessions',
      body: body,
      headers: headers,
    );

    print('Get session response $response');

    List<SavedSessionModel> _sessions = [];
    for (var session in response) {
      print('Single session response $session');
      _sessions.add(SavedSessionModel.fromJson(session));
    }

    print('Get session response $response');
    return _sessions;
  }

  Future<SearchResultModel> fetchProductSearch({
    required String searchTerm,
    required double lon,
    required double lat,
    required double distanceRange,
    required double minPrice,
    required double maxPrice,
  }) async {
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
      'search_term': searchTerm,
      'lon': lon,
      'lat': lat,
      'range': distanceRange,
      'min_price': minPrice,
      'max_price': maxPrice
    };
    print('Fetch search result params sent to server $body');
    var response = await networkService.post(
      'users/load-results',
      body: body,
      headers: headers,
    );
    print('search products response $response');
    return SearchResultModel.fromJson(response);
  }

  Future<List<ProductModel>> fetchCompareSearch({
    required String searchTerm,
    required double lon,
    required double lat,
    required double distanceRange,
    required double minPrice,
    required double maxPrice,
  }) async {
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
      'search_term': searchTerm,
      'lon': lon,
      'lat': lat,
      'range': distanceRange,
      'min_price': minPrice,
      'max_price': maxPrice
    };
    print('Fetch compare search result params sent to server $body');
    var response = await networkService.post(
      'users/cmp-search',
      body: body,
      headers: headers,
    );
    print('compare search products response 1 $response');
    List<ProductModel> _products = [];
    for (var product in response) {
      _products.add(ProductModel.fromJson(product));
    }
    print('compare search products response 2 $response');
    return _products;
  }

  Future<List<ProductModel>> fetchItemsToCompare() async {
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
    };
    print('Fetch items to compare params sent to server $body');
    var response = await networkService.post(
      'users/compare',
      body: body,
      headers: headers,
    );
    print('items to compare response 1 $response');
    List<ProductModel> _products = [];
    for (var product in response) {
      _products.add(ProductModel.fromJson(product));
    }
    print('items to compare response 2 $response');
    return _products;
  }

  Future<bool> addItemToCompare({
    required int productId,
  }) async {
    var id = _reader(userProvider).currentUser?.id ?? 0;
    final body = {
      'id': id,
      'product_id': productId,
    };
    print('Add items to compare params sent to server $body');
    var response = await networkService.post(
      'users/add-compare',
      body: body,
      headers: headers,
    );
    print('Add items to compare response $response');
    return response['success'];
  }
}

final coreRepository = Provider(
  ((ref) => CoreRepository(
        ref.read,
        networkService: NetworkService(),
        storageService: LocalStorageService(),
      )),
);
