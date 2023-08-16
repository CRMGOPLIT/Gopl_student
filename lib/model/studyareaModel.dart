import 'dart:convert';

List<StudyAreaSearchModel> studyAreaSearchModelFromJson(String str) =>
    List<StudyAreaSearchModel>.from(
        json.decode(str).map((x) => StudyAreaSearchModel.fromJson(x)));

String studyAreaSearchModelToJson(List<StudyAreaSearchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudyAreaSearchModel {
  StudyAreaSearchModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory StudyAreaSearchModel.fromJson(Map<String, dynamic> json) =>
      StudyAreaSearchModel(
        id: json["Id"],
        name: json["Name"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
      };
}
