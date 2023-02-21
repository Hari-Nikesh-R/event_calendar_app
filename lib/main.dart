
import 'package:flutter/material.dart';
import 'package:sece_event_calendar/components/home/event_page.dart';
import 'package:sece_event_calendar/components/login/forgotpassword_page.dart';
import 'package:sece_event_calendar/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/home/home_page.dart';
import 'components/login/login_page.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs =await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool(ISLOGIN)??false;
  String pageRoute = isLoggedIn ? '/home_page':'/login_page';
  Widget app = MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: pageRoute,
      routes: {
        '/login_page' :(context) => const LoginPage(),
        '/home_page' :(context) => const HomePage(),
        '/event_page': (context) => const EventPage(),
        '/change_password_page' : (context) => const ChangePasswordPage()
      }
  );
  runApp(app);

}
