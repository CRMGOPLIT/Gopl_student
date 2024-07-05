// To parse this JSON data, do
//
//     final consellorModel = consellorModelFromJson(jsonString);

import 'dart:convert';

ConsellorModel consellorModelFromJson(String str) =>
    ConsellorModel.fromJson(json.decode(str));

String consellorModelToJson(ConsellorModel data) => json.encode(data.toJson());

class ConsellorModel {
  final bool? seccess;
  final String? msg;
  final List<Consellordatum>? consellordata;

  ConsellorModel({
    this.seccess,
    this.msg,
    this.consellordata,
  });

  ConsellorModel copyWith({
    bool? seccess,
    String? msg,
    List<Consellordatum>? consellordata,
  }) =>
      ConsellorModel(
        seccess: seccess ?? this.seccess,
        msg: msg ?? this.msg,
        consellordata: consellordata ?? this.consellordata,
      );

  factory ConsellorModel.fromJson(Map<String, dynamic> json) => ConsellorModel(
        seccess: json["seccess"],
        msg: json["msg"],
        consellordata: json["consellordata"] == null
            ? []
            : List<Consellordatum>.from(
                json["consellordata"]!.map((x) => Consellordatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "seccess": seccess,
        "msg": msg,
        "consellordata": consellordata == null
            ? []
            : List<dynamic>.from(consellordata!.map((x) => x.toJson())),
      };
}

class Consellordatum {
  final String? userid;
  final String? name;
  final String? email;
  final String? mobile;

  Consellordatum({
    this.userid,
    this.name,
    this.email,
    this.mobile,
  });

  Consellordatum copyWith({
    String? userid,
    String? name,
    String? email,
    String? mobile,
  }) =>
      Consellordatum(
        userid: userid ?? this.userid,
        name: name ?? this.name,
        email: email ?? this.email,
        mobile: mobile ?? this.mobile,
      );

  factory Consellordatum.fromJson(Map<String, dynamic> json) => Consellordatum(
        userid: json["userid"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "name": name,
        "email": email,
        "mobile": mobile,
      };
}
