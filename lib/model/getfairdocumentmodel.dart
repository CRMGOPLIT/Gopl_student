import 'dart:convert';

List<Getfairdocumentlist> getfairdocumentlistFromJson(String str) =>
    List<Getfairdocumentlist>.from(
        json.decode(str).map((x) => Getfairdocumentlist.fromJson(x)));

String getfairdocumentlistToJson(List<Getfairdocumentlist> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getfairdocumentlist {
  final int id;
  final String fStudentId;
  final dynamic fBranchId;
  final dynamic fCounsellorId;
  final String fDocumentName;
  final String fDocument;
  final String fDocumentStatus;
  final dynamic fEntryDate;
  final dynamic fIsTransferredToMain;
  final dynamic fDescription;
  final dynamic fOperationDate;
  final dynamic mainId;
  final String fDocumentType;

  Getfairdocumentlist({
    required this.id,
    required this.fStudentId,
    required this.fBranchId,
    required this.fCounsellorId,
    required this.fDocumentName,
    required this.fDocument,
    required this.fDocumentStatus,
    required this.fEntryDate,
    required this.fIsTransferredToMain,
    required this.fDescription,
    required this.fOperationDate,
    required this.mainId,
    required this.fDocumentType,
  });

  Getfairdocumentlist copyWith({
    int? id,
    String? fStudentId,
    dynamic fBranchId,
    dynamic fCounsellorId,
    String? fDocumentName,
    String? fDocument,
    String? fDocumentStatus,
    dynamic fEntryDate,
    dynamic fIsTransferredToMain,
    dynamic fDescription,
    dynamic fOperationDate,
    dynamic mainId,
    String? fDocumentType,
  }) =>
      Getfairdocumentlist(
        id: id ?? this.id,
        fStudentId: fStudentId ?? this.fStudentId,
        fBranchId: fBranchId ?? this.fBranchId,
        fCounsellorId: fCounsellorId ?? this.fCounsellorId,
        fDocumentName: fDocumentName ?? this.fDocumentName,
        fDocument: fDocument ?? this.fDocument,
        fDocumentStatus: fDocumentStatus ?? this.fDocumentStatus,
        fEntryDate: fEntryDate ?? this.fEntryDate,
        fIsTransferredToMain: fIsTransferredToMain ?? this.fIsTransferredToMain,
        fDescription: fDescription ?? this.fDescription,
        fOperationDate: fOperationDate ?? this.fOperationDate,
        mainId: mainId ?? this.mainId,
        fDocumentType: fDocumentType ?? this.fDocumentType,
      );

  factory Getfairdocumentlist.fromJson(Map<String, dynamic> json) =>
      Getfairdocumentlist(
        id: json["Id"],
        fStudentId: json["f_Student_id"].toString(),
        fBranchId: json["f_Branch_id"].toString(),
        fCounsellorId: json["f_Counsellor_Id"].toString(),
        fDocumentName: json["f_DocumentName"].toString(),
        fDocument: json["f_Document"].toString(),
        fDocumentStatus: json["f_DocumentStatus"].toString(),
        fEntryDate: json["f_EntryDate"].toString(),
        fIsTransferredToMain: json["f_IsTransferredToMain"].toString(),
        fDescription: json["f_Description"].toString(),
        fOperationDate: json["f_OperationDate"].toString(),
        mainId: json["Main_id"].toString(),
        fDocumentType: json["f_DocumentType"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "f_Student_id": fStudentId,
        "f_Branch_id": fBranchId,
        "f_Counsellor_Id": fCounsellorId,
        "f_DocumentName": fDocumentName,
        "f_Document": fDocument,
        "f_DocumentStatus": fDocumentStatus,
        "f_EntryDate": fEntryDate,
        "f_IsTransferredToMain": fIsTransferredToMain,
        "f_Description": fDescription,
        "f_OperationDate": fOperationDate,
        "Main_id": mainId,
        "f_DocumentType": fDocumentType,
      };
}
