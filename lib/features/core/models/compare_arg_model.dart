import 'package:buy_link/features/core/models/product_model.dart';

class CompareArgModel {
  ProductModel? product;
  bool fromSearch;

  CompareArgModel({
    this.product,
    this.fromSearch = false,
  });
}
