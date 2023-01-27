
import 'dart:convert';

import 'package:sece_event_calendar/model/calendar_event.dart';


BaseQuestResponse baseQuestResponseFromJson<T>(String str) => BaseQuestResponse.fromJson(json.decode(str));

String baseQuestResponseToJson<T>(BaseQuestResponse data) => json.encode(data.toJson());

class BaseQuestResponse<T> {
  BaseQuestResponse({
    this.result,
    this.code,
    this.success,
    this.error,
    this.value,
  });

  String? result;
  int? code;
  bool? success;
  String? error;
  List<CalendarEvent>? value;

  factory BaseQuestResponse.fromJson(Map<String, dynamic> json) => BaseQuestResponse(
    result: json["result"],
    code: json["code"],
    success: json["success"],
    error: json["error"],
    value: List<CalendarEvent>.from(json["value"].map((x) => calendarEventFromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "code": code,
    "success": success,
    "error": error,
    "value": value,
  };
}
