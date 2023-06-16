import 'dart:convert';

Bannermodel bannermodelFromJson(String str) =>
    Bannermodel.fromJson(json.decode(str));

String bannermodelToJson(Bannermodel data) => json.encode(data.toJson());

class Bannermodel {
  final String isVisaApplicable;
  final List<String> images;
  final String countryId;
  final String studentId;
  final String courseId;
  final String countryName;

  Bannermodel({
    required this.isVisaApplicable,
    required this.images,
    required this.countryId,
    required this.studentId,
    required this.courseId,
    required this.countryName,
  });

  factory Bannermodel.fromJson(Map<String, dynamic> json) => Bannermodel(
        isVisaApplicable: json["IsVisaApplicable"],
        images: List<String>.from(json["Images"].map((x) => x)),
        countryId: json["CountryId"],
        studentId: json["StudentId"],
        courseId: json["CourseId"],
        countryName: json["CountryName"],
      );

  Map<String, dynamic> toJson() => {
        "IsVisaApplicable": isVisaApplicable,
        "Images": List<dynamic>.from(images.map((x) => x)),
        "CountryId": countryId,
        "StudentId": studentId,
        "CourseId": courseId,
        "CountryName": countryName,
      };
}
