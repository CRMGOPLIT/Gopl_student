import 'dart:convert';

List<GofairdropModel> gofairdropModelFromJson(String str) =>
    List<GofairdropModel>.from(
        json.decode(str).map((x) => GofairdropModel.fromJson(x)));

String gofairdropModelToJson(List<GofairdropModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GofairdropModel {
  late final String id;
  late final String name;
  late final String dateOfVisit;

  GofairdropModel({
    required this.id,
    required this.name,
    required this.dateOfVisit,
  });

  factory GofairdropModel.fromJson(Map<String, dynamic> json) =>
      GofairdropModel(
        id: json["Id"].toString(),
        name: json["Name"].toString(),
        dateOfVisit: json["date_of_visit"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "date_of_visit": dateOfVisit,
      };
}
