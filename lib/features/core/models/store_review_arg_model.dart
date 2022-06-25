import 'package:buy_link/features/core/models/product_model.dart';
import 'package:buy_link/features/core/models/search_result_model.dart';
import 'package:latlong2/latlong.dart';

class StoreReviewArgModel {
  String storeName;
  int storeId;

  StoreReviewArgModel({
    required this.storeName,
    required this.storeId,
  });
}
