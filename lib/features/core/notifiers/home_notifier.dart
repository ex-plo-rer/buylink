import 'package:buy_link/features/core/models/product_attribute_model.dart';
import 'package:buy_link/repositories/core_repository.dart';
import 'package:buy_link/services/local_storage_service.dart';
import 'package:buy_link/services/location_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/strings.dart';
import '../../../core/routes.dart';
import '../../../core/utilities/alertify.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/view_state.dart';
import '../../../services/base/network_exception.dart';
import '../../../services/navigation_service.dart';
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

  Position? position;

  String _initialText = 'Latest products around you';

  String get initialText => _initialText;

  List<CategoryModel> _categories = [];

  List<CategoryModel> get categories => _categories;

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
        // lat: 3.4,
        // lon: 3.7,
        // TODO: the below
        lat: _reader(locationService).lat!,
        lon: _reader(locationService).lon!,
        category: category,
      );
      changeText(category: category ?? 'all');
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
