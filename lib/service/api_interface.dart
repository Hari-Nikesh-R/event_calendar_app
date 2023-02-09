
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sece_event_calendar/components/home/home_page.dart';
import 'package:sece_event_calendar/utils/urls.dart';
import 'package:sece_event_calendar/utils/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/calendar_event.dart';
import '../model/userdetail.dart';
import '../utils/constants.dart';

class ApiInterface{
  Future<String?> registerUser(UserDetail userDetail) async{
    String mailMessage = "";
    var client = Client();
    try{
      var response = await client.post(Uri.parse("$AUTHENTICATION_URL/register"),headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },body: userDetailToJson(userDetail)
      );
      if(response.statusCode == 200)
        {
          Map<String, dynamic>? map = json.decode(response.body);
          mailMessage = map?["value"];
          return mailMessage;
        }
      else if(response.statusCode == 500)
        {
          // todo: dialog for internal server error
        }
    }
    catch(e){
      debugPrint(e.toString());
    }
    return mailMessage;

  }

  Future<String> authenticate(String email, String password) async
  {
    String token = "";
    var client = Client();
    try{
      var response =await client.post(Uri.parse("$AUTHENTICATION_URL/authenticate"),headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },body: json.encode({
        "username":email,
        "password":password
      }));
      if(response.statusCode==200) {
        Map<String, dynamic>? map = json.decode(response.body);
        token = map?["token"];
        return token;
      }
      else if(response.statusCode ==401) {
        return "false";
      }
    }
    catch(e){
      debugPrint(e.toString());
    }
    return token;
  }

  Future<List<CalendarEvent>?> getAllEvents() async{
      List<CalendarEvent> eventList = [];
      var client = Client();
      try{
        final prefs =await SharedPreferences.getInstance();
        var token = "Bearer ${prefs.getString(TOKEN)}";
        var response =await client.get(Uri.parse("$EVENT_BACKEND_URL/events/all"),headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "Authorization": token
        });
        if(response.statusCode == 200){
          Map<String, dynamic>? map = json.decode(response.body);
          List<dynamic>? res = map?["value"];
          res?.forEach((element) {
            eventList.add(calendarEventFromJsonWithDecode(element));
          });
          return eventList;
        }
        else if(response.statusCode == 401){
          //todo: Handle refresh token
        }

      }
      catch(e) {
      debugPrint(e.toString());
    }
    return eventList;
  }

  Future<String?> verifyRegistrationCode(UserDetail userDetail, String code) async{
    String registered = "";
    var client = Client();
    try {
      var response = await client.post(
          Uri.parse("$AUTHENTICATION_URL/register/verify?code=$code"),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
          }, body: userDetailToJson(userDetail));
      if (response.statusCode == 200) {
        Map<String, dynamic>? map = json.decode(response.body);
        registered = map?["value"];
        return registered;
      }
      else if (response.statusCode == 500) {
        //todo: Handle Internal error with dialog
      }
      return registered;
    }
    catch(e)
    {
      debugPrint(e.toString());
    }
    return null;

  }
  
  Future<UserDetail?> getUserDetails() async{
    var client  = Client();
    try {
      UserDetail userDetail;
      final prefs = await SharedPreferences.getInstance();
      var token = "Bearer ${prefs.getString(TOKEN)}";
      var response = await client.get(Uri.parse("$AUTHENTICATION_URL/user/info"), headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        "Authorization": token
      });
      if (response.statusCode == 200) {
        Map<String, dynamic>? map = json.decode(response.body);
        bool success = map?["success"];
        if (success) {
          userDetail = userDetailFromJsonDecode(map?["value"]);
          return userDetail;
        }
        else {
          //todo: Log and Handle errors.
        }
      }
      else if (response.statusCode == 401) {
        //todo: refresh Token
      }

    }
    catch(e)
    {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<CalendarEvent?> addEvent(CalendarEvent calendarEvent) async{
    var client = Client();
    try{
      final prefs = await SharedPreferences.getInstance();
      var token = "Bearer ${prefs.getString(TOKEN)}";
      var response = await client.post(Uri.parse("$EVENT_BACKEND_URL/events/add"),headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        "Authorization": token
      },body:
           json.encode({
             "title":calendarEvent.title.toString(),
             "description":calendarEvent.description.toString(),
             "startHour":calendarEvent.startHour?.toInt(),
             "endHour":calendarEvent.endHour?.toInt(),
             "startMinute":calendarEvent.startMinute?.toInt(),
             "endMinute":calendarEvent.endMinute?.toInt(),
             "eventStartDate":calendarEvent.eventStartDate?.toIso8601String(),
             "eventEndDate":calendarEvent.eventEndDate?.toIso8601String(),
             "location":calendarEvent.location.toString(),
             "department":calendarEvent.department.toString(),
             "eventType":""
           }));
      if(response.statusCode == 200) {
        Map<String, dynamic>? map = json.decode(response.body);
        bool success = map?["success"];
        if(success) {
          CalendarEvent res = calendarEventFromJsonWithDecode(map?["value"]);
          debugPrint(res.toJson().toString());
          return res;
        }
        else{
          //todo: Log and Handle errors.
          String error = map?["error"];
          if(error.isNotEmpty) {
            calendarEvent.error = error;
          }
          return calendarEvent;
        }
        }
      else if(response.statusCode == 401)
        {
          //todo: refresh Token
        }
    }
    catch(e)
    {
      debugPrint(e.toString());
    }
    return null;
  }
}
