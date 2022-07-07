import 'package:buy_link/features/core/models/search_result_model.dart';
import 'package:latlong2/latlong.dart';

class SearchResultArgModel {
  LatLng filterPosition;
  double radius;
  SearchResultModel searchResult;
  String searchTerm;

  SearchResultArgModel({
    required this.filterPosition,
    required this.radius,
    required this.searchResult,
    required this.searchTerm,
  });
}
