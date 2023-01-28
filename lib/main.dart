import 'dart:js';

import 'package:flutter/material.dart';
import 'package:sece_event_calendar/components/home/event_page.dart';

import 'components/home/home_page.dart';
import 'components/login/login_page.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        '/login' :(context) =>const LoginPage(),
        '/home' :(context) => const HomePage(),
        '/event': (context) => const EventPage()
      }
    // initialRoute: 'home',
    // routes: {
    //   'home' :(context) =>const HomePage()
    // }
  ));
}
