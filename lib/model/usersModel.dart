import 'dart:convert';

List<UsersDetailsModel> usersDetailsModelFromJson(String str) =>
    List<UsersDetailsModel>.from(
        json.decode(str).map((x) => UsersDetailsModel.fromJson(x)));

String usersDetailsModelToJson(List<UsersDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsersDetailsModel {
  UsersDetailsModel({
    required this.counsellorName,
    required this.fStudentEmail,
    required this.fBranceName,
    required this.fCounsellorMobile,
    required this.fCounsellorEmail,
    required this.fMobile,
    required this.fStudentId,
    required this.fFirstName,
  });

  final String counsellorName;
  final String fStudentEmail;
  final String fBranceName;
  final String fCounsellorMobile;
  final String fCounsellorEmail;
  final String fMobile;
  final String fStudentId;
  final String fFirstName;

  factory UsersDetailsModel.fromJson(Map<String, dynamic> json) =>
      UsersDetailsModel(
        counsellorName: json["counsellor_Name"],
        fStudentEmail: json["f_student_Email"],
        fBranceName: json["f_brance_name"],
        fCounsellorMobile: json["f_counsellor_mobile"],
        fCounsellorEmail: json["f_counsellor_Email"],
        fMobile: json["f_mobile"],
        fStudentId: json["f_student_id"],
        fFirstName: json["f_First_name"],
      );

  Map<String, dynamic> toJson() => {
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
