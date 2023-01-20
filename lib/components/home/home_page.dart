import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:sece_event_calendar/utils/colors.dart';
import 'package:sece_event_calendar/utils/constants.dart';

import 'event_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int view =1;
  String calendarView = WEEK_VIEW;
  Widget calendarIcon = const Icon(Icons.calendar_view_week);
  EventController eventController = EventController();
  bool toggleMenu = false;

  DateTime get _now => DateTime.now();

  @override
  void initState() {
    view = 1;
    calendarView = WEEK_VIEW;
    calendarIcon = const Icon(Icons.calendar_view_week);
    toggleMenu = false;
    final event1 =  CalendarEventData(
      date: _now,
      event:  "Joe's Birthday",
      title: "PO Meeting",
      description: "Today is project meeting.",
      startTime: DateTime(_now.year, _now.month, _now.day, 18, 30),
      endTime: DateTime(_now.year, _now.month, _now.day, 22),
    );
    final event2 =  CalendarEventData(
      date: _now,
      event:  "Joe's Birthday",
      title: "Project meeting",
      description: "Today is project meeting.",
      startTime: DateTime(_now.year, _now.month, _now.day, 2, 30),
      endTime: DateTime(_now.year, _now.month, _now.day, 5),
    );
    final event3 =  CalendarEventData(
      date: _now.subtract(Duration(days: 2)),
      startTime: DateTime(
          _now.add(Duration(days: 2)).year,
          _now.add(Duration(days: 2)).month,
          _now.add(Duration(days: 2)).day,
          10),
      endTime: DateTime(
          _now.subtract(Duration(days: 2)).year,
          _now.subtract(Duration(days: 2)).month,
          _now.subtract(Duration(days: 2)).day,
          12),
      event:"Chemistry Viva",
      title: "Chemistry Viva",
      description: "Today is Joe's birthday.",
    );
    eventController.add(event1);
    eventController.add(event2);
    eventController.add(event3);
    super.initState();
  }

  Widget decideCalendarView()
  {
    if (calendarView == WEEK_VIEW){
      return const WeekView(
        heightPerMinute: 1.2);
    }
    else if(calendarView == DAY_VIEW) {
      return const DayView(
        heightPerMinute: 1.2,
      );
    }
    else if(calendarView == MONTH_VIEW) {
      return const MonthView();
    }
    else{
      return const WeekView(
          heightPerMinute: 1.2
      );
    }

  }

  @override
  Widget build(BuildContext context) {
     return CalendarControllerProvider(
       controller: eventController,
       child:  MaterialApp(
         scrollBehavior: const ScrollBehavior().copyWith(
           dragDevices: {
             PointerDeviceKind.trackpad,
             PointerDeviceKind.mouse,
             PointerDeviceKind.touch,
           },
         ),
         home: Scaffold(
           floatingActionButton: FloatingActionButton(onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context) =>const EventPage()));
             },
             backgroundColor: THEME_COLOR,
               child: const Icon(Icons.add,color: Colors.white)
           ),
           body: Stack(
             children: [
                decideCalendarView(),
                Align(alignment: Alignment.bottomLeft, child:
                    Padding(padding: const EdgeInsets.all(16),child:
                        Row(
                          children: [
                      FloatingActionButton(backgroundColor: THEME_COLOR,onPressed: (){
                        setState(() {
                          toggleMenu = !toggleMenu;
                        });
                        },child: const Icon(Icons.menu)),
                           const Padding(padding: EdgeInsets.only(right: 12)),
                            Visibility(
                                visible: toggleMenu,
                                child:
                            FloatingActionButton(backgroundColor: THEME_COLOR,onPressed: (){
                                if(view%3 == 0) {
                                    setState(() {
                                      calendarView = WEEK_VIEW;
                                      calendarIcon = const Icon(Icons.calendar_view_week);
                                    });
                                  }
                                else if(view%3 == 1){
                                  setState(() {
                                    calendarView = DAY_VIEW;
                                    calendarIcon = const Icon(Icons.calendar_view_day);
                                  });
                                }
                                else if(view%3 == 2){
                                  setState(() {
                                    calendarView = MONTH_VIEW;
                                    calendarIcon = const Icon(Icons.calendar_month);
                                  });
                                }
                                setState(() {
                                  view++;
                                });
                              },child: calendarIcon)),
                            const Padding(padding: EdgeInsets.only(right: 12)),
                            Visibility(visible:toggleMenu,
                                child:
                            FloatingActionButton(backgroundColor: THEME_COLOR,onPressed: (){
                            },child: const Icon(Icons.person_outline))),
                          ]
                        )),),
               // Align(alignment: Alignment.centerRight, child:
               // Padding(padding: const EdgeInsets.all(16),child:
               // Column(
               //   mainAxisAlignment: MainAxisAlignment.end,
               //     children: [
               //       FloatingActionButton(backgroundColor: THEME_COLOR,onPressed: (){
               //       },child: const Icon(Icons.menu)),
               //       const Padding(padding: EdgeInsets.all(12)),
               //       FloatingActionButton(backgroundColor: THEME_COLOR,onPressed: (){
               //       },child: const Icon(Icons.calendar_month)),
               //       const Padding(padding: EdgeInsets.all(12)),
               //       FloatingActionButton(backgroundColor: THEME_COLOR,onPressed: (){
               //       },child: const Icon(Icons.person_outline)),
               //       Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/10))
               //     ]
               // )),)

             ],
           )
         ),
       ),
     );
  }
}
