import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/home/home_page.dart';
import '../model/calendar_event.dart';
import '../service/api_interface.dart';
import '../utils/sessions.dart';



class CustomCupertinoAlertDialog {
  BuildContext context;
  CalendarEvent calendarEvent;
  CustomCupertinoAlertDialog(this.context,this.calendarEvent,this.function);
  String? deletedEvent;
  String function;

  void deleteEventApi(CalendarEvent calendarEvent) async{
    deletedEvent = await ApiInterface().deleteEvent(calendarEvent).then((value){
      if(value?.contains("Deleted")??false){
          Navigator.pushAndRemoveUntil<void>(
            context,
            MaterialPageRoute<void>(builder: (BuildContext context) => const HomePage()),
            ModalRoute.withName("/"),
          );
      }
    });
  }

  actionButtonFunctionality(){

    switch(function){
      case "DELETE_EVENT":
        Sessions().loaderOverRelay = true;
        deleteEventApi(calendarEvent);
        break;
    }
  }

  showCupertinoDialog(String title, String content){
    showDialog(context: context, builder: (BuildContext context) =>
        CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            CupertinoDialogAction(child: TextButton(onPressed: () {
              Navigator.pop(context);
              actionButtonFunctionality();
            }, child: const Text("Yes"),)),
            CupertinoDialogAction(child: TextButton(onPressed: () {
              Navigator.pop(context);
            }, child: const Text("No"),))
          ],
        ));
  }
}
