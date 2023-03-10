import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sece_event_calendar/dls/custombutton.dart';
import 'package:sece_event_calendar/service/api_interface.dart';
import 'package:sece_event_calendar/utils/colors.dart';
import 'package:sece_event_calendar/utils/sessions.dart';

import 'constants.dart';

class Utility{
  static final Utility _singleton = Utility._internal();
  Utility._internal();
  factory Utility() {
    return _singleton;
  }

  fetchRefreshToken() async{
    await ApiInterface().getRefreshToken();
  }

  String setDepartmentBackGround(String department) {
    switch (department) {
      case CCE:
        return "$DEPARTMENT_PREFIX/ccebg.png";
      case ECE:
        return "$DEPARTMENT_PREFIX/ecebg.png";
      case CSE:
        return "$DEPARTMENT_PREFIX/csebg.png";
      case MECH:
        return "$DEPARTMENT_PREFIX/mechbg.png";
      case PLACEMENT:
        return "$DEPARTMENT_PREFIX/placementbg.png";
      case EEE:
        return "$DEPARTMENT_PREFIX/eeebg.png";
      case ADMIN:
        return "$DEPARTMENT_PREFIX/placementbg.png";
      case TRAINING:
        return "$DEPARTMENT_PREFIX/trainingbg.png";
      default:
        return "$DEPARTMENT_PREFIX/trainingbg.png";
    }
  }

  Color setDepartmentColor(String selectedDepartment){
    switch(selectedDepartment){
      case CCE:
        return Colors.purpleAccent;
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
      case AIDS:
        return Colors.lightGreen;
      case CSBS:
        return Colors.pinkAccent;
      case AIML:
        return Colors.deepOrangeAccent;
      case SLC:
        return Colors.lime;
      case IT:
        return Colors.purpleAccent;
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
    else if(color == Colors.lightGreen){
      return AIDS;
    }
    else if(color ==Colors.pinkAccent){
      return CSBS;
    }
    else if(color == Colors.deepOrangeAccent){
      return AIML;
    }
    else if(color == Colors.lime){
      return SLC;
    }
    else if(color == Colors.purpleAccent){
      return IT;
    }
    else{
      return "RANDOM";
    }
  }

  String getVenueImage(String venue) {
    switch(venue){
      case PLACEMENT_CELL:
        return "$VENUE_PREFIX/placement_cell.png";
      case AUDITORIUM_1:
        return "$VENUE_PREFIX/auditoriumi.png";
      case AUDITORIUM_2:
        return "$VENUE_PREFIX/auditoriumii.png";
      case IT_CENTER:
        return "$VENUE_PREFIX/itcenter.png";
      case CONFERENCE_HALL:
        return "$VENUE_PREFIX/conference_hall.png";
      case IGNITE_GROUND_FLOOR:
        return "$VENUE_PREFIX/ignite_center.jpeg";
      case RESPECTIVE_DEPARTMENT:
        return "$VENUE_PREFIX/department.png";
      case LIBRARY:
        return "$VENUE_PREFIX/library.png";
      case EEE_LAB:
        return "$VENUE_PREFIX/eee_lab.png";
      case IOT_LAB:
        return "$VENUE_PREFIX/iot_lab.png";
      case OPEN_AUDITORIUM:
        return "$VENUE_PREFIX/open_auditorium.jpg";
      case HCL:
        return "$VENUE_PREFIX/hcl.png";
      case WIPRO:
        return "$VENUE_PREFIX/wipro.jpg";
      case CODE_STUDIO:
        return "$VENUE_PREFIX/code_studio.jpg";
      case POWER_SIMULATION:
        return "$VENUE_PREFIX/power_stimulation.jpg";
      case PROJECT_LAB:
        return "$VENUE_PREFIX/project_lab.jpg";
      case BYTES_LAB:
        return "$VENUE_PREFIX/bytes_lab.jpg";
      case VIRTUSA:
        return "$VENUE_PREFIX/virtusa.jpg";
      case SYSTENIX:
        return "$VENUE_PREFIX/systenix.jpg";
      case ONE_CLOUD:
        return "$VENUE_PREFIX/one_cloud.jpg";
      case AWS:
        return "$VENUE_PREFIX/aws_lab.jpg";
      case ASPIRE_SYSTEM:
        return "$VENUE_PREFIX/aspire_system.jpg";
      default:
        return "assets/loader/round_loader.gif";
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
                  Navigator.pop(context);
                  (context as Element).reassemble();
                })
              ],
            ),
            )));

  }
}


