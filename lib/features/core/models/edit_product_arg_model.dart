import 'package:buy_link/features/core/models/product_edit_model.dart';
import 'package:buy_link/features/core/models/product_model.dart';

class EditProductArgModel {
  Store store;
  ProductEditModel product;

  EditProductArgModel({
    required this.store,
    required this.product,
  });
}
