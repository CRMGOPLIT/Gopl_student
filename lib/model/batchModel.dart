// To parse this JSON data, do
//
//     final batchDetailsModel = batchDetailsModelFromJson(jsonString);

import 'dart:convert';

List<BatchDetailsModel> batchDetailsModelFromJson(String str) =>
    List<BatchDetailsModel>.from(
        json.decode(str).map((x) => BatchDetailsModel.fromJson(x)));

String batchDetailsModelToJson(List<BatchDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BatchDetailsModel {
  String? fFacultyName;
  String? fFacultyGrade;
  String? fBatchName;
  String? fBatchTiming;
  String? fBatchStartDate;
  String? fBatchEndDate;
  String? fBatchSize;
  String? fBranchName;
  String? fIsOffline;
  String? fIsLaunchBatch;
  int? confirmedWithFullPayment;
  int? confirmedWithPartialPayment;
  String? status;
  String? fFacultyImag;

  BatchDetailsModel({
    this.fFacultyName,
    this.fFacultyGrade,
    this.fBatchName,
    this.fBatchTiming,
    this.fBatchStartDate,
    this.fBatchEndDate,
    this.fBatchSize,
    this.fBranchName,
    this.fIsOffline,
    this.fIsLaunchBatch,
    this.confirmedWithFullPayment,
    this.confirmedWithPartialPayment,
    this.status,
    this.fFacultyImag,
  });

  factory BatchDetailsModel.fromJson(Map<String, dynamic> json) =>
      BatchDetailsModel(
        fFacultyName: json["f_FacultyName"].toString(),
        fFacultyGrade: json["f_FacultyGrade"].toString(),
        fBatchName: json["f_BatchName"].toString(),
        fBatchTiming: json["f_BatchTiming"].toString(),
        fBatchStartDate: json["f_BatchStartDate"].toString(),
        fBatchEndDate: json["f_BatchEndDate"].toString(),
        fBatchSize: json["f_BatchSize"].toString(),
        fBranchName: json["f_BranchName"].toString(),
        fIsOffline: json["f_IsOffline"].toString(),
        fIsLaunchBatch: json["f_IsLaunchBatch"].toString(),
        confirmedWithFullPayment: json["ConfirmedWithFullPayment"],
        confirmedWithPartialPayment: json["ConfirmedWithPartialPayment"],
        status: json["status"].toString(),
        fFacultyImag: json["f_FacultyImag"].toString(),
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
        "status": status,
        "f_FacultyImag": fFacultyImag,
      };
}
