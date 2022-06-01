import 'dart:convert';

ChatBuddyModel chatBuddyFromJson(String str) =>
    ChatBuddyModel.fromJson(json.decode(str));

String chatBuddyToJson(ChatBuddyModel data) => json.encode(data.toJson());

class ChatBuddyModel {
  ChatBuddyModel({
    required this.cd_id,
    required this.type,
    required this.name,
    required this.image,
    required this.last_seen,

  });

  int cd_id;
  String type;
  String name;
  String image;
  String last_seen;

  factory ChatBuddyModel.fromJson(Map<String, dynamic> json) => ChatBuddyModel(
   cd_id: json["cd_id"],
    type: json["type"],
    name: json ["name"],
    image: json ["image"],
    last_seen: json["last_seen"],

  );

  Map<String, dynamic> toJson() => {
    "cd_id": cd_id,
    "type": type,
    "name": name,
    "image": image,
    "last_seen": last_seen,

  };
}