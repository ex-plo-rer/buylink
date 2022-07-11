import 'dart:async';

import 'package:buy_link/features/core/models/product_attribute_model.dart';
import 'package:buy_link/features/core/notifiers/category_notifier.dart';
import 'package:buy_link/features/core/notifiers/wishlist_notifier.dart';
import 'package:buy_link/repositories/core_repository.dart';
import 'package:buy_link/services/location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/alertify.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/view_state.dart';
import '../../../services/base/network_exception.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

class HomeNotifier extends BaseChangeNotifier {
  final Reader _reader;
  final String? category;

  HomeNotifier(
    this._reader, {
    required this.category,
  }) {
    fetchProducts(category: category);
    fetchRandomCategories();
  }

  bool _productLoading = false;

  bool get productLoading => _productLoading;
  bool _categoriesLoading = false;

  bool get categoriesLoading => _categoriesLoading;

  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;
  List<bool?> _fav = [];

  List<bool?> get fav => _fav;

  ProductAttrModel? _productAttr;

  ProductAttrModel get productAttr => _productAttr!;
  Position? position;

  String _initialText = 'Latest products around you';

  String get initialText => _initialText;

  List<CategoryModel> _categories = [];

  List<CategoryModel> get categories => _categories;

  Timer? timer;

  bool _showWelcome = true;

  bool get showWelcome => _showWelcome;

  bool willPopM() {
    if (_initialText != 'Latest products around you') {
      fetchProducts(category: 'all');
      return false;
    }
    return _initialText == 'Latest products around you';
  }

  void startTimer() async {
    await Future.delayed(const Duration(seconds: 2));
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      print(timer.tick);
      if (timer.tick == 10) {
        print(timer.tick);
        timer.cancel();
        _showWelcome = false;
        notifyListeners();
      }
    });
  }

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

  void changeText({required String category}) {
    _initialText = category == 'all'
        ? 'Latest products around you'
        : 'Latest products around you with tag \'$category\'';
  }

  Future<void> fetchRandomCategories() async {
    try {
      _categoriesLoading = true;
      setState(state: ViewState.loading);
      _categories = await _reader(coreRepository).fetchRandomCategories();
      _categoriesLoading = false;
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      _categoriesLoading = false;
      setState(state: ViewState.error);
      Alertify(title: e.error).error();
    } finally {
      //setState(state: ViewState.idle);
    }
  }

  Future<void> fetchProducts({
    required String? category,
  }) async {
    try {
      _productLoading = true;
      setState(state: ViewState.loading);
      // serviceEnabled = await Geolocator.isLocationServiceEnabled();
      // if (serviceEnabled) {
      await _reader(locationService).getCurrentLocation();
      _products = await _reader(coreRepository).fetchProducts(
        lat: _reader(locationService).lat!,
        lon: _reader(locationService).lon!,
        category: category,
      );
      _reader(categoryNotifierProvider).fetchUserCategories();
      changeText(category: category ?? 'all');
      setFav();
      _productLoading = false;
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      _productLoading = false;
      setState(state: ViewState.error);
      Alertify(title: e.error).error();
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

  bool _isFavorite = false;

  bool get isFavorite => _isFavorite;

  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }
}

final homeNotifierProvider =
    ChangeNotifierProvider.family<HomeNotifier, String?>(
  (ref, category) => HomeNotifier(
    ref.read,
    category: category,
  ),
);
