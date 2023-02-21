
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sece_event_calendar/components/home/home_page.dart';
import 'package:sece_event_calendar/model/authority.dart';
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

  Future<String?> updateAuthority(String email, bool authorized) async{
    var client = Client();
    try{
      final prefs = await SharedPreferences.getInstance();
      var token = "Bearer ${prefs.getString(TOKEN)}";
      var response =await client.put(Uri.parse("$AUTHENTICATION_URL/user/authority"),headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        "Authorization": token
      },body: authorityToJson(Authority(email: email, authorized: authorized)));
      if(response.statusCode == 200){
        Map<String, dynamic>? map = json.decode(response.body);
        if(map?["success"]){
          return "UPDATED SUCCESSFULLY";
        }
        debugPrint(map.toString());
      }
      else if(response.statusCode == 401){
        //todo: implement refresh token
      }
    }
    catch(e)
    {
      debugPrint(e.toString());
    }
    return "NOT UPDATED";
  }

  Future<String> authenticate(String email, String password) async
  {
    String token = "";
    var client = Client();
    try{
      final prefs = await SharedPreferences.getInstance();
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
        prefs.setString(TOKEN, token);
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

  Future<String?> changePassword(String password) async{
    String verificationMessage;
    var client = Client();
    try {
      final prefs = await SharedPreferences.getInstance();
      var response = await client.put(
          Uri.parse("$AUTHENTICATION_URL/user/change/password"),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
          }, body: json.encode({
        "email": prefs.get("Email"),
        "password":password
      }));
      if (response.statusCode == 200) {
        Map<String, dynamic>? map = json.decode(response.body);
        verificationMessage = map?["value"];
        return verificationMessage;
      }
      else if(response.statusCode == 401){
        // todo: Refresh dialog
      }
      else if (response.statusCode == 500) {
        //todo: Handle Internal error with dialog
      }
    }
    catch(e)
    {
      debugPrint(e.toString());
    }
    return null;
  }
  
  Future<bool?> verifyEmail(String email) async{
    bool registered = false;
    var client = Client();
    try {
      var response = await client.post(
          Uri.parse("$MAIL_URL/admin/forgot-password/$email"),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
          });
      if (response.statusCode == 200) {
          return json.decode(response.body);
      }
      else if(response.statusCode == 401){
        // todo: Refresh dialog
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
  Future<String?> verifyForgotPasswordCode(String? email, String code) async{
    String registered = "";
    var client = Client();
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("ForgetPasswordCode", code);
      var response = await client.post(
          Uri.parse("$MAIL_URL/verify/$email/$code"),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
          });
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

  Future<bool> isAuthorizedUser() async{
    var client = Client();
    try{
      final prefs = await SharedPreferences.getInstance();
      var token = "Bearer ${prefs.getString(TOKEN)}";
      var response = await client.get(Uri.parse("$AUTHENTICATION_URL/user/is-authorized"), headers: {
      "Accept": "application/json",
      "content-type": "application/json",
      "Authorization": token
      });
      if(response.statusCode == 200) {
        Map<String, dynamic>? map = json.decode(response.body);
        bool success = map?["success"];
        return success;
      }
      else if(response.statusCode == 401){
        // todo: refresh the token
      }
      else if(response.statusCode == 500){
        //todo: Show dialog box;
      }
    }
    catch(e){
     debugPrint(e.toString());
    }
    return false;

  }

  Future<UserDetail?> updateProfile(UserDetail userDetail) async{
    var client = Client();
    try{
      UserDetail detail;
      final prefs = await SharedPreferences.getInstance();
      var token = "Bearer ${prefs.getString(TOKEN)}";
      var response = await client.put(Uri.parse("$AUTHENTICATION_URL/user/update/profile"), headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        "Authorization": token
      }, body: userDetailToJson(userDetail));
      if (response.statusCode == 200) {
        Map<String, dynamic>? map = json.decode(response.body);
        bool success = map?["success"];
        if (success) {
          detail = userDetailFromJsonDecode(map?["value"]);
          return detail;
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
  
  Future<List<Authority>?> getUserAuthority() async{
    var client = Client();
     List<Authority> authority = [];
    try {
      final prefs = await SharedPreferences.getInstance();
      var token = "Bearer ${prefs.getString(TOKEN)}";
      var response = await client.get(
          Uri.parse("$AUTHENTICATION_URL/user/getAllUser"), headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        "Authorization": token
      });
      if (response.statusCode == 200) {
        Map<String, dynamic>? map = json.decode(response.body);
        bool success = map?["success"];
        if (success) {
          List<dynamic>? res = map?["value"];
          res?.forEach((element) {
            authority.add(authorityFromJsonWithDecode(element));
          });
          return authority;
        }
      }
      else if(response.statusCode == 401) {
        // todo: refresh token
      }
    }
    catch(e){
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
  Future<CalendarEvent?> getCalendarDetail(String title, String description) async{
    var client = Client();
    try{
      final prefs = await SharedPreferences.getInstance();
      var token = "Bearer ${prefs.getString(TOKEN)}";
      var response = await client.get(Uri.parse("$EVENT_BACKEND_URL/events/get?title=$title&description=$description"),headers: {
      "Accept": "application/json",
      "content-type": "application/json",
      "Authorization": token
      });
      if(response.statusCode == 200) {
        Map<String, dynamic>? map = json.decode(response.body);
        bool success = map?["success"];
        if(success) {
          CalendarEvent res = calendarEventFromJsonWithDecode(map?["value"]);
          debugPrint(res.toJson().toString());
          return res;
        }
        }
      else if(response.statusCode == 401){
        //todo: Handle refresh token
      }
    }
    catch(e){
      debugPrint(e.toString());
    }
  }
  Future<String?> deleteEvent(CalendarEvent calendarEvent) async{
    var client = Client();
    try{
      final prefs = await SharedPreferences.getInstance();
      var token = "Bearer ${prefs.getString(TOKEN)}";
      var response = await client.delete(Uri.parse("$EVENT_BACKEND_URL/events/delete?id=${calendarEvent.eventId}"),headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        "Authorization": token
      });
      if(response.statusCode == 200) {
        Map<String, dynamic>? map = json.decode(response.body);
        bool success = map?["success"];
        if(success) {
          return map?["value"];
        }
      }
      else if(response.statusCode == 401){
        //todo: Handle refresh token
      }
    }
    catch(e){
      debugPrint(e.toString());
    }
    return null;
  }

  Future<CalendarEvent?> addEvent(CalendarEvent calendarEvent) async {
    var client = Client();
    try {
      final prefs = await SharedPreferences.getInstance();
      var token = "Bearer ${prefs.getString(TOKEN)}";
      var response = await client.post(
          Uri.parse("$EVENT_BACKEND_URL/events/add"), headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        "Authorization": token
      }, body:
      json.encode({
        "title": calendarEvent.title.toString(),
        "description": calendarEvent.description.toString(),
        "startHour": calendarEvent.startHour?.toInt(),
        "endHour": calendarEvent.endHour?.toInt(),
        "startMinute": calendarEvent.startMinute?.toInt(),
        "endMinute": calendarEvent.endMinute?.toInt(),
        "eventStartDate": calendarEvent.eventStartDate?.toIso8601String(),
        "eventEndDate": calendarEvent.eventEndDate?.toIso8601String(),
        "location": calendarEvent.location.toString(),
        "department": calendarEvent.department.toString(),
        "eventType": ""
      }));
      if (response.statusCode == 200) {
        Map<String, dynamic>? map = json.decode(response.body);
        bool success = map?["success"];
        if (success) {
          CalendarEvent res = calendarEventFromJsonWithDecode(map?["value"]);
          debugPrint(res.toJson().toString());
          return res;
        }
        else {
          //todo: Log and Handle errors.
          String error = map?["error"];
          if (error.isNotEmpty) {
            calendarEvent.error = error;
          }
          return calendarEvent;
        }
      }
      else if (response.statusCode == 401) {
        //todo: refresh Token
      }
    }
    catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
    Future<String?> editEvent(CalendarEvent? calendarEvent) async{
      var client = Client();
      try{
        final prefs = await SharedPreferences.getInstance();
        var token = "Bearer ${prefs.getString(TOKEN)}";
        var response = await client.put(Uri.parse("$EVENT_BACKEND_URL/events/modify"),headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "Authorization": token
        },body:
        json.encode({
          "createdBy":calendarEvent?.createdBy.toString(),
          "created": calendarEvent?.created?.toIso8601String(),
          "eventId":calendarEvent?.eventId.toString(),
          "title":calendarEvent?.title.toString(),
          "description":calendarEvent?.description.toString(),
          "startHour":calendarEvent?.startHour?.toInt(),
          "endHour":calendarEvent?.endHour?.toInt(),
          "startMinute":calendarEvent?.startMinute?.toInt(),
          "endMinute":calendarEvent?.endMinute?.toInt(),
          "eventStartDate":calendarEvent?.eventStartDate?.toIso8601String(),
          "eventEndDate":calendarEvent?.eventEndDate?.toIso8601String(),
          "location":calendarEvent?.location.toString(),
          "department":calendarEvent?.department.toString(),
          "eventType":calendarEvent?.eventType.toString()
        }));
        if(response.statusCode == 200) {
          Map<String, dynamic>? map = json.decode(response.body);
          bool success = map?["success"];
          if(success) {
            return map?["value"];
          }
          else{
            //todo: Log and Handle errors.
            String error = map?["error"];
            if(error.isNotEmpty) {
              return error;
            }
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
