import 'dart:convert';

MessageListModel messageListModelFromJson(String str) =>
    MessageListModel.fromJson(json.decode(str));

String messageListToJson(MessageListModel data) => json.encode(data.toJson());

class MessageListModel{
  MessageListModel({
    required this.name,
    required this.type,
    required this.image,
    required this.unread,
    required this.msg,
    required this.time

  });

  String name;
  String type;
  String image;
  int unread;
  String msg;
  String time;

  factory MessageListModel.fromJson(Map<String, dynamic> json) => MessageListModel(
    name: json["name"],
    type: json["type"],
    image: json ["image"],
    unread: json ["unread"],
    msg: json["msg"],
    time: json["time"]

  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "type": type,
    "image": image,
    "unread": unread,
    "msg": msg,
    "time" : time

  };
}