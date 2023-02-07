import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sece_event_calendar/utils/colors.dart';

import 'constants.dart';

class Utility{
  static final Utility _singleton = Utility._internal();
  Utility._internal();
  factory Utility() {
    return _singleton;
  }

  Color setDepartmentColor(String selectedDepartment){
    switch(selectedDepartment){
      case CCE:
        return Colors.purple;
      case CSE:
        return  Colors.blue;
      case MECH:
        return  Colors.orange;
      case PLACEMENT:
        return  Colors.yellow;
      case ECE:
        return  Colors.purpleAccent;
      case EEE:
        return Colors.greenAccent;
      case ADMIN:
        return Colors.cyanAccent;
      case TRAINING:
        return Colors.redAccent;
      default:
        return THEME_COLOR;
    }

  }

}