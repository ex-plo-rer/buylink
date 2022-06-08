import 'dart:convert';

FetchNotificationModel fetchNotificationFromJson(String str) =>
    FetchNotificationModel.fromJson(json.decode(str));

String fetchNoticationToJson(FetchNotificationModel data) => json.encode(data.toJson());

class FetchNotificationModel {
  FetchNotificationModel({
    required this.push_alert,
    required this.product_alert,
    required this.chat_alert,
    required this.email_alert,

  });
  bool push_alert;
  bool product_alert;
  bool chat_alert;
  bool email_alert;

  factory FetchNotificationModel.fromJson(Map<String, dynamic> json) => FetchNotificationModel(
    push_alert: json["push_alert"],
    product_alert: json["product_alert"],
    chat_alert: json ["chat_alert"],
    email_alert: json ["email_alert"],

  );

  Map<String, dynamic> toJson() => {
    "push_alert": push_alert,
    "product_alert": product_alert,
    "chat_alert": chat_alert,
    "email_alert": email_alert,
  };
}