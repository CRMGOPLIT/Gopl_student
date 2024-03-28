// To parse this JSON data, do
//
//     final performacreatelist = performacreatelistFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Performacreatelist performacreatelistFromJson(String str) =>
    Performacreatelist.fromJson(json.decode(str));

String performacreatelistToJson(Performacreatelist data) =>
    json.encode(data.toJson());

class Performacreatelist {
  final List<Miscellaneous> pas;
  final List<Miscellaneous> testPrep;
  final List<Miscellaneous> visaServices;
  final List<Miscellaneous> miscellaneous;
  final List<Miscellaneous> prServices;

  Performacreatelist({
    required this.pas,
    required this.testPrep,
    required this.visaServices,
    required this.miscellaneous,
    required this.prServices,
  });

  Performacreatelist copyWith({
    List<Miscellaneous>? pas,
    List<Miscellaneous>? testPrep,
    List<Miscellaneous>? visaServices,
    List<Miscellaneous>? miscellaneous,
    List<dynamic>? prServices,
  }) =>
      Performacreatelist(
        pas: pas ?? this.pas,
        testPrep: testPrep ?? this.testPrep,
        visaServices: visaServices ?? this.visaServices,
        miscellaneous: miscellaneous ?? this.miscellaneous,
        prServices: miscellaneous ?? this.prServices,
      );

  factory Performacreatelist.fromJson(Map<String, dynamic> json) =>
      Performacreatelist(
        pas: List<Miscellaneous>.from(
            json["PAS"].map((x) => Miscellaneous.fromJson(x))),
        testPrep: List<Miscellaneous>.from(
            json["TestPrep"].map((x) => Miscellaneous.fromJson(x))),
        visaServices: List<Miscellaneous>.from(
            json["VisaServices"].map((x) => Miscellaneous.fromJson(x))),
        miscellaneous: List<Miscellaneous>.from(
            json["Miscellaneous"].map((x) => Miscellaneous.fromJson(x))),
        prServices: List<Miscellaneous>.from(json["PRServices"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "PAS": List<dynamic>.from(pas.map((x) => x.toJson())),
        "TestPrep": List<dynamic>.from(testPrep.map((x) => x.toJson())),
        "VisaServices": List<dynamic>.from(visaServices.map((x) => x.toJson())),
        "Miscellaneous":
            List<dynamic>.from(miscellaneous.map((x) => x.toJson())),
        "PRServices": List<dynamic>.from(prServices.map((x) => x)),
      };
}

class Miscellaneous {
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
  final String fLegalPapaerReciept;
  final String basePriceAndTax;
  final String currentCounsellor;
  final String currentBranch;
  final String fSubCategoryName;
  final String serviceType;

  Miscellaneous({
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
    required this.basePriceAndTax,
    required this.currentCounsellor,
    required this.currentBranch,
    required this.fSubCategoryName,
    required this.serviceType,
  });

  Miscellaneous copyWith({
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
    String? fLegalPapaerReciept,
    String? basePriceAndTax,
    String? currentCounsellor,
    String? currentBranch,
    String? fSubCategoryName,
    String? serviceType,
  }) =>
      Miscellaneous(
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
        basePriceAndTax: basePriceAndTax ?? this.basePriceAndTax,
        currentCounsellor: currentCounsellor ?? this.currentCounsellor,
        currentBranch: currentBranch ?? this.currentBranch,
        fSubCategoryName: fSubCategoryName ?? this.fSubCategoryName,
        serviceType: serviceType ?? this.serviceType,
      );

  factory Miscellaneous.fromJson(Map<String, dynamic> json) => Miscellaneous(
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
        basePriceAndTax: json["BasePriceAndTax"].toString(),
        currentCounsellor: json["CurrentCounsellor"].toString(),
        currentBranch: json["CurrentBranch"].toString(),
        fSubCategoryName: json["f_SubCategoryName"].toString(),
        serviceType: json["ServiceType"].toString(),
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
        "BasePriceAndTax": basePriceAndTax,
        "CurrentCounsellor": currentCounsellor,
        "CurrentBranch": currentBranch,
        "f_SubCategoryName": fSubCategoryName,
        "ServiceType": serviceType,
      };
}
