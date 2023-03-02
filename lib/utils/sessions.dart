import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class Sessions{
  static final Sessions _singleton = Sessions._internal();
  Sessions._internal();
  factory Sessions() {
    return _singleton;
   }

   bool loaderOverRelay = false;
   bool tokenRefreshed = false;

   Widget startLoader(BuildContext context) {
       return Container(
           color: Colors.white38,
           alignment: Alignment.center,
           child: const CircularProgressIndicator(
             valueColor: AlwaysStoppedAnimation<Color>(THEME_COLOR),
           )
       );
   }

}