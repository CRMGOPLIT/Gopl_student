import 'dart:convert';

List<UniversityVisitModel> universityVisitModelFromJson(String str) =>
    List<UniversityVisitModel>.from(
        json.decode(str).map((x) => UniversityVisitModel.fromJson(x)));

String universityVisitModelToJson(List<UniversityVisitModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UniversityVisitModel {
  final String countryVisitId;
  final String dateOfVisit;
  final String university;
  final String branchName;
  final String intake;
  final String country;
  final String fCountryid;
  final String deligate;
  final String timeFrom;
  final String timeTo;
  final String venue;
  final String visitPurpose;
  final String appointment;
  final dynamic eventType;
  final String venueLat;
  final String venueLng;
  final String logo;

  UniversityVisitModel({
    required this.countryVisitId,
    required this.dateOfVisit,
    required this.university,
    required this.branchName,
    required this.intake,
    required this.country,
    required this.fCountryid,
    required this.deligate,
    required this.timeFrom,
    required this.timeTo,
    required this.venue,
    required this.visitPurpose,
    required this.appointment,
    required this.eventType,
    required this.venueLat,
    required this.venueLng,
    required this.logo,
  });

  factory UniversityVisitModel.fromJson(Map<String, dynamic> json) =>
      UniversityVisitModel(
        countryVisitId: json["country_visit_id"].toString(),
        dateOfVisit: json["date_of_visit"].toString(),
        university: json["university"].toString(),
        branchName: json["branch_name"].toString(),
        intake: json["intake"].toString(),
        country: json["country"].toString(),
        fCountryid: json["f_countryid"].toString(),
        deligate: json["deligate"].toString(),
        timeFrom: json["time_from"].toString(),
        timeTo: json["time_to"].toString(),
        venue: json["venue"].toString(),
        visitPurpose: json["visit_purpose"].toString(),
        appointment: json["Appointment"].toString(),
        eventType: json["event_type"].toString(),
        venueLat: json["venue_lat"].toString(),
        venueLng: json["venue_lng"].toString(),
        logo: json["Logo"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "country_visit_id": countryVisitId,
        "date_of_visit": dateOfVisit,
        "university": university,
        "branch_name": branchName,
        "intake": intake,
        "country": country,
        "f_countryid": fCountryid,
        "deligate": deligate,
        "time_from": timeFrom,
        "time_to": timeTo,
        "venue": venue,
        "visit_purpose": visitPurpose,
        "Appointment": appointment,
        "event_type": eventType,
        "venue_lat": venueLat,
        "venue_lng": venueLng,
        "Logo": logo,
      };
}
