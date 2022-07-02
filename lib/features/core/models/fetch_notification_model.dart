import 'dart:convert';

FetchNotificationModel fetchNotificationFromJson(String str) =>
    FetchNotificationModel.fromJson(json.decode(str));

String fetchNoticationToJson(FetchNotificationModel data) =>
    json.encode(data.toJson());

class FetchNotificationModel {
  FetchNotificationModel({
    required this.pushAlert,
    required this.productAlert,
    required this.chatAlert,
    required this.emailAlert,
  });

  bool pushAlert;
  bool productAlert;
  bool chatAlert;
  bool emailAlert;

  factory FetchNotificationModel.fromJson(Map<String, dynamic> json) =>
      FetchNotificationModel(
        pushAlert: json["push_alert"],
        productAlert: json["product_alert"],
        chatAlert: json["chat_alert"],
        emailAlert: json["email_alert"],
      );

  Map<String, dynamic> toJson() => {
        "push_alert": pushAlert,
        "product_alert": productAlert,
        "chat_alert": chatAlert,
        "email_alert": emailAlert,
      };
}
