// To parse this JSON data, do
//
//     final boardUniversityModel = boardUniversityModelFromJson(jsonString);

import 'dart:convert';

List<BoardUniversityModel> boardUniversityModelFromJson(String str) =>
    List<BoardUniversityModel>.from(
        json.decode(str).map((x) => BoardUniversityModel.fromJson(x)));

String boardUniversityModelToJson(List<BoardUniversityModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BoardUniversityModel {
  BoardUniversityModel({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory BoardUniversityModel.fromJson(Map<String, dynamic> json) =>
      BoardUniversityModel(
        id: json["Id"],
        name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
      };
}
