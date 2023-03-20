import 'dart:convert';

List<BranchDetailsModel> branchDetailsModelFromJson(String str) =>
    List<BranchDetailsModel>.from(
        json.decode(str).map((x) => BranchDetailsModel.fromJson(x)));

String branchDetailsModelToJson(List<BranchDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BranchDetailsModel {
  BranchDetailsModel({
    required this.branchId,
    required this.branchName,
    required this.branchPhone,
    required this.branchAddress,
    required this.locationUrl,
  });

  final String branchId;
  final String branchName;
  final String branchPhone;
  final String branchAddress;
  final String locationUrl;

  factory BranchDetailsModel.fromJson(Map<String, dynamic> json) =>
      BranchDetailsModel(
        branchId: json["branch_id"],
        branchName: json["branch_name"],
        branchPhone: json["branch_phone"],
        branchAddress: json["branch_Address"],
        locationUrl: json["Location_Url"],
      );

  Map<String, dynamic> toJson() => {
        "branch_id": branchId,
        "branch_name": branchName,
        "branch_phone": branchPhone,
        "branch_Address": branchAddress,
        "Location_Url": locationUrl,
      };
}
