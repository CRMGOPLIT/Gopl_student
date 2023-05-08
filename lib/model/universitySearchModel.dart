// To parse this JSON data, do
//
//     final universitySearchModel = universitySearchModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<UniversitySearchModel> universitySearchModelFromJson(String str) =>
    List<UniversitySearchModel>.from(
        json.decode(str).map((x) => UniversitySearchModel.fromJson(x)));

String universitySearchModelToJson(List<UniversitySearchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UniversitySearchModel {
  UniversitySearchModel({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory UniversitySearchModel.fromJson(Map<String, dynamic> json) =>
      UniversitySearchModel(
        id: json["Id"],
        name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
      };
}