
import 'dart:convert';

VisaGetModel visaGetModelFromJson(String str) =>
    VisaGetModel.fromJson(json.decode(str));
String visaGetModelToJson(VisaGetModel data) => json.encode(data.toJson());

class VisaGetModel {
  final List<AcademicDocument> allDocuments;
  final List<AcademicDocument> academicDocuments;
  final List<AcademicDocument> workExperience;
  final List<AcademicDocument> fundsDocuments;
  final List<AcademicDocument> financialDocuments;
  final List<AcademicDocument> sponsorDocuments;

  VisaGetModel({
    required this.allDocuments,
    required this.academicDocuments,
    required this.workExperience,
    required this.fundsDocuments,
    required this.financialDocuments,
    required this.sponsorDocuments,
  });

  factory VisaGetModel.fromJson(Map<String, dynamic> json) => VisaGetModel(
        allDocuments: List<AcademicDocument>.from(
            json["AllDocuments"].map((x) => AcademicDocument.fromJson(x))),
        academicDocuments: List<AcademicDocument>.from(
            json["AcademicDocuments"].map((x) => AcademicDocument.fromJson(x))),
        workExperience: List<AcademicDocument>.from(
            json["WorkExperience"].map((x) => AcademicDocument.fromJson(x))),
        fundsDocuments: List<AcademicDocument>.from(
            json["FundsDocuments"].map((x) => AcademicDocument.fromJson(x))),
        financialDocuments: List<AcademicDocument>.from(
            json["FinancialDocuments"]
                .map((x) => AcademicDocument.fromJson(x))),
        sponsorDocuments: List<AcademicDocument>.from(
            json["SponsorDocuments"].map((x) => AcademicDocument.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "AllDocuments": List<dynamic>.from(allDocuments.map((x) => x.toJson())),
        "AcademicDocuments":
            List<dynamic>.from(academicDocuments.map((x) => x.toJson())),
        "WorkExperience":
            List<dynamic>.from(workExperience.map((x) => x.toJson())),
        "FundsDocuments":
            List<dynamic>.from(fundsDocuments.map((x) => x.toJson())),
        "FinancialDocuments":
            List<dynamic>.from(financialDocuments.map((x) => x.toJson())),
        "SponsorDocuments":
            List<dynamic>.from(sponsorDocuments.map((x) => x.toJson())),
      };
}

class AcademicDocument {
  final int fVisaFileDocumentId;
  final String fVisaFileRequiredDocumentId;
  final int fCountryid;
  final String fDocumentName;
  final bool fIsRequired;
  final bool fStatus;
  final DateTime fCreationDate;
  final String fDocumentType;
  final String fCourcesAppliedId;
  final String fStudentId;
  final String fRemarks;
  final String fFileType;
  final String fVisaFileRequiredDocumentIDs;
  final String fVisaRejectReasonId;
  final String fDocumentStatus;
  final String fFollowUpDate;
  final String userid;
  final String access;

  AcademicDocument({
    required this.fVisaFileDocumentId,
    required this.fVisaFileRequiredDocumentId,
    required this.fCountryid,
    required this.fDocumentName,
    required this.fIsRequired,
    required this.fStatus,
    required this.fCreationDate,
    required this.fDocumentType,
    required this.fCourcesAppliedId,
    required this.fStudentId,
    required this.fRemarks,
    required this.fFileType,
    required this.fVisaFileRequiredDocumentIDs,
    required this.fVisaRejectReasonId,
    required this.fDocumentStatus,
    required this.fFollowUpDate,
    required this.userid,
    required this.access,
  });

  factory AcademicDocument.fromJson(Map<String, dynamic> json) =>
      AcademicDocument(
        fVisaFileDocumentId: json["f_VisaFileDocumentID"],
        fVisaFileRequiredDocumentId: json["f_VisaFileRequiredDocumentID"].toString(),
        fCountryid: json["f_countryid"],
        fDocumentName: json["f_DocumentName"].toString(),
        fIsRequired: json["f_IsRequired"],
        fStatus: json["f_status"],
        fCreationDate: DateTime.parse(json["f_CreationDate"]),
        fDocumentType: json["f_DocumentType"].toString(),
        fCourcesAppliedId: json["f_cources_applied_id"].toString(),
        fStudentId: json["f_Student_id"].toString(),
        fRemarks: json["f_Remarks"].toString(),
        fFileType: json["f_FileType"].toString(),
        fVisaFileRequiredDocumentIDs:
            json["f_VisaFileRequiredDocumentIDs"].toString(),
        fVisaRejectReasonId: json["f_VisaRejectReasonID"].toString(),
        fDocumentStatus: json["f_DocumentStatus"].toString(),
        fFollowUpDate: json["f_FollowUpDate"].toString(),
        userid: json["userid"].toString(),
        access: json["Access"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "f_VisaFileDocumentID": fVisaFileDocumentId,
        "f_VisaFileRequiredDocumentID": fVisaFileRequiredDocumentId,
        "f_countryid": fCountryid,
        "f_DocumentName": fDocumentName,
        "f_IsRequired": fIsRequired,
        "f_status": fStatus,
        "f_CreationDate": fCreationDate.toIso8601String(),
        "f_DocumentType": fDocumentType,
        "f_cources_applied_id": fCourcesAppliedId,
        "f_Student_id": fStudentId,
        "f_Remarks": fRemarks,
        "f_FileType": fFileType,
        "f_VisaFileRequiredDocumentIDs": fVisaFileRequiredDocumentIDs,
        "f_VisaRejectReasonID": fVisaRejectReasonId,
        "f_DocumentStatus": fDocumentStatus,
        "f_FollowUpDate": fFollowUpDate,
        "userid": userid,
        "Access": access,
      };
}
