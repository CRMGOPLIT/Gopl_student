import 'dart:convert';

List<CountrySearchModel> countrySearchModelFromJson(String str) =>
    List<CountrySearchModel>.from(
        json.decode(str).map((x) => CountrySearchModel.fromJson(x)));

String countrySearchModelToJson(List<CountrySearchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountrySearchModel {
  CountrySearchModel({
    required this.id,
    required this.name,
  });

  late final String id;
  final String name;

  factory CountrySearchModel.fromJson(Map<String, dynamic> json) =>
      CountrySearchModel(
        id: json["Id"],
        name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
      };
}
