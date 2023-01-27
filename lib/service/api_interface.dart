
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sece_event_calendar/utils/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/calendar_event.dart';
import '../utils/constants.dart';

class ApiInterface{
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

  Future<CalendarEvent?> addEvent() async{
    CalendarEvent calendarEvent;
    var client = Client();
    try{
      final prefs = await SharedPreferences.getInstance();
      var token = "Bearer ${prefs.getString(TOKEN)}";
      var response = client.post(Uri.parse("$EVENT_BACKEND_URL/events/add"),headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        "Authorization": token
      },body: {
        //todo: Send body as response
      });

    }
    catch(e)
    {
      debugPrint(e.toString());
    }
  }
}
