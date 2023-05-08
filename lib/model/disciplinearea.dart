import 'dart:convert';

List<DiscplineareaSearchModel> discplineareaSearchModelFromJson(String str) =>
    List<DiscplineareaSearchModel>.from(
        json.decode(str).map((x) => DiscplineareaSearchModel.fromJson(x)));

String discplineareaSearchModelToJson(List<DiscplineareaSearchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DiscplineareaSearchModel {
  final String id;
  final String name;

  DiscplineareaSearchModel({
    required this.id,
    required this.name,
  });

  factory DiscplineareaSearchModel.fromJson(Map<String, dynamic> json) =>
      DiscplineareaSearchModel(
        id: json["Id"].toString(),
        name: json["Name"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
      };
}
