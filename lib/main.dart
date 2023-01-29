
import 'package:flutter/material.dart';
import 'package:sece_event_calendar/components/home/event_page.dart';

import 'components/home/home_page.dart';
import 'components/login/login_page.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login_page',
      routes: {
        'login_page' :(context) => const LoginPage(),
        'home_page' :(context) => const HomePage(),
        'event_page': (context) => const EventPage()
      }
    // initialRoute: 'home',
    // routes: {
    //   'home' :(context) =>const HomePage()
    // }
  ));
}
