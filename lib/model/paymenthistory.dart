import 'dart:convert';

PaymentHistory paymentHistoryFromJson(String str) =>
    PaymentHistory.fromJson(json.decode(str));

String paymentHistoryToJson(PaymentHistory data) => json.encode(data.toJson());

class PaymentHistory {
  final List<PaymentRazorPayHistory> paymentRazorPayHistory;

  PaymentHistory({
    required this.paymentRazorPayHistory,
  });

  PaymentHistory copyWith({
    List<PaymentRazorPayHistory>? paymentRazorPayHistory,
  }) =>
      PaymentHistory(
        paymentRazorPayHistory:
            paymentRazorPayHistory ?? this.paymentRazorPayHistory,
      );

  factory PaymentHistory.fromJson(Map<String, dynamic> json) => PaymentHistory(
        paymentRazorPayHistory: List<PaymentRazorPayHistory>.from(
            json["PaymentRazorPayHistory"]
                .map((x) => PaymentRazorPayHistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "PaymentRazorPayHistory":
            List<dynamic>.from(paymentRazorPayHistory.map((x) => x.toJson())),
      };
}

class PaymentRazorPayHistory {
  final String fStudentId;
  final String fPaymentMode;
  final String fPaymentDate;
  final String fTotalReceiveAmt;
  final String fServiceName;
  final String fReceiptNo;
  final String invoiceStage;

  PaymentRazorPayHistory({
    required this.fStudentId,
    required this.fPaymentMode,
    required this.fPaymentDate,
    required this.fTotalReceiveAmt,
    required this.fServiceName,
    required this.fReceiptNo,
    required this.invoiceStage,
  });

  PaymentRazorPayHistory copyWith({
    String? fStudentId,
    String? fPaymentMode,
    String? fPaymentDate,
    String? fTotalReceiveAmt,
    String? fServiceName,
    String? fReceiptNo,
    String? invoiceStage,
  }) =>
      PaymentRazorPayHistory(
        fStudentId: fStudentId ?? this.fStudentId,
        fPaymentMode: fPaymentMode ?? this.fPaymentMode,
        fPaymentDate: fPaymentDate ?? this.fPaymentDate,
        fTotalReceiveAmt: fTotalReceiveAmt ?? this.fTotalReceiveAmt,
        fServiceName: fServiceName ?? this.fServiceName,
        fReceiptNo: fReceiptNo ?? this.fReceiptNo,
        invoiceStage: invoiceStage ?? this.invoiceStage,
      );

  factory PaymentRazorPayHistory.fromJson(Map<String, dynamic> json) =>
      PaymentRazorPayHistory(
        fStudentId: json["f_StudentID"].toString(),
        fPaymentMode: json["f_PaymentMode"].toString(),
        fPaymentDate: json["f_PaymentDate"].toString(),
        fTotalReceiveAmt: json["f_TotalReceiveAmt"].toString(),
        fServiceName: json["f_ServiceName"].toString(),
        fReceiptNo: json["f_ReceiptNo"].toString(),
        invoiceStage: json["invoice_stage"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "f_StudentID": fStudentId,
        "f_PaymentMode": fPaymentMode,
        "f_PaymentDate": fPaymentDate,
        "f_TotalReceiveAmt": fTotalReceiveAmt,
        "f_ServiceName": fServiceName,
        "f_ReceiptNo": fReceiptNo,
        "invoice_stage": invoiceStage,
      };
}
