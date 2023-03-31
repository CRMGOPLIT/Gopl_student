// To parse this JSON data, do
//
//     final universityVisitModel = universityVisitModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<UniversityVisitModel> universityVisitModelFromJson(String str) =>
    List<UniversityVisitModel>.from(
        json.decode(str).map((x) => UniversityVisitModel.fromJson(x)));

String universityVisitModelToJson(List<UniversityVisitModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UniversityVisitModel {
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
  });

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
  final String eventType;
  final String venueLat;
  final String venueLng;

  factory UniversityVisitModel.fromJson(Map<String, dynamic> json) =>
      UniversityVisitModel(
        countryVisitId: json["country_visit_id"],
        dateOfVisit: json["date_of_visit"],
        university: json["university"],
        branchName: json["branch_name"],
        intake: json["intake"],
        country: json["country"],
        fCountryid: json["f_countryid"],
        deligate: json["deligate"],
        timeFrom: json["time_from"],
        timeTo: json["time_to"],
        venue: json["venue"],
        visitPurpose: json["visit_purpose"],
        appointment: json["Appointment"],
        eventType: json["event_type"].toString(),
        venueLat: json["venue_lat"],
        venueLng: json["venue_lng"],
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
      };
}
