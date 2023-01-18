import 'package:flutter/material.dart';

import 'components/home/home_page.dart';
import 'components/login/login_page.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login' :(context) =>const LoginPage()
      }
    // initialRoute: 'home',
    // routes: {
    //   'home' :(context) =>const HomePage()
    // }
  ));
}
