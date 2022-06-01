import 'dart:convert';

LoadChatModel loadChatFromJson(String str) =>
    LoadChatModel.fromJson(json.decode(str));

String loadChatToJson(LoadChatModel data) => json.encode(data.toJson());

class LoadChatModel {
  LoadChatModel({
    required this.owner,
    required this.msg,
    required this.image,
    required this.time,
    required this.read,

  });

  String owner;
  String msg;
  String image;
  String time;
  String read;

  factory LoadChatModel.fromJson(Map<String, dynamic> json) => LoadChatModel(
    owner: json["owner"],
    msg: json["msg"],
    image: json ["image"],
    time: json ["time"],
    read: json["read"],

  );

  Map<String, dynamic> toJson() => {
    "owner": owner,
    "msg": msg,
    "image": image,
    "time": time,
    "read": read,

  };
}