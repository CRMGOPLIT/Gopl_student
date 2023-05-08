import 'dart:convert';

List<LocationSearchModel> locationSearchModelFromJson(String str) =>
    List<LocationSearchModel>.from(
        json.decode(str).map((x) => LocationSearchModel.fromJson(x)));

String locationSearchModelToJson(List<LocationSearchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LocationSearchModel {
  LocationSearchModel({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory LocationSearchModel.fromJson(Map<String, dynamic> json) =>
      LocationSearchModel(
        id: json["Id"].toString(),
        name: json["Name"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
      };
}
