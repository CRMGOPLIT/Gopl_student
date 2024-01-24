
import 'dart:convert';

List<PerformaBatch> performaBatchFromJson(String str) =>
    List<PerformaBatch>.from(
        json.decode(str).map((x) => PerformaBatch.fromJson(x)));

String performaBatchToJson(List<PerformaBatch> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PerformaBatch {
  final String fInvoiceDate;
  final String fInvoiceId;
  final String fStudentId;
  final String fStudentName;
  final String fMobile;
  final String fEmail;
  final String fTotalAmt;
  final String fPaidAmt;
  final String fClosedAmt;
  final String fRefundedAmt;
  final dynamic fBalanceAmt;
  final String fService;
  final String fNextDueDate;
  final String fStage;
  final dynamic isGst;
  final String fTaxAmount;
  final dynamic counsellorName;
  final dynamic fLegalPapaerReciept;

  PerformaBatch({
    required this.fInvoiceDate,
    required this.fInvoiceId,
    required this.fStudentId,
    required this.fStudentName,
    required this.fMobile,
    required this.fEmail,
    required this.fTotalAmt,
    required this.fPaidAmt,
    required this.fClosedAmt,
    required this.fRefundedAmt,
    required this.fBalanceAmt,
    required this.fService,
    required this.fNextDueDate,
    required this.fStage,
    required this.isGst,
    required this.fTaxAmount,
    required this.counsellorName,
    required this.fLegalPapaerReciept,
  });

  PerformaBatch copyWith({
    String? fInvoiceDate,
    String? fInvoiceId,
    String? fStudentId,
    String? fStudentName,
    String? fMobile,
    String? fEmail,
    String? fTotalAmt,
    String? fPaidAmt,
    String? fClosedAmt,
    String? fRefundedAmt,
    dynamic fBalanceAmt,
    String? fService,
    String? fNextDueDate,
    String? fStage,
    dynamic isGst,
    String? fTaxAmount,
    dynamic counsellorName,
    dynamic fLegalPapaerReciept,
  }) =>
      PerformaBatch(
        fInvoiceDate: fInvoiceDate ?? this.fInvoiceDate,
        fInvoiceId: fInvoiceId ?? this.fInvoiceId,
        fStudentId: fStudentId ?? this.fStudentId,
        fStudentName: fStudentName ?? this.fStudentName,
        fMobile: fMobile ?? this.fMobile,
        fEmail: fEmail ?? this.fEmail,
        fTotalAmt: fTotalAmt ?? this.fTotalAmt,
        fPaidAmt: fPaidAmt ?? this.fPaidAmt,
        fClosedAmt: fClosedAmt ?? this.fClosedAmt,
        fRefundedAmt: fRefundedAmt ?? this.fRefundedAmt,
        fBalanceAmt: fBalanceAmt ?? this.fBalanceAmt,
        fService: fService ?? this.fService,
        fNextDueDate: fNextDueDate ?? this.fNextDueDate,
        fStage: fStage ?? this.fStage,
        isGst: isGst ?? this.isGst,
        fTaxAmount: fTaxAmount ?? this.fTaxAmount,
        counsellorName: counsellorName ?? this.counsellorName,
        fLegalPapaerReciept: fLegalPapaerReciept ?? this.fLegalPapaerReciept,
      );

  factory PerformaBatch.fromJson(Map<String, dynamic> json) => PerformaBatch(
        fInvoiceDate: json["f_InvoiceDate"].toString(),
        fInvoiceId: json["f_InvoiceID"].toString(),
        fStudentId: json["f_StudentId"].toString(),
        fStudentName: json["f_StudentName"].toString(),
        fMobile: json["f_Mobile"].toString(),
        fEmail: json["f_Email"].toString(),
        fTotalAmt: json["f_TotalAmt"].toString(),
        fPaidAmt: json["f_PaidAmt"].toString(),
        fClosedAmt: json["f_ClosedAmt"].toString(),
        fRefundedAmt: json["f_RefundedAmt"].toString(),
        fBalanceAmt: json["f_BalanceAmt"].toString(),
        fService: json["f_Service"].toString(),
        fNextDueDate: json["f_NextDueDate"].toString(),
        fStage: json["f_Stage"].toString(),
        isGst: json["isGST"].toString(),
        fTaxAmount: json["f_taxAmount"].toString(),
        counsellorName: json["CounsellorName"].toString(),
        fLegalPapaerReciept: json["f_LegalPapaer_Reciept"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "f_InvoiceDate": fInvoiceDate,
        "f_InvoiceID": fInvoiceId,
        "f_StudentId": fStudentId,
        "f_StudentName": fStudentName,
        "f_Mobile": fMobile,
        "f_Email": fEmail,
        "f_TotalAmt": fTotalAmt,
        "f_PaidAmt": fPaidAmt,
        "f_ClosedAmt": fClosedAmt,
        "f_RefundedAmt": fRefundedAmt,
        "f_BalanceAmt": fBalanceAmt,
        "f_Service": fService,
        "f_NextDueDate": fNextDueDate,
        "f_Stage": fStage,
        "isGST": isGst,
        "f_taxAmount": fTaxAmount,
        "CounsellorName": counsellorName,
        "f_LegalPapaer_Reciept": fLegalPapaerReciept,
      };
}
