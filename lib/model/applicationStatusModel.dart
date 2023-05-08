import 'dart:convert';

List<ApplicationStatusModel> applicationStatusModelFromJson(String str) =>
    List<ApplicationStatusModel>.from(
        json.decode(str).map((x) => ApplicationStatusModel.fromJson(x)));

String applicationStatusModelToJson(List<ApplicationStatusModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApplicationStatusModel {
  ApplicationStatusModel({
    required this.fCourcesAppliedId,
    required this.country,
    required this.fIntake,
    required this.fCourcesApplied,
    required this.university,
    required this.fApplicationStage,
    required this.fPreference,
    required this.fCreationdate,
    required this.fCourseStandard,
    required this.fMobile,
    required this.token,
  });

  final int fCourcesAppliedId;
  final String country;
  final String fIntake;
  final String fCourcesApplied;
  final String university;
  final String fApplicationStage;
  final String fPreference;
  final String fCreationdate;
  final String fCourseStandard;
  final String fMobile;
  final String token;

  factory ApplicationStatusModel.fromJson(Map<String, dynamic> json) =>
      ApplicationStatusModel(
        fCourcesAppliedId: json["f_cources_applied_id"],
        country: json["country"],
        fIntake: json["f_intake"],
        fCourcesApplied: json["f_cources_applied"],
        university: json["university"],
        fApplicationStage: json["f_application_stage"],
        fPreference: json["f_Preference"],
        fCreationdate: json["f_creationdate"],
        fCourseStandard: json["f_course_standard"],
        fMobile: json["f_mobile"].toString(),
        token: json["Token"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "f_cources_applied_id": fCourcesAppliedId,
        "country": country,
        "f_intake": fIntake,
        "f_cources_applied": fCourcesApplied,
        "university": university,
        "f_application_stage": fApplicationStage,
        "f_Preference": fPreference,
        "f_creationdate": fCreationdate,
        "f_course_standard": fCourseStandard,
        "f_mobile": fMobile,
        "Token": token,
      };
}
