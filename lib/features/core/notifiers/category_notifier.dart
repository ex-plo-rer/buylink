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
    fetchCategories();
  }

  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;
  List<CategoryModel> mCategories = [];

  Future<void> fetchCategories() async {
    try {
      setState(state: ViewState.loading);
      _categories = await _reader(coreRepository).fetchCategories();
      mCategories = [
        CategoryModel(id: 99101, name: 'All', image: ''),
        ..._categories
      ];
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error!).error();
    } finally {
      setState(state: ViewState.idle);
    }
  }
}

final categoryNotifierProvider = ChangeNotifierProvider<CategoryNotifier>(
  (ref) => CategoryNotifier(ref.read),
);
