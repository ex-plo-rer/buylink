import 'package:buy_link/features/core/models/product_model.dart';

// storeId is only required when we want to move to the messageview from storedashboard
class MessageModel {
  dynamic id;
  dynamic storeId;
  String name;
  String? imageUrl;
  bool fromUser;

  MessageModel({
    required this.id,
    this.storeId,
    required this.name,
    required this.imageUrl,
    required this.fromUser,
  });
}
