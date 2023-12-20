import 'dart:convert';

List<GetPendingAppointment> getPendingAppointmentFromJson(String str) =>
    List<GetPendingAppointment>.from(
        json.decode(str).map((x) => GetPendingAppointment.fromJson(x)));

String getPendingAppointmentToJson(List<GetPendingAppointment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetPendingAppointment {
  final String? studentId;
  final String? studentName;
  final String? email;
  final String? mobile;
  final String? mode;
  final String? intake;
  final String? country;
  final String? course;
  final String? stage;
  final String? appointmentDate;
  final String? appointmentBy;
  final String? branch;
  final String? counsellor;
  final dynamic requestStatus;
  final String? appointmentId;
  final String? reConfirmStatus;
  final String? firstName;
  final String? lastName;
  final String? confirmDate;
  final String? universityVisit;
  final String? description;
  final String? appointmentTime;
  final String? statusData;

  GetPendingAppointment({
    this.studentId,
    this.studentName,
    this.email,
    this.mobile,
    this.mode,
    this.intake,
    this.country,
    this.course,
    this.stage,
    this.appointmentDate,
    this.appointmentBy,
    this.branch,
    this.counsellor,
    this.requestStatus,
    this.appointmentId,
    this.reConfirmStatus,
    this.firstName,
    this.lastName,
    this.confirmDate,
    this.universityVisit,
    this.description,
    this.appointmentTime,
    this.statusData,
  });

  GetPendingAppointment copyWith({
    String? studentId,
    String? studentName,
    String? email,
    String? mobile,
    String? mode,
    String? intake,
    String? country,
    String? course,
    String? stage,
    String? appointmentDate,
    String? appointmentBy,
    String? branch,
    String? counsellor,
    dynamic requestStatus,
    String? appointmentId,
    String? reConfirmStatus,
    String? firstName,
    String? lastName,
    String? confirmDate,
    String? universityVisit,
    String? description,
    String? appointmentTime,
    String? statusData,
  }) =>
      GetPendingAppointment(
        studentId: studentId ?? this.studentId,
        studentName: studentName ?? this.studentName,
        email: email ?? this.email,
        mobile: mobile ?? this.mobile,
        mode: mode ?? this.mode,
        intake: intake ?? this.intake,
        country: country ?? this.country,
        course: course ?? this.course,
        stage: stage ?? this.stage,
        appointmentDate: appointmentDate ?? this.appointmentDate,
        appointmentBy: appointmentBy ?? this.appointmentBy,
        branch: branch ?? this.branch,
        counsellor: counsellor ?? this.counsellor,
        requestStatus: requestStatus ?? this.requestStatus,
        appointmentId: appointmentId ?? this.appointmentId,
        reConfirmStatus: reConfirmStatus ?? this.reConfirmStatus,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        confirmDate: confirmDate ?? this.confirmDate,
        universityVisit: universityVisit ?? this.universityVisit,
        description: description ?? this.description,
        appointmentTime: appointmentTime ?? this.appointmentTime,
        statusData: statusData ?? this.statusData,
      );

  factory GetPendingAppointment.fromJson(Map<String, dynamic> json) =>
      GetPendingAppointment(
        studentId: json["StudentId"].toString(),
        studentName: json["StudentName"].toString(),
        email: json["Email"].toString(),
        mobile: json["Mobile"].toString(),
        mode: json["Mode"].toString(),
        intake: json["Intake"].toString(),
        country: json["Country"].toString(),
        course: json["Course"].toString(),
        stage: json["Stage"].toString(),
        appointmentDate: json["AppointmentDate"].toString(),
        appointmentBy: json["AppointmentBy"].toString(),
        branch: json["Branch"].toString(),
        counsellor: json["Counsellor"].toString(),
        requestStatus: json["RequestStatus"].toString(),
        appointmentId: json["AppointmentId"].toString(),
        reConfirmStatus: json["ReConfirmStatus"].toString(),
        firstName: json["FirstName"].toString(),
        lastName: json["LastName"].toString(),
        confirmDate: json["ConfirmDate"].toString(),
        universityVisit: json["UniversityVisit"].toString(),
        description: json["Description"].toString(),
        appointmentTime: json["AppointmentTime"].toString(),
        statusData: json["StatusData"].toString(),
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
        "StatusData": statusData,
      };
}
