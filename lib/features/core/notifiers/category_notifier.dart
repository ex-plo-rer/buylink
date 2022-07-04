import 'package:buy_link/features/core/models/category_model.dart';
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

class CategoryNotifier extends BaseChangeNotifier {
  final Reader _reader;

  CategoryNotifier(this._reader) {
    // fetchRandomCategories();
    fetchUserCategories();
  }

  List<String> _userCategories = [];

  List<String> get userCategories => _userCategories;

  List<String> _storeCategories = [];

  List<String> get storeCategories => _storeCategories;

  bool _storeCategoriesLoading = false;
  bool get storeCategoriesLoading => _storeCategoriesLoading;

  // List<String> uwserCategories = [];

  // List<CategoryModel> _categories = [];

  // List<CategoryModel> get userCategories => _userCategories;
  List<CategoryModel> mCategories = [];

  Future<void> fetchUserCategories() async {
    try {
      setState(state: ViewState.loading);
      _userCategories = await _reader(coreRepository).fetchUserCategories();
      // userCategories = [
      //   CategoryModel(id: 99101, name: 'All', image: ''),
      //   ..._userCategories
      // ];
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error).error();
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
}

final categoryNotifierProvider = ChangeNotifierProvider<CategoryNotifier>(
  (ref) => CategoryNotifier(ref.read),
);
