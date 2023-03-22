// To parse this JSON data, do
//
//     final BatchDetailsModel = BatchDetailsModelFromJson(jsonString);

import 'dart:convert';

List<BatchDetailsModel> BatchDetailsModelFromJson(String str) =>
    List<BatchDetailsModel>.from(
        json.decode(str).map((x) => BatchDetailsModel.fromJson(x)));

String BatchDetailsModelToJson(List<BatchDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BatchDetailsModel {
  BatchDetailsModel({
    required this.fFacultyName,
    required this.fFacultyGrade,
    required this.fBatchName,
    required this.fBatchTiming,
    required this.fBatchStartDate,
    required this.fBatchEndDate,
    required this.fBatchSize,
    required this.fBranchName,
    required this.fIsOffline,
    required this.fIsLaunchBatch,
    required this.confirmedWithFullPayment,
    required this.confirmedWithPartialPayment,
    required this.fFacultyImag,
  });

  final String fFacultyName;
  final String fFacultyGrade;
  final String fBatchName;
  final String fBatchTiming;
  final String fBatchStartDate;
  final String fBatchEndDate;
  final String fBatchSize;
  final String fBranchName;
  final String fIsOffline;
  final String fIsLaunchBatch;
  final int confirmedWithFullPayment;
  final int confirmedWithPartialPayment;
  final String fFacultyImag;

  factory BatchDetailsModel.fromJson(Map<String, dynamic> json) =>
      BatchDetailsModel(
        fFacultyName: json["f_FacultyName"],
        fFacultyGrade: json["f_FacultyGrade"],
        fBatchName: json["f_BatchName"],
        fBatchTiming: json["f_BatchTiming"],
        fBatchStartDate: json["f_BatchStartDate"],
        fBatchEndDate: json["f_BatchEndDate"],
        fBatchSize: json["f_BatchSize"],
        fBranchName: json["f_BranchName"],
        fIsOffline: json["f_IsOffline"],
        fIsLaunchBatch: json["f_IsLaunchBatch"],
        confirmedWithFullPayment: json["ConfirmedWithFullPayment"],
        confirmedWithPartialPayment: json["ConfirmedWithPartialPayment"],
        fFacultyImag: json["f_FacultyImag"],
      );

  Map<String, dynamic> toJson() => {
        "f_FacultyName": fFacultyName,
        "f_FacultyGrade": fFacultyGrade,
        "f_BatchName": fBatchName,
        "f_BatchTiming": fBatchTiming,
        "f_BatchStartDate": fBatchStartDate,
        "f_BatchEndDate": fBatchEndDate,
        "f_BatchSize": fBatchSize,
        "f_BranchName": fBranchName,
        "f_IsOffline": fIsOffline,
        "f_IsLaunchBatch": fIsLaunchBatch,
        "ConfirmedWithFullPayment": confirmedWithFullPayment,
        "ConfirmedWithPartialPayment": confirmedWithPartialPayment,
        "f_FacultyImag": fFacultyImag,
      };
}