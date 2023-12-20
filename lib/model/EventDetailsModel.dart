import 'dart:convert';

List<EvenetDetailsModel> evenetDetailsModelFromJson(String str) =>
    List<EvenetDetailsModel>.from(
        json.decode(str).map((x) => EvenetDetailsModel.fromJson(x)));

String evenetDetailsModelToJson(List<EvenetDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EvenetDetailsModel {
  final String event;
  final String date;
  final String time;
  final String venue;
  final String branch;
  final String venueLocation;
  final String eventlocationImage;

  EvenetDetailsModel({
    required this.event,
    required this.date,
    required this.time,
    required this.venue,
    required this.branch,
    required this.venueLocation,
    required this.eventlocationImage,
  });

  EvenetDetailsModel copyWith({
    String? event,
    String? date,
    String? time,
    String? venue,
    String? branch,
    String? venueLocation,
    String? eventlocationImage,
  }) =>
      EvenetDetailsModel(
        event: event ?? this.event,
        date: date ?? this.date,
        time: time ?? this.time,
        venue: venue ?? this.venue,
        branch: branch ?? this.branch,
        venueLocation: venueLocation ?? this.venueLocation,
        eventlocationImage: eventlocationImage ?? this.eventlocationImage,
      );

  factory EvenetDetailsModel.fromJson(Map<String, dynamic> json) =>
      EvenetDetailsModel(
        event: json["Event"].toString(),
        date: json["Date"].toString(),
        time: json["Time"].toString(),
        venue: json["Venue"].toString(),
        branch: json["Branch"].toString(),
        venueLocation: json["VenueLocation"].toString(),
        eventlocationImage: json["EventlocationImage"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "Event": event,
        "Date": date,
        "Time": time,
        "Venue": venue,
        "Branch": branch,
        "VenueLocation": venueLocation,
        "EventlocationImage": eventlocationImage,
      };
}
