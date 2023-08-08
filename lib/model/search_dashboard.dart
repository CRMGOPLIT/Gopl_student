import 'dart:convert';

SearchDashBoard searchDashBoardFromJson(String str) =>
    SearchDashBoard.fromJson(json.decode(str));

String searchDashBoardToJson(SearchDashBoard data) =>
    json.encode(data.toJson());

class SearchDashBoard {
  final List<DashboardCourseDetail> dashboardCourseDetail;
  final List<DashboardUniversityDetail> dashboardUniversityDetail;
  final List<DashboardCountryDetail> dashboardCountryDetail;

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
  final String country;
  final String universityCount;
  final String countryId;
  final String countryImg;

  DashboardCountryDetail({
    required this.country,
    required this.universityCount,
    required this.countryId,
    required this.countryImg,
  });

  factory DashboardCountryDetail.fromJson(Map<String, dynamic> json) =>
      DashboardCountryDetail(
        country: json["Country"],
        universityCount: json["UniversityCount"],
        countryId: json["CountryId"],
        countryImg: json["CountryImg"],
      );

  Map<String, dynamic> toJson() => {
        "Country": country,
        "UniversityCount": universityCount,
        "CountryId": countryId,
        "CountryImg": countryImg,
      };
}

class DashboardCourseDetail {
  final String universityImage;
  final String course;
  final String university;
  final String fees;
  final String courseId;

  DashboardCourseDetail({
    required this.universityImage,
    required this.course,
    required this.university,
    required this.fees,
    required this.courseId,
  });

  factory DashboardCourseDetail.fromJson(Map<String, dynamic> json) =>
      DashboardCourseDetail(
        universityImage: json["UniversityImage"].toString(),
        course: json["Course"].toString(),
        university: json["University"].toString(),
        fees: json["Fees"].toString(),
        courseId: json["CourseId"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "UniversityImage": universityImage,
        "Course": course,
        "University": university,
        "Fees": fees,
        "CourseId": courseId,
      };
}

class DashboardUniversityDetail {
  final String universityImage;
  final Country country;
  final String university;
  final String universityId;
  final String countryId;

  DashboardUniversityDetail({
    required this.universityImage,
    required this.country,
    required this.university,
    required this.universityId,
    required this.countryId,
  });

  factory DashboardUniversityDetail.fromJson(Map<String, dynamic> json) =>
      DashboardUniversityDetail(
        universityImage: json["UniversityImage"].toString(),
        country: countryValues.map[json["Country"]]!,
        university: json["University"].toString(),
        universityId: json["UniversityId"].toString(),
        countryId: json["CountryId"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "UniversityImage": universityImage,
        "Country": countryValues.reverse[country],
        "University": university,
        "UniversityId": universityId,
        "CountryId": countryId,
      };
}

enum Country { CANADA }

final countryValues = EnumValues({"Canada": Country.CANADA});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
