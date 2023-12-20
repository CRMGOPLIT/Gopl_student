import 'dart:convert';

Versioncontrol versioncontrolFromJson(String str) =>
    Versioncontrol.fromJson(json.decode(str));

String versioncontrolToJson(Versioncontrol data) => json.encode(data.toJson());

class Versioncontrol {
  final String? version;

  Versioncontrol({
    this.version,
  });

  Versioncontrol copyWith({
    String? version,
  }) =>
      Versioncontrol(
        version: version ?? this.version,
      );

  factory Versioncontrol.fromJson(Map<String, dynamic> json) => Versioncontrol(
        version: json["Version"],
      );

  Map<String, dynamic> toJson() => {
        "Version": version,
      };
}
