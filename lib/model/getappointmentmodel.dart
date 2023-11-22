
import 'dart:convert';

List<GetAppointmentModel> getAppointmentModelFromJson(String str) =>
    List<GetAppointmentModel>.from(
        json.decode(str).map((x) => GetAppointmentModel.fromJson(x)));

String getAppointmentModelToJson(List<GetAppointmentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAppointmentModel {
  final String studentId;
  final String studentName;
  final String email;
  final String mobile;
  final String mode;
  final String intake;
  final String country;
  final String course;
  final String stage;
  final String appointmentDate;
  final String appointmentBy;
  final String branch;
  final String counsellor;
  final dynamic requestStatus;
  final String appointmentId;
  final String reConfirmStatus;
  final String firstName;
  final String lastName;
  final String confirmDate;
  final String universityVisit;
  final String description;
  final String appointmentTime;

  GetAppointmentModel({
    required this.studentId,
    required this.studentName,
    required this.email,
    required this.mobile,
    required this.mode,
    required this.intake,
    required this.country,
    required this.course,
    required this.stage,
    required this.appointmentDate,
    required this.appointmentBy,
    required this.branch,
    required this.counsellor,
    required this.requestStatus,
    required this.appointmentId,
    required this.reConfirmStatus,
    required this.firstName,
    required this.lastName,
    required this.confirmDate,
    required this.universityVisit,
    required this.description,
    required this.appointmentTime,
  });

  factory GetAppointmentModel.fromJson(Map<String, dynamic> json) =>
      GetAppointmentModel(
        studentId: json["StudentId"],
        studentName: json["StudentName"],
        email: json["Email"],
        mobile: json["Mobile"],
        mode: json["Mode"],
        intake: json["Intake"],
        country: json["Country"],
        course: json["Course"],
        stage: json["Stage"],
        appointmentDate: json["AppointmentDate"],
        appointmentBy: json["AppointmentBy"],
        branch: json["Branch"],
        counsellor: json["Counsellor"],
        requestStatus: json["RequestStatus"],
        appointmentId: json["AppointmentId"],
        reConfirmStatus: json["ReConfirmStatus"],
        firstName: json["FirstName"],
        lastName: json["LastName"],
        confirmDate: json["ConfirmDate"],
        universityVisit: json["UniversityVisit"],
        description: json["Description"],
        appointmentTime: json["AppointmentTime"],
      );

  Map<String, dynamic> toJson() => {
        "StudentId": studentId,
        "StudentName": studentName,
        "Email": email,
        "Mobile": mobile,
        "Mode": mode,
        "Intake": intake,
        "Country": country,
        "Course": course,
        "Stage": stage,
        "AppointmentDate": appointmentDate,
        "AppointmentBy": appointmentBy,
        "Branch": branch,
        "Counsellor": counsellor,
        "RequestStatus": requestStatus,
        "AppointmentId": appointmentId,
        "ReConfirmStatus": reConfirmStatus,
        "FirstName": firstName,
        "LastName": lastName,
        "ConfirmDate": confirmDate,
        "UniversityVisit": universityVisit,
        "Description": description,
        "AppointmentTime": appointmentTime,
      };
}
