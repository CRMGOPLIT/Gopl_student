// To parse this JSON data, do
//
//     final searchDashBoard = searchDashBoardFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SearchDashBoard searchDashBoardFromJson(String str) =>
    SearchDashBoard.fromJson(json.decode(str));

String searchDashBoardToJson(SearchDashBoard data) =>
    json.encode(data.toJson());

class SearchDashBoard {
  List<DashboardCourseDetail> dashboardCourseDetail;
  List<DashboardUniversityDetail> dashboardUniversityDetail;
  List<DashboardCountryDetail> dashboardCountryDetail;

  SearchDashBoard({
    required this.dashboardCourseDetail,
    required this.dashboardUniversityDetail,
    required this.dashboardCountryDetail,
  });

  factory SearchDashBoard.fromJson(Map<String, dynamic> json) =>
      SearchDashBoard(
        dashboardCourseDetail: List<DashboardCourseDetail>.from(
            json["DashboardCourseDetail"]
                .map((x) => DashboardCourseDetail.fromJson(x))),
        dashboardUniversityDetail: List<DashboardUniversityDetail>.from(
            json["DashboardUniversityDetail"]
                .map((x) => DashboardUniversityDetail.fromJson(x))),
        dashboardCountryDetail: List<DashboardCountryDetail>.from(
            json["DashboardCountryDetail"]
                .map((x) => DashboardCountryDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "DashboardCourseDetail":
            List<dynamic>.from(dashboardCourseDetail.map((x) => x.toJson())),
        "DashboardUniversityDetail": List<dynamic>.from(
            dashboardUniversityDetail.map((x) => x.toJson())),
        "DashboardCountryDetail":
            List<dynamic>.from(dashboardCountryDetail.map((x) => x.toJson())),
      };
}

class DashboardCountryDetail {
  String country;
  String universityCount;

  DashboardCountryDetail({
    required this.country,
    required this.universityCount,
  });

  factory DashboardCountryDetail.fromJson(Map<String, dynamic> json) =>
      DashboardCountryDetail(
        country: json["Country"],
        universityCount: json["UniversityCount"],
      );

  Map<String, dynamic> toJson() => {
        "Country": country,
        "UniversityCount": universityCount,
      };
}

class DashboardCourseDetail {
  String universityImage;
  String course;
  String university;
  String fees;

  DashboardCourseDetail({
    required this.universityImage,
    required this.course,
    required this.university,
    required this.fees,
  });

  factory DashboardCourseDetail.fromJson(Map<String, dynamic> json) =>
      DashboardCourseDetail(
        universityImage: json["UniversityImage"],
        course: json["Course"],
        university: json["University"],
        fees: json["Fees"],
      );

  Map<String, dynamic> toJson() => {
        "UniversityImage": universityImage,
        "Course": course,
        "University": university,
        "Fees": fees,
      };
}

class DashboardUniversityDetail {
  String universityImage;
  String country;
  String university;

  DashboardUniversityDetail({
    required this.universityImage,
    required this.country,
    required this.university,
  });

  factory DashboardUniversityDetail.fromJson(Map<String, dynamic> json) =>
      DashboardUniversityDetail(
        universityImage: json["UniversityImage"],
        country: json["Country"],
        university: json["University"],
      );

  Map<String, dynamic> toJson() => {
        "UniversityImage": universityImage,
        "Country": country,
        "University": university,
      };
}
