import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sece_event_calendar/dls/loader.dart';

class Sessions{
  static final Sessions _singleton = Sessions._internal();
  Sessions._internal();
  factory Sessions() {
    return _singleton;
   }

   startLoader(BuildContext context) {
        showDialog(context: context, builder: (BuildContext context)=> const Loader());
   }

   stopLoader(BuildContext context) {
      Navigator.pop(context);
   }
}