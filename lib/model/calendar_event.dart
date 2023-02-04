import 'dart:convert';


CalendarEvent calendarEventFromJson(String str) => CalendarEvent.fromJson(json.decode(str));

String calendarEventToJson(CalendarEvent data) => json.encode(data.toJson());

CalendarEvent calendarEventFromJsonWithDecode(Map<String, dynamic> json) => CalendarEvent.fromJson(json);

class CalendarEvent {


  CalendarEvent({
    this.eventId,
    this.createdBy,
    this.modifiedBy,
    this.status,
    this.title,
     this.description,
     this.startHour,
     this.endHour,
     this.startMinute,
     this.endMinute,
     this.eventStartDate,
     this.eventEndDate,
    this.profile,
     this.created,
    this.updated,
     this.location,
     this.notifyAll,
     this.eventType,
    this.department
  });

  String? eventId;
  String? createdBy;
  dynamic modifiedBy;
  String? status;
  String? department;
  String? title;
  String? description;
  int? startHour;
  int? endHour;
  int? startMinute;
  int? endMinute;
  DateTime? eventStartDate;
  DateTime? eventEndDate;
  dynamic profile;
  DateTime? created;
  dynamic updated;
  String? location;
  bool? notifyAll;
  String? eventType;

  factory CalendarEvent.fromJson(Map<String, dynamic> json) => CalendarEvent(
    eventId: json["eventId"],
    createdBy: json["createdBy"],
    modifiedBy: json["modifiedBy"],
    department: json["department"],
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
    "department": department,
    "title": title,
    "description": description,
    "startHour": startHour,
    "endHour": endHour,
    "startMinute": startMinute,
    "endMinute": endMinute,
    "eventStartDate": eventStartDate?.toIso8601String(),
    "eventEndDate": eventEndDate?.toIso8601String(),
    "profile": profile,
    "created": created?.toIso8601String(),
    "updated": updated,
    "location": location,
    "notifyAll": notifyAll,
    "eventType": eventType,
  };
}
