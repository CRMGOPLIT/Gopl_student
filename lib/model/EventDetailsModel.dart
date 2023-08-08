// ignore: file_names
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
        event: json["Event"].toString(),
        date: json["Date"].toString(),
        time: json["Time"].toString(),
        venue: json["Venue"].toString(),
        branch: json["Branch"].toString(),
        venueLocation: json["VenueLocation"].toString(),
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
