import 'dart:convert';

// List<EvenetDetailsModel> evenetDetailsModelFromJson(String str) =>
//     List<EvenetDetailsModel>.from(
//         json.decode(str).map((x) => EvenetDetailsModel.fromJson(x)));

// evenetDetailsModelToJson(List<EvenetDetailsModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EvenetDetailsModel {
  EvenetDetailsModel({
    required this.event,
    required this.date,
    required this.time,
    required this.venue,
    required this.branch,
    required this.venueLocation,
  });

  final String event;
  final String date;
  final String time;
  final String venue;
  final String branch;
  final String venueLocation;

  factory EvenetDetailsModel.fromJson(Map<String, dynamic> json) =>
      EvenetDetailsModel(
        event: json["Event"],
        date: json["Date"],
        time: json["Time"],
        venue: json["Venue"],
        branch: json["Branch"],
        venueLocation: json["VenueLocation"],
      );

  Map<String, dynamic> toJson() => {
        "Event": event,
        "Date": date,
        "Time": time,
        "Venue": venue,
        "Branch": branch,
        "VenueLocation": venueLocation,
      };
}
