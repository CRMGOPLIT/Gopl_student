import 'dart:convert';

List<UploadmoreDocument> uploadmoreDocumentFromJson(String str) =>
    List<UploadmoreDocument>.from(
        json.decode(str).map((x) => UploadmoreDocument.fromJson(x)));

String uploadmoreDocumentToJson(List<UploadmoreDocument> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UploadmoreDocument {
  final String fStudentId;
  final String fApplicationId;
  final String fIntake;
  final String universityApplied;
  final int fUniversityId;
  final String fApplicationStage;
  final String courseName;
  final String currentAppStage;
  final String currentPosition;
  final List<StudentMorDocument> studentMorDocument;
  final String fApplicationUpdatedStage;
  final dynamic fDocumentName;

  UploadmoreDocument({
    required this.fStudentId,
    required this.fApplicationId,
    required this.fIntake,
    required this.universityApplied,
    required this.fUniversityId,
    required this.fApplicationStage,
    required this.courseName,
    required this.currentAppStage,
    required this.currentPosition,
    required this.studentMorDocument,
    required this.fApplicationUpdatedStage,
    required this.fDocumentName,
  });

  factory UploadmoreDocument.fromJson(Map<String, dynamic> json) =>
      UploadmoreDocument(
        fStudentId: json["f_student_id"].toString(),
        fApplicationId: json["f_application_id"].toString(),
        fIntake: json["f_intake"].toString(),
        universityApplied: json["university_applied"].toString(),
        fUniversityId: json["f_university_id"],
        fApplicationStage: json["f_application_stage"].toString(),
        courseName: json["CourseName"].toString(),
        currentAppStage: json["CurrentAppStage"].toString(),
        currentPosition: json["CurrentPosition"].toString(),
        studentMorDocument: List<StudentMorDocument>.from(
            json["StudentMorDocument"]
                .map((x) => StudentMorDocument.fromJson(x))),
        fApplicationUpdatedStage: json["f_ApplicationUpdatedStage"].toString(),
        fDocumentName: json["f_document_name"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "f_student_id": fStudentId,
        "f_application_id": fApplicationId,
        "f_intake": fIntake,
        "university_applied": universityApplied,
        "f_university_id": fUniversityId,
        "f_application_stage": fApplicationStage,
        "CourseName": courseName,
        "CurrentAppStage": currentAppStage,
        "CurrentPosition": currentPosition,
        "StudentMorDocument":
            List<dynamic>.from(studentMorDocument.map((x) => x.toJson())),
        "f_ApplicationUpdatedStage": fApplicationUpdatedStage,
        "f_document_name": fDocumentName,
      };
}

class StudentMorDocument {
  final String fDocumentName;
  final String fDocument;
  final String fMoreDocRemark;
  final String fDocumentStatus;

  StudentMorDocument({
    required this.fDocumentName,
    required this.fDocument,
    required this.fMoreDocRemark,
    required this.fDocumentStatus,
  });

  factory StudentMorDocument.fromJson(Map<String, dynamic> json) =>
      StudentMorDocument(
        fDocumentName: json["f_document_name"],
        fDocument: json["f_document"],
        fMoreDocRemark: json["f_MoreDoc_Remark"],
        fDocumentStatus: json["f_document_status"],
      );

  Map<String, dynamic> toJson() => {
        "f_document_name": fDocumentName,
        "f_document": fDocument,
        "f_MoreDoc_Remark": fMoreDocRemark,
        "f_document_status": fDocumentStatus,
      };
}
