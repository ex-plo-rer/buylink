import 'package:buy_link/features/core/models/product_model.dart';

// storeId is only required when we want to move to the messageview from storedashboard
class MessageModel {
  dynamic id;
  dynamic storeId;
  dynamic storeName;
  String name;
  String? imageUrl;
  String from;

  MessageModel({
    required this.id, // Id of the person I want to have a conversation with
    this.storeId,
    this.storeName,
    required this.name,
    required this.imageUrl,
    required this.from,
  });
}
