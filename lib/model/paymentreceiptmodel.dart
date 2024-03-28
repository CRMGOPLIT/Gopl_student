// To parse this JSON data, do
//
//     final batchPerformaReceipt = batchPerformaReceiptFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BatchPerformaReceipt batchPerformaReceiptFromJson(String str) =>
    BatchPerformaReceipt.fromJson(json.decode(str));

String batchPerformaReceiptToJson(BatchPerformaReceipt data) =>
    json.encode(data.toJson());

class BatchPerformaReceipt {
  final List<PrintMain> printMain;
  final List<PrintDetail> printDetail;
  final List<MakePaymentLst> makePaymentLst;
  final List<dynamic> refundDetails;

  BatchPerformaReceipt({
    required this.printMain,
    required this.printDetail,
    required this.makePaymentLst,
    required this.refundDetails,
  });

  BatchPerformaReceipt copyWith({
    List<PrintMain>? printMain,
    List<PrintDetail>? printDetail,
    List<MakePaymentLst>? makePaymentLst,
    List<dynamic>? refundDetails,
  }) =>
      BatchPerformaReceipt(
        printMain: printMain ?? this.printMain,
        printDetail: printDetail ?? this.printDetail,
        makePaymentLst: makePaymentLst ?? this.makePaymentLst,
        refundDetails: refundDetails ?? this.refundDetails,
      );

