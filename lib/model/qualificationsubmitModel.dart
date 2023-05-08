import 'dart:convert';

List<QualificationSubmitModel> qualificationSubmitModelFromJson(String str) =>
    List<QualificationSubmitModel>.from(
        json.decode(str).map((x) => QualificationSubmitModel.fromJson(x)));

String qualificationSubmitModelToJson(List<QualificationSubmitModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QualificationSubmitModel {
  QualificationSubmitModel({
    required this.studentId,
    required this.fQualification,
    required this.fStream,
    required this.fUniversityBoard,
    required this.fCoursesStudied,
    required this.fAvgGrade,
    required this.fStartingYear,
    required this.startingMonth,
    required this.fPassingYear,
    required this.passingMonth,
    required this.fRegularDistance,
    required this.fDocumentType,
    required this.fMobile,
    required this.token,
  });

  final int studentId;
  final String fQualification;
  final String fStream;
  final String fUniversityBoard;
  final String fCoursesStudied;
  final String fAvgGrade;
  final int fStartingYear;
  final String startingMonth;
  final int fPassingYear;
  final String passingMonth;
  final String fRegularDistance;
  final String fDocumentType;
  final String fMobile;
  final String token;

  factory QualificationSubmitModel.fromJson(Map<String, dynamic> json) =>
      QualificationSubmitModel(
        studentId: json["StudentID"],
        fQualification: json["f_qualification"].toString(),
        fStream: json["f_Stream"].toString(),
        fUniversityBoard: json["f_university_board"].toString(),
        fCoursesStudied: json["f_courses_studied"].toString(),
        fAvgGrade: json["f_avg_grade"].toString(),
        fStartingYear: json["f_starting_year"],
        startingMonth: json["starting_month"].toString(),
        fPassingYear: json["f_passing_year"],
        passingMonth: json["passing_month"].toString(),
        fRegularDistance: json["f_Regular_Distance"].toString(),
        fDocumentType: json["f_DocumentType"].toString(),
        fMobile: json["f_mobile"].toString(),
        token: json["Token"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "StudentID": studentId,
        "f_qualification": fQualification,
        "f_Stream": fStream,
        "f_university_board": fUniversityBoard,
        "f_courses_studied": fCoursesStudied,
        "f_avg_grade": fAvgGrade,
        "f_starting_year": fStartingYear,
        "starting_month": startingMonth,
        "f_passing_year": fPassingYear,
        "passing_month": passingMonth,
        "f_Regular_Distance": fRegularDistance,
        "f_DocumentType": fDocumentType,
        "f_mobile": fMobile,
        "Token": token,
      };
}
