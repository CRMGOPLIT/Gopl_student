import 'dart:convert';

Gofairdetails gofairdetailsFromJson(String str) =>
    Gofairdetails.fromJson(json.decode(str));

String gofairdetailsToJson(Gofairdetails data) => json.encode(data.toJson());

class Gofairdetails {
  final String firstName;
  final String lastName;
  final String countryName;
  final String mobile;
  final String email;
  final String intake;
  final String fBranchName;
  final String counselorname;
  final String fVisitedYesNo;
  final String fAppointmentStatus;
  final String isTodayFair;
  final String stuCat;
  final String fUniversityId;
  final String token;

  Gofairdetails({
    required this.firstName,
    required this.lastName,
    required this.countryName,
    required this.mobile,
    required this.email,
    required this.intake,
    required this.fBranchName,
    required this.counselorname,
    required this.fVisitedYesNo,
    required this.fAppointmentStatus,
    required this.isTodayFair,
    required this.stuCat,
    required this.fUniversityId,
    required this.token,
  });

  factory Gofairdetails.fromJson(Map<String, dynamic> json) => Gofairdetails(
        firstName: json["FirstName"].toString(),
        lastName: json["LastName"].toString(),
        countryName: json["CountryName"].toString(),
        mobile: json["Mobile"].toString(),
        email: json["Email"].toString(),
        intake: json["Intake"].toString(),
        fBranchName: json["f_BranchName"].toString(),
        counselorname: json["counselorname"].toString(),
        fVisitedYesNo: json["f_Visited_yes_no"].toString(),
        fAppointmentStatus: json["f_appointment_status"].toString(),
        isTodayFair: json["IsTodayFair"].toString(),
        stuCat: json["StuCat"].toString(),
        fUniversityId: json["f_University_id"].toString(),
        token: json["Token"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "FirstName": firstName,
        "LastName": lastName,
        "CountryName": countryName,
        "Mobile": mobile,
        "Email": email,
        "Intake": intake,
        "f_BranchName": fBranchName,
        "counselorname": counselorname,
        "f_Visited_yes_no": fVisitedYesNo,
        "f_appointment_status": fAppointmentStatus,
        "IsTodayFair": isTodayFair,
        "StuCat": stuCat,
        "f_University_id": fUniversityId,
        "Token": token,
      };
}
