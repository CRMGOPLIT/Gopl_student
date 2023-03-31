import 'dart:convert';

List<QualificationModel> qualificationModelFromJson(String str) =>
    List<QualificationModel>.from(
        json.decode(str).map((x) => QualificationModel.fromJson(x)));

String qualificationModelToJson(List<QualificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QualificationModel {
  QualificationModel({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory QualificationModel.fromJson(Map<String, dynamic> json) =>
      QualificationModel(
        id: json["Id"].toString(),
        name: json["Name"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
      };
}
