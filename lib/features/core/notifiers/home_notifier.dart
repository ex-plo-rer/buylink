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
import '../models/product_model.dart';

class HomeNotifier extends BaseChangeNotifier {
  final Reader _reader;
  final String category;

  HomeNotifier(
    this._reader, {
    required this.category,
  }) {
    fetchProducts(
      category: category,
    );
  }

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  ProductAttrModel? _productAttr;
  ProductAttrModel get productAttr => _productAttr!;

  Position? position;
  //
  // Future<void> setLocation(context) async {
  //   position = await _reader(locationService).getCurrentLocation();
  // }

  Future<void> fetchProducts({
    required String category,
  }) async {
    try {
      setState(state: ViewState.loading);
      // serviceEnabled = await Geolocator.isLocationServiceEnabled();
      // if (serviceEnabled) {
      position = await _reader(locationService).getCurrentLocation();
      _products = await _reader(coreRepository).fetchProducts(
        lat: 3.4,
        lon: 3.7,
        //TODO: the below
        // lat: position!.latitude,
        // lon: position.longitude,
      );
      // }
      // Alertify(title: 'User logged in').success();
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

  final autoCompletee = [
    '_autoComplete',
    '_autoComplete2',
    '_autoComplete3',
    '_autoComplete4',
    '_autoComplete5',
  ];
  Future<List<String>> autoComplete({
    required String query,
  }) async {
    print('Query......: $query');
    try {
      setState(state: ViewState.loading);
      await Future.delayed(Duration(seconds: 5));
      return [
        '_autoComplete',
        '_autoComplete2',
        '_autoComplete3',
        '_autoComplete4',
        '_autoComplete5',
      ];
      // await _reader(coreRepository).autoComplete(query: query);
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.idle);
      return [];
    } finally {
      setState(state: ViewState.idle);
      // return [];
    }
  }

  // TODO: Modify this code and separate the shared preference to the local storage service
  Future<List<String>> getRecentSearchesLike(String query) async {
    final pref = await SharedPreferences.getInstance();
    final allSearches = pref.getStringList(AppStrings.recentSearchKey);
    return allSearches!.where((search) => search.startsWith(query)).toList();
  }

  Future<void> saveToRecentSearches(String searchText) async {
    final pref = await SharedPreferences.getInstance();

    //Use `Set` to avoid duplication of recentSearches
    Set<String> allSearches =
        pref.getStringList(AppStrings.recentSearchKey)?.toSet() ?? {};

    //Place it at first in the set
    allSearches = {searchText, ...allSearches};
    pref.setStringList(AppStrings.recentSearchKey, allSearches.toList());
  }
}

final homeNotifierProvider =
    ChangeNotifierProvider.family<HomeNotifier, String>(
  (ref, category) => HomeNotifier(
    ref.read,
    category: category,
  ),
);
