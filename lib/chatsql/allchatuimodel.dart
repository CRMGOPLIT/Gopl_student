import 'dart:convert';

AllChat allChatFromJson(String str) => AllChat.fromJson(json.decode(str));

String allChatToJson(AllChat data) => json.encode(data.toJson());

class AllChat {
  bool? success;
  String? message;
  List<Allchat>? allchat;

  AllChat({
    this.success,
    this.message,
    this.allchat,
  });

  AllChat copyWith({
    bool? success,
    String? message,
    List<Allchat>? allchat,
  }) =>
      AllChat(
        success: success ?? this.success,
        message: message ?? this.message,
        allchat: allchat ?? this.allchat,
      );

  factory AllChat.fromJson(Map<String, dynamic> json) => AllChat(
        success: json["success"],
        message: json["message"],
        allchat: json["allchat"] == null
            ? []
            : List<Allchat>.from(
                json["allchat"]!.map((x) => Allchat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "allchat": allchat == null
            ? []
            : List<dynamic>.from(allchat!.map((x) => x.toJson())),
      };
}

class Allchat {
  String? senderId;
  String? receiverId;
  String? message;
  String? timestamp;
  String? date;

  Allchat({
    this.senderId,
    this.receiverId,
    this.message,
    this.timestamp,
    this.date,
  });

  Allchat copyWith({
    String? senderId,
    String? receiverId,
    String? message,
    String? timestamp,
    String? fCreationdate,
  }) =>
      Allchat(
        senderId: senderId ?? this.senderId,
        receiverId: receiverId ?? this.receiverId,
        message: message ?? this.message,
        timestamp: timestamp ?? this.timestamp,
        date: fCreationdate ?? this.date,
      );

  factory Allchat.fromJson(Map<String, dynamic> json) => Allchat(
        senderId: json["sender_id"].toString(),
        receiverId: json["receiver_id"].toString(),
        message: json["message"].toString(),
        timestamp: json["timestamp"].toString(),
        date: json["date"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "sender_id": senderId,
        "receiver_id": receiverId,
        "message": message,
        "timestamp": timestamp,
        "date": date,
      };
}