  factory BatchPerformaReceipt.fromJson(Map<String, dynamic> json) =>
      BatchPerformaReceipt(
        printMain: List<PrintMain>.from(
            json["PrintMain"].map((x) => PrintMain.fromJson(x))),
        printDetail: List<PrintDetail>.from(
            json["PrintDetail"].map((x) => PrintDetail.fromJson(x))),
        makePaymentLst: List<MakePaymentLst>.from(
            json["MakePaymentLst"].map((x) => MakePaymentLst.fromJson(x))),
        refundDetails: List<dynamic>.from(json["RefundDetails"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "PrintMain": List<dynamic>.from(printMain.map((x) => x.toJson())),
        "PrintDetail": List<dynamic>.from(printDetail.map((x) => x.toJson())),
        "MakePaymentLst":
            List<dynamic>.from(makePaymentLst.map((x) => x.toJson())),
        "RefundDetails": List<dynamic>.from(refundDetails.map((x) => x)),
      };
}

class MakePaymentLst {
  final String fStudentId;
  final dynamic fCounsellorId;
  final dynamic fBranchId;
  final dynamic fInvoiceNo;
  final String fPaymentMode;
  final dynamic fChequeNo;
  final dynamic fChequeDate;
  final dynamic fBankName;
  final dynamic fBranch;
  final dynamic fDraftNo;
  final dynamic fDraftDate;
  final dynamic fTransactionDate;
  final dynamic fTransactionId;
  final dynamic fCreditCardAmt;
  final String fPaymentDate;
  final dynamic fReceiveAmt;
  final dynamic fTds;
  final String fTotalReceiveAmt;
  final dynamic fTransactionCharges;
  final String fNextPaymentDate;
  final String fServiceName;
  final String fDescription;
  final String fReceiptNo;
  final dynamic picture;
  final dynamic filename;
  final dynamic fileName;
  final dynamic fileClear;
  final String imgPath;
  final String gstAmount;
  final dynamic erpService;
  final dynamic pictureLegal;
  final dynamic filenameLegal;
  final dynamic fileNameLegal;
  final dynamic fileClearLegal;
  final dynamic imgPathLegal;

  MakePaymentLst({
    required this.fStudentId,
    required this.fCounsellorId,
    required this.fBranchId,
    required this.fInvoiceNo,
    required this.fPaymentMode,
    required this.fChequeNo,
    required this.fChequeDate,
    required this.fBankName,
    required this.fBranch,
    required this.fDraftNo,
    required this.fDraftDate,
    required this.fTransactionDate,
    required this.fTransactionId,
    required this.fCreditCardAmt,
    required this.fPaymentDate,
    required this.fReceiveAmt,
    required this.fTds,
    required this.fTotalReceiveAmt,
    required this.fTransactionCharges,
    required this.fNextPaymentDate,
    required this.fServiceName,
    required this.fDescription,
    required this.fReceiptNo,
    required this.picture,
    required this.filename,
    required this.fileName,
    required this.fileClear,
    required this.imgPath,
    required this.gstAmount,
    required this.erpService,
    required this.pictureLegal,
    required this.filenameLegal,
    required this.fileNameLegal,
    required this.fileClearLegal,
    required this.imgPathLegal,
  });

  MakePaymentLst copyWith({
    String? fStudentId,
    dynamic fCounsellorId,
    dynamic fBranchId,
    dynamic fInvoiceNo,
    String? fPaymentMode,
    dynamic fChequeNo,
    dynamic fChequeDate,
    dynamic fBankName,
    dynamic fBranch,
    dynamic fDraftNo,
    dynamic fDraftDate,
    dynamic fTransactionDate,
    dynamic fTransactionId,
    dynamic fCreditCardAmt,
    String? fPaymentDate,
    dynamic fReceiveAmt,
    dynamic fTds,
    String? fTotalReceiveAmt,
    dynamic fTransactionCharges,
    String? fNextPaymentDate,
    String? fServiceName,
    String? fDescription,
    String? fReceiptNo,
    dynamic picture,
    dynamic filename,
    dynamic fileName,
    dynamic fileClear,
    String? imgPath,
    String? gstAmount,
    dynamic erpService,
    dynamic pictureLegal,
    dynamic filenameLegal,
    dynamic fileNameLegal,
    dynamic fileClearLegal,
    dynamic imgPathLegal,
  }) =>
      MakePaymentLst(
        fStudentId: fStudentId ?? this.fStudentId,
        fCounsellorId: fCounsellorId ?? this.fCounsellorId,
        fBranchId: fBranchId ?? this.fBranchId,
        fInvoiceNo: fInvoiceNo ?? this.fInvoiceNo,
        fPaymentMode: fPaymentMode ?? this.fPaymentMode,
        fChequeNo: fChequeNo ?? this.fChequeNo,
        fChequeDate: fChequeDate ?? this.fChequeDate,
        fBankName: fBankName ?? this.fBankName,
        fBranch: fBranch ?? this.fBranch,
        fDraftNo: fDraftNo ?? this.fDraftNo,
        fDraftDate: fDraftDate ?? this.fDraftDate,
        fTransactionDate: fTransactionDate ?? this.fTransactionDate,
        fTransactionId: fTransactionId ?? this.fTransactionId,
        fCreditCardAmt: fCreditCardAmt ?? this.fCreditCardAmt,
        fPaymentDate: fPaymentDate ?? this.fPaymentDate,
        fReceiveAmt: fReceiveAmt ?? this.fReceiveAmt,
        fTds: fTds ?? this.fTds,
        fTotalReceiveAmt: fTotalReceiveAmt ?? this.fTotalReceiveAmt,
        fTransactionCharges: fTransactionCharges ?? this.fTransactionCharges,
        fNextPaymentDate: fNextPaymentDate ?? this.fNextPaymentDate,
        fServiceName: fServiceName ?? this.fServiceName,
        fDescription: fDescription ?? this.fDescription,
        fReceiptNo: fReceiptNo ?? this.fReceiptNo,
        picture: picture ?? this.picture,
        filename: filename ?? this.filename,
        fileName: fileName ?? this.fileName,
        fileClear: fileClear ?? this.fileClear,
        imgPath: imgPath ?? this.imgPath,
        gstAmount: gstAmount ?? this.gstAmount,
        erpService: erpService ?? this.erpService,
        pictureLegal: pictureLegal ?? this.pictureLegal,
        filenameLegal: filenameLegal ?? this.filenameLegal,
        fileNameLegal: fileNameLegal ?? this.fileNameLegal,
        fileClearLegal: fileClearLegal ?? this.fileClearLegal,
        imgPathLegal: imgPathLegal ?? this.imgPathLegal,
      );

  factory MakePaymentLst.fromJson(Map<String, dynamic> json) => MakePaymentLst(
        fStudentId: json["f_StudentID"].toString(),
        fCounsellorId: json["f_CounsellorId"].toString(),
        fBranchId: json["f_BranchId"].toString(),
        fInvoiceNo: json["f_InvoiceNo"].toString(),
        fPaymentMode: json["f_PaymentMode"].toString(),
        fChequeNo: json["f_ChequeNo"].toString(),
        fChequeDate: json["f_ChequeDate"].toString(),
        fBankName: json["f_BankName"].toString(),
        fBranch: json["f_Branch"].toString(),
        fDraftNo: json["f_DraftNo"].toString(),
        fDraftDate: json["f_DraftDate"].toString(),
        fTransactionDate: json["f_TransactionDate"].toString(),
        fTransactionId: json["f_TransactionId"].toString(),
        fCreditCardAmt: json["f_CreditCardAmt"].toString(),
        fPaymentDate: json["f_PaymentDate"].toString(),
        fReceiveAmt: json["f_ReceiveAmt"].toString(),
        fTds: json["f_TDS"].toString(),
        fTotalReceiveAmt: json["f_TotalReceiveAmt"].toString(),
        fTransactionCharges: json["f_TransactionCharges"].toString(),
        fNextPaymentDate: json["f_NextPaymentDate"].toString(),
        fServiceName: json["f_ServiceName"].toString(),
        fDescription: json["f_Description"].toString(),
        fReceiptNo: json["f_ReceiptNo"].toString(),
        picture: json["picture"].toString(),
        filename: json["filename"].toString(),
        fileName: json["file_name"].toString(),
        fileClear: json["file_clear"].toString(),
        imgPath: json["imgPath"].toString(),
        gstAmount: json["GST_Amount"].toString(),
        erpService: json["ErpService"].toString(),
        pictureLegal: json["pictureLegal"].toString(),
        filenameLegal: json["filenameLegal"].toString(),
        fileNameLegal: json["file_nameLegal"].toString(),
        fileClearLegal: json["file_clearLegal"].toString(),
        imgPathLegal: json["imgPathLegal"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "f_StudentID": fStudentId,
        "f_CounsellorId": fCounsellorId,
        "f_BranchId": fBranchId,
        "f_InvoiceNo": fInvoiceNo,
        "f_PaymentMode": fPaymentMode,
        "f_ChequeNo": fChequeNo,
        "f_ChequeDate": fChequeDate,
        "f_BankName": fBankName,
        "f_Branch": fBranch,
        "f_DraftNo": fDraftNo,
        "f_DraftDate": fDraftDate,
        "f_TransactionDate": fTransactionDate,
        "f_TransactionId": fTransactionId,
        "f_CreditCardAmt": fCreditCardAmt,
        "f_PaymentDate": fPaymentDate,
        "f_ReceiveAmt": fReceiveAmt,
        "f_TDS": fTds,
        "f_TotalReceiveAmt": fTotalReceiveAmt,
        "f_TransactionCharges": fTransactionCharges,
        "f_NextPaymentDate": fNextPaymentDate,
        "f_ServiceName": fServiceName,
        "f_Description": fDescription,
        "f_ReceiptNo": fReceiptNo,
        "picture": picture,
        "filename": filename,
        "file_name": fileName,
        "file_clear": fileClear,
        "imgPath": imgPath,
        "GST_Amount": gstAmount,
        "ErpService": erpService,
        "pictureLegal": pictureLegal,
        "filenameLegal": filenameLegal,
        "file_nameLegal": fileNameLegal,
        "file_clearLegal": fileClearLegal,
        "imgPathLegal": imgPathLegal,
      };
}

class PrintDetail {
  final String fServiceName;
  final String fServiceUniqueCode;
  final String fServiceCode;
  final String fMProposalId;
  final String fProductId;
  final String fSubProductId;
  final String fProductName;
  final String fQty;
  final String fUnitPrice;
  final String fTaxAmt;
  final String fTotalAmt;
  final String fDescription;
  final dynamic fMProposalNo;
  final String fCountryId;
  final dynamic fReceiptNo;
  final String fSuggestedPrice;
  final dynamic fSubServiceType;
  final dynamic fFacultyId;

  PrintDetail({
    required this.fServiceName,
    required this.fServiceUniqueCode,
    required this.fServiceCode,
    required this.fMProposalId,
    required this.fProductId,
    required this.fSubProductId,
    required this.fProductName,
    required this.fQty,
    required this.fUnitPrice,
    required this.fTaxAmt,
    required this.fTotalAmt,
    required this.fDescription,
    required this.fMProposalNo,
    required this.fCountryId,
    required this.fReceiptNo,
    required this.fSuggestedPrice,
    required this.fSubServiceType,
    required this.fFacultyId,
  });

  PrintDetail copyWith({
    String? fServiceName,
    String? fServiceUniqueCode,
    String? fServiceCode,
    String? fMProposalId,
    String? fProductId,
    String? fSubProductId,
    String? fProductName,
    String? fQty,
    String? fUnitPrice,
    String? fTaxAmt,
    String? fTotalAmt,
    String? fDescription,
    dynamic fMProposalNo,
    String? fCountryId,
    dynamic fReceiptNo,
    String? fSuggestedPrice,
    dynamic fSubServiceType,
    dynamic fFacultyId,
  }) =>
      PrintDetail(
        fServiceName: fServiceName ?? this.fServiceName,
        fServiceUniqueCode: fServiceUniqueCode ?? this.fServiceUniqueCode,
        fServiceCode: fServiceCode ?? this.fServiceCode,
        fMProposalId: fMProposalId ?? this.fMProposalId,
        fProductId: fProductId ?? this.fProductId,
        fSubProductId: fSubProductId ?? this.fSubProductId,
        fProductName: fProductName ?? this.fProductName,
        fQty: fQty ?? this.fQty,
        fUnitPrice: fUnitPrice ?? this.fUnitPrice,
        fTaxAmt: fTaxAmt ?? this.fTaxAmt,
        fTotalAmt: fTotalAmt ?? this.fTotalAmt,
        fDescription: fDescription ?? this.fDescription,
        fMProposalNo: fMProposalNo ?? this.fMProposalNo,
        fCountryId: fCountryId ?? this.fCountryId,
        fReceiptNo: fReceiptNo ?? this.fReceiptNo,
        fSuggestedPrice: fSuggestedPrice ?? this.fSuggestedPrice,
        fSubServiceType: fSubServiceType ?? this.fSubServiceType,
        fFacultyId: fFacultyId ?? this.fFacultyId,
      );

  factory PrintDetail.fromJson(Map<String, dynamic> json) => PrintDetail(
        fServiceName: json["f_ServiceName"].toString(),
        fServiceUniqueCode: json["f_ServiceUniqueCode"].toString(),
        fServiceCode: json["f_ServiceCode"].toString(),
        fMProposalId: json["f_MProposalId"].toString(),
        fProductId: json["f_ProductId"].toString(),
        fSubProductId: json["f_SubProductId"].toString(),
        fProductName: json["f_ProductName"].toString(),
        fQty: json["f_Qty"].toString(),
        fUnitPrice: json["f_UnitPrice"].toString(),
        fTaxAmt: json["f_tax_amt"].toString(),
        fTotalAmt: json["f_total_amt"].toString(),
        fDescription: json["f_Description"].toString(),
        fMProposalNo: json["f_MProposalNo"].toString(),
        fCountryId: json["f_CountryId"].toString(),
        fReceiptNo: json["f_ReceiptNo"].toString(),
        fSuggestedPrice: json["f_SuggestedPrice"].toString(),
        fSubServiceType: json["f_SubServiceType"].toString(),
        fFacultyId: json["f_FacultyID"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "f_ServiceName": fServiceName,
        "f_ServiceUniqueCode": fServiceUniqueCode,
        "f_ServiceCode": fServiceCode,
        "f_MProposalId": fMProposalId,
        "f_ProductId": fProductId,
        "f_SubProductId": fSubProductId,
        "f_ProductName": fProductName,
        "f_Qty": fQty,
        "f_UnitPrice": fUnitPrice,
        "f_tax_amt": fTaxAmt,
        "f_total_amt": fTotalAmt,
        "f_Description": fDescription,
        "f_MProposalNo": fMProposalNo,
        "f_CountryId": fCountryId,
        "f_ReceiptNo": fReceiptNo,
        "f_SuggestedPrice": fSuggestedPrice,
        "f_SubServiceType": fSubServiceType,
        "f_FacultyID": fFacultyId,
      };
}

class PrintMain {
  final String fUserName;
  final String pendingAmount;
  final String fClientId;
  final String fProposalNo;
  final String fProposalDate;
  final String fDeliveryDate;
  final String fPriceType;
  final String fStudentFullName;
  final String fMobile;
  final String fTaxPresentage;
  final String fTaxAmount;
  final String fOtherExp;
  final String fSubTotal;
  final String fReceiveTotalAmt;
  final String fGrandTotal;
  final String fBranchAddress;
  final String fBranchDiscount;
  final String fBranchDiscountPer;
  final String studentAddress;
  final String fCity;
  final String fPin;
  final String fEmail;
  final String studentState;
  final String fClosedAmt;
  final String fRefundedAmt;
  final String fInvoiceStage;
  final String fBranchName;
  final String isGst;
  final String fGstNo;
  final int checkdate;
  final String fLegalPapaerReciept;
  final String fCurrencyType;
  final String fGrandTotal236Percentage;
  final String totalAmount;

  PrintMain({
    required this.fUserName,
    required this.pendingAmount,
    required this.fClientId,
    required this.fProposalNo,
    required this.fProposalDate,
    required this.fDeliveryDate,
    required this.fPriceType,
    required this.fStudentFullName,
    required this.fMobile,
    required this.fTaxPresentage,
    required this.fTaxAmount,
    required this.fOtherExp,
    required this.fSubTotal,
    required this.fReceiveTotalAmt,
    required this.fGrandTotal,
    required this.fBranchAddress,
    required this.fBranchDiscount,
    required this.fBranchDiscountPer,
    required this.studentAddress,
    required this.fCity,
    required this.fPin,
    required this.fEmail,
    required this.studentState,
    required this.fClosedAmt,
    required this.fRefundedAmt,
    required this.fInvoiceStage,
    required this.fBranchName,
    required this.isGst,
    required this.fGstNo,
    required this.checkdate,
    required this.fLegalPapaerReciept,
    required this.fCurrencyType,
    required this.fGrandTotal236Percentage,
    required this.totalAmount,
  });

  PrintMain copyWith({
    String? fUserName,
    String? pendingAmount,
    String? fClientId,
    String? fProposalNo,
    String? fProposalDate,
    String? fDeliveryDate,
    String? fPriceType,
    String? fStudentFullName,
    String? fMobile,
    String? fTaxPresentage,
    String? fTaxAmount,
    String? fOtherExp,
    String? fSubTotal,
    String? fReceiveTotalAmt,
    String? fGrandTotal,
    String? fBranchAddress,
    String? fBranchDiscount,
    String? fBranchDiscountPer,
    String? studentAddress,
    String? fCity,
    String? fPin,
    String? fEmail,
    String? studentState,
    String? fClosedAmt,
    String? fRefundedAmt,
    String? fInvoiceStage,
    String? fBranchName,
    String? isGst,
    String? fGstNo,
    int? checkdate,
    String? fLegalPapaerReciept,
    String? fCurrencyType,
    String? fGrandTotal236Percentage,
    String? totalAmount,
  }) =>
      PrintMain(
        fUserName: fUserName ?? this.fUserName,
        pendingAmount: pendingAmount ?? this.pendingAmount,
        fClientId: fClientId ?? this.fClientId,
        fProposalNo: fProposalNo ?? this.fProposalNo,
        fProposalDate: fProposalDate ?? this.fProposalDate,
        fDeliveryDate: fDeliveryDate ?? this.fDeliveryDate,
        fPriceType: fPriceType ?? this.fPriceType,
        fStudentFullName: fStudentFullName ?? this.fStudentFullName,
        fMobile: fMobile ?? this.fMobile,
        fTaxPresentage: fTaxPresentage ?? this.fTaxPresentage,
        fTaxAmount: fTaxAmount ?? this.fTaxAmount,
        fOtherExp: fOtherExp ?? this.fOtherExp,
        fSubTotal: fSubTotal ?? this.fSubTotal,
        fReceiveTotalAmt: fReceiveTotalAmt ?? this.fReceiveTotalAmt,
        fGrandTotal: fGrandTotal ?? this.fGrandTotal,
        fBranchAddress: fBranchAddress ?? this.fBranchAddress,
        fBranchDiscount: fBranchDiscount ?? this.fBranchDiscount,
        fBranchDiscountPer: fBranchDiscountPer ?? this.fBranchDiscountPer,
        studentAddress: studentAddress ?? this.studentAddress,
        fCity: fCity ?? this.fCity,
        fPin: fPin ?? this.fPin,
        fEmail: fEmail ?? this.fEmail,
        studentState: studentState ?? this.studentState,
        fClosedAmt: fClosedAmt ?? this.fClosedAmt,
        fRefundedAmt: fRefundedAmt ?? this.fRefundedAmt,
        fInvoiceStage: fInvoiceStage ?? this.fInvoiceStage,
        fBranchName: fBranchName ?? this.fBranchName,
        isGst: isGst ?? this.isGst,
        fGstNo: fGstNo ?? this.fGstNo,
        checkdate: checkdate ?? this.checkdate,
        fLegalPapaerReciept: fLegalPapaerReciept ?? this.fLegalPapaerReciept,
        fCurrencyType: fCurrencyType ?? this.fCurrencyType,
        fGrandTotal236Percentage:
            fGrandTotal236Percentage ?? this.fGrandTotal236Percentage,
        totalAmount: totalAmount ?? this.totalAmount,
      );

  factory PrintMain.fromJson(Map<String, dynamic> json) => PrintMain(
        fUserName: json["f_UserName"].toString(),
        pendingAmount: json["PendingAmount"].toString(),
        fClientId: json["f_ClientId"].toString(),
        fProposalNo: json["f_Proposal_no"].toString(),
        fProposalDate: json["f_ProposalDate"].toString(),
        fDeliveryDate: json["f_DeliveryDate"].toString(),
        fPriceType: json["f_PriceType"].toString(),
        fStudentFullName: json["f_StudentFullName"].toString(),
        fMobile: json["f_Mobile"].toString(),
        fTaxPresentage: json["f_tax_Presentage"].toString(),
        fTaxAmount: json["f_taxAmount"].toString(),
        fOtherExp: json["f_OtherExp"].toString(),
        fSubTotal: json["f_Sub_Total"].toString(),
        fReceiveTotalAmt: json["f_ReceiveTotalAmt"].toString(),
        fGrandTotal: json["f_GrandTotal"].toString(),
        fBranchAddress: json["f_BranchAddress"].toString(),
        fBranchDiscount: json["f_BranchDiscount"].toString(),
        fBranchDiscountPer: json["f_BranchDiscountPer"].toString(),
        studentAddress: json["StudentAddress"].toString(),
        fCity: json["f_City"].toString(),
        fPin: json["f_Pin"].toString(),
        fEmail: json["f_Email"].toString(),
        studentState: json["StudentState"].toString(),
        fClosedAmt: json["f_ClosedAmt"].toString(),
        fRefundedAmt: json["f_RefundedAmt"].toString(),
        fInvoiceStage: json["f_InvoiceStage"].toString(),
        fBranchName: json["f_BranchName"].toString(),
        isGst: json["isGST"].toString(),
        fGstNo: json["f_GSTNo"].toString(),
        checkdate: json["checkdate"],
        fLegalPapaerReciept: json["f_LegalPapaer_Reciept"].toString(),
        fCurrencyType: json["f_CurrencyType"].toString(),
        fGrandTotal236Percentage:
            json["f_Grand_Total_2_36_Percentage"].toString(),
        totalAmount: json["TotalAmount"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "f_UserName": fUserName,
        "PendingAmount": pendingAmount,
        "f_ClientId": fClientId,
        "f_Proposal_no": fProposalNo,
        "f_ProposalDate": fProposalDate,
        "f_DeliveryDate": fDeliveryDate,
        "f_PriceType": fPriceType,
        "f_StudentFullName": fStudentFullName,
        "f_Mobile": fMobile,
        "f_tax_Presentage": fTaxPresentage,
        "f_taxAmount": fTaxAmount,
        "f_OtherExp": fOtherExp,
        "f_Sub_Total": fSubTotal,
        "f_ReceiveTotalAmt": fReceiveTotalAmt,
        "f_GrandTotal": fGrandTotal,
        "f_BranchAddress": fBranchAddress,
        "f_BranchDiscount": fBranchDiscount,
        "f_BranchDiscountPer": fBranchDiscountPer,
        "StudentAddress": studentAddress,
        "f_City": fCity,
        "f_Pin": fPin,
        "f_Email": fEmail,
        "StudentState": studentState,
        "f_ClosedAmt": fClosedAmt,
        "f_RefundedAmt": fRefundedAmt,
        "f_InvoiceStage": fInvoiceStage,
        "f_BranchName": fBranchName,
        "isGST": isGst,
        "f_GSTNo": fGstNo,
        "checkdate": checkdate,
        "f_LegalPapaer_Reciept": fLegalPapaerReciept,
        "f_CurrencyType": fCurrencyType,
        "f_Grand_Total_2_36_Percentage": fGrandTotal236Percentage,
        "TotalAmount": totalAmount,
      };
}
