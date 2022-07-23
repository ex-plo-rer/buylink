import 'package:buy_link/features/core/models/category_model.dart';
import 'package:buy_link/repositories/core_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/alertify.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/view_state.dart';
import '../../../services/base/network_exception.dart';

class CategoryNotifier extends BaseChangeNotifier {
  final Reader _reader;

  CategoryNotifier(this._reader) {
    // fetchRandomCategories();
    fetchUserCategories();
    fetchAllCategories();
  }

  List<String> _userCategories = [];

  List<String> get userCategories => _userCategories;

  List<String> _allCategories = [];

  List<String> get allCategories => _allCategories;

  List<String> _storeCategories = [];

  List<String> get storeCategories => _storeCategories;

  bool _storeCategoriesLoading = false;

  bool get storeCategoriesLoading => _storeCategoriesLoading;

  bool _userCategoriesLoading = false;

  bool get userCategoriesLoading => _userCategoriesLoading;

  // List<String> uwserCategories = [];

  // List<CategoryModel> _categories = [];

  // List<CategoryModel> get userCategories => _userCategories;
  List<CategoryModel> mCategories = [];

  Future<void> fetchAllCategories() async {
    // _userCategoriesLoading = true;
    try {
      setState(state: ViewState.loading);
      _allCategories = await _reader(coreRepository).fetchAllCategories();
      // _userCategoriesLoading = false;
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      // _userCategoriesLoading = false;
      setState(state: ViewState.error);
      Alertify(title: e.error).error();
    } finally {
      //setState(state: ViewState.idle);
    }
  }

  Future<void> fetchUserCategories() async {
    _userCategoriesLoading = true;
    try {
      setState(state: ViewState.loading);
      _userCategories = await _reader(coreRepository).fetchUserCategories();
      _userCategoriesLoading = false;
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      _userCategoriesLoading = false;
      setState(state: ViewState.error);
      // Alertify(title: e.error).error();
    } finally {
      //setState(state: ViewState.idle);
    }
  }

  Future<void> fetchStoreCategories({required String storeId}) async {
    try {
      _storeCategoriesLoading = true;
      setState(state: ViewState.loading);
      _storeCategories =
          await _reader(coreRepository).fetchStoreCategories(storeId: storeId);
      _storeCategoriesLoading = false;
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error).error();
    } finally {
      //setState(state: ViewState.idle);
    }
  }

  void dump() {
    _userCategories.clear();
    _storeCategories.clear();
    // _init = true;
    notifyListeners();
  }
}

final categoryNotifierProvider = ChangeNotifierProvider<CategoryNotifier>(
  (ref) => CategoryNotifier(ref.read),
);
