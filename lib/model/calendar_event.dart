import 'dart:convert';


CalendarEvent calendarEventFromJson(String str) => CalendarEvent.fromJson(json.decode(str));

String calendarEventToJson(CalendarEvent data) => json.encode(data.toJson());

CalendarEvent calendarEventFromJsonWithDecode(Map<String, dynamic> json) => CalendarEvent.fromJson(json);

class CalendarEvent {
  CalendarEvent({
    required this.eventId,
    required this.createdBy,
    this.modifiedBy,
    required this.status,
    required this.title,
    required this.description,
    required this.startHour,
    required this.endHour,
    required this.startMinute,
    required this.endMinute,
    required this.eventStartDate,
    required this.eventEndDate,
    this.profile,
    required this.created,
    this.updated,
    required this.location,
    required this.notifyAll,
    required this.eventType,
  });

  String eventId;
  String createdBy;
  dynamic modifiedBy;
  String status;
  String title;
  String description;
  int startHour;
  int endHour;
  int startMinute;
  int endMinute;
  DateTime eventStartDate;
  DateTime eventEndDate;
  dynamic profile;
  DateTime created;
  dynamic updated;
  String location;
  bool notifyAll;
  String eventType;

  factory CalendarEvent.fromJson(Map<String, dynamic> json) => CalendarEvent(
    eventId: json["eventId"],
    createdBy: json["createdBy"],
    modifiedBy: json["modifiedBy"],
    status: json["status"],
    title: json["title"],
    description: json["description"],
    startHour: json["startHour"],
    endHour: json["endHour"],
    startMinute: json["startMinute"],
    endMinute: json["endMinute"],
    eventStartDate: DateTime.parse(json["eventStartDate"]),
    eventEndDate: DateTime.parse(json["eventEndDate"]),
    profile: json["profile"],
    created: DateTime.parse(json["created"]),
    updated: json["updated"],
    location: json["location"],
    notifyAll: json["notifyAll"],
    eventType: json["eventType"],
  );

  Map<String, dynamic> toJson() => {
    "eventId": eventId,
    "createdBy": createdBy,
    "modifiedBy": modifiedBy,
    "status": status,
    "title": title,
    "description": description,
    "startHour": startHour,
    "endHour": endHour,
    "startMinute": startMinute,
    "endMinute": endMinute,
    "eventStartDate": eventStartDate.toIso8601String(),
    "eventEndDate": eventEndDate.toIso8601String(),
    "profile": profile,
    "created": created.toIso8601String(),
    "updated": updated,
    "location": location,
    "notifyAll": notifyAll,
    "eventType": eventType,
  };
}
