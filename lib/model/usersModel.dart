import 'dart:convert';

List<UsersDetailsModel> usersDetailsModelFromJson(String str) =>
    List<UsersDetailsModel>.from(
        json.decode(str).map((x) => UsersDetailsModel.fromJson(x)));

String usersDetailsModelToJson(List<UsersDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsersDetailsModel {
  final String rmName;
  final String fRmMobile;
  final String fRmEmail;
  final String omName;
  final String fOmMobile;
  final String fOmEmail;
  final String counsellorName;
  final String fStudentEmail;
  final String fBranceName;
  final String fCounsellorMobile;
  final String fCounsellorEmail;
  final String fMobile;
  final String fStudentId;
  final String fFirstName;

  UsersDetailsModel({
    required this.rmName,
    required this.fRmMobile,
    required this.fRmEmail,
    required this.omName,
    required this.fOmMobile,
    required this.fOmEmail,
    required this.counsellorName,
    required this.fStudentEmail,
    required this.fBranceName,
    required this.fCounsellorMobile,
    required this.fCounsellorEmail,
    required this.fMobile,
    required this.fStudentId,
    required this.fFirstName,
  });

  factory UsersDetailsModel.fromJson(Map<String, dynamic> json) =>
      UsersDetailsModel(
        rmName: json["RM_Name"].toString(),
        fRmMobile: json["f_RM_mobile"].toString(),
        fRmEmail: json["f_RM_Email"].toString(),
        omName: json["OM_Name"].toString(),
        fOmMobile: json["f_OM_mobile"].toString(),
        fOmEmail: json["f_OM_Email"].toString(),
        counsellorName: json["counsellor_Name"].toString(),
        fStudentEmail: json["f_student_Email"].toString(),
        fBranceName: json["f_brance_name"].toString(),
        fCounsellorMobile: json["f_counsellor_mobile"].toString(),
        fCounsellorEmail: json["f_counsellor_Email"].toString(),
        fMobile: json["f_mobile"].toString(),
        fStudentId: json["f_student_id"].toString(),
        fFirstName: json["f_First_name"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "RM_Name": rmName,
        "f_RM_mobile": fRmMobile,
        "f_RM_Email": fRmEmail,
        "OM_Name": omName,
        "f_OM_mobile": fOmMobile,
        "f_OM_Email": fOmEmail,
        "counsellor_Name": counsellorName,
        "f_student_Email": fStudentEmail,
        "f_brance_name": fBranceName,
        "f_counsellor_mobile": fCounsellorMobile,
        "f_counsellor_Email": fCounsellorEmail,
        "f_mobile": fMobile,
        "f_student_id": fStudentId,
        "f_First_name": fFirstName,
      };
}
