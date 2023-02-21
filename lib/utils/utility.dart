import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sece_event_calendar/dls/custombutton.dart';
import 'package:sece_event_calendar/service/api_interface.dart';
import 'package:sece_event_calendar/utils/colors.dart';

import 'constants.dart';

class Utility{
  static final Utility _singleton = Utility._internal();
  Utility._internal();
  factory Utility() {
    return _singleton;
  }

  bool tokenRefreshed = false;

  fetchRefreshToken() async{
    await ApiInterface().getRefreshToken();
  }

  String setDepartmentBackGround(String department) {
    switch (department) {
      case CCE:
        return "assets/eventbg/ccebg.png";
      case ECE:
        return "assets/eventbg/ecebg.png";
      case CSE:
        return "assets/eventbg/csebg.png";
      case MECH:
        return "assets/eventbg/mechbg.png";
      case PLACEMENT:
        return "assets/eventbg/placementbg.png";
      case EEE:
        return "assets/eventbg/eeebg.png";
      case ADMIN:
        return "assets/eventbg/placementbg.png";
      case TRAINING:
        return "assets/eventbg/trainingbg.png";
      default:
        return "assets/eventbg/trainingbg.png";
    }
  }

  Color setDepartmentColor(String selectedDepartment){
    switch(selectedDepartment){
      case CCE:
        return  Colors.purpleAccent;
      case ECE:
        return Colors.blue;
      case CSE:
        return Colors.lightGreenAccent;
      case MECH:
        return  Colors.orange;
      case PLACEMENT:
        return  Colors.yellow;
      case EEE:
        return Colors.teal;
      case ADMIN:
        return Colors.cyanAccent;
      case TRAINING:
        return Colors.redAccent;
      default:
        return THEME_COLOR;
    }
  }


  String getDepartmentColor(Color color)
  {
    if(color == Colors.purpleAccent)
      {
        return CCE;
      }
    else if(color == Colors.blue)
      {
        return ECE;
      }
    else if(color == Colors.lightGreenAccent){
      return CSE;
    }
    else if(color == Colors.orange){
      return MECH;
    }
    else if(color == Colors.yellow){
      return PLACEMENT;
    }
    else if(color == Colors.teal){
      return EEE;
    }
    else if(color == Colors.cyanAccent){
      return ADMIN;
    }
    else if(color == Colors.redAccent){
      return TRAINING;
    }
    else{
      return "RANDOM";
    }
  }

  Future<Widget> showRefreshDialog(BuildContext context) async{
    return await showDialog(context: context, builder: (BuildContext context) =>
        SizedBox(
            width: 200,
            height: 200,
            child: Padding(padding:const EdgeInsets.all(24),child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("title"),
                Text("Description"),
                DlsButton(text: "Refresh", onPressed: (){
                  Utility().tokenRefreshed = false;
                  Navigator.pop(context);
                  (context as Element).reassemble();
                })
              ],
            ),
            )));

  }
}


