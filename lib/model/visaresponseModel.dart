import 'dart:convert';

VisaresponseModel visaresponseModelFromJson(String str) =>
    VisaresponseModel.fromJson(json.decode(str));

String visaresponseModelToJson(VisaresponseModel data) =>
    json.encode(data.toJson());

class VisaresponseModel {
  final List<String> requiredDocuments;
  final String status;

  VisaresponseModel({
    required this.requiredDocuments,
    required this.status,
  });

  factory VisaresponseModel.fromJson(Map<String, dynamic> json) =>
      VisaresponseModel(
        requiredDocuments:
            List<String>.from(json["RequiredDocuments"].map((x) => x)),
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "RequiredDocuments":
            List<dynamic>.from(requiredDocuments.map((x) => x)),
        "Status": status,
      };
}
