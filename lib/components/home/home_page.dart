import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:sece_event_calendar/model/calendar_event.dart';
import 'package:sece_event_calendar/service/api_interface.dart';
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
    getAllEvent();
    view = 1;
    calendarView = WEEK_VIEW;
    calendarIcon = const Icon(Icons.calendar_view_week);
    toggleMenu = false;
    super.initState();
  }
  List<CalendarEvent>? allEvents;

  getAllEvent() async{
    allEvents = await ApiInterface().getAllEvents();
    setState(() {
      debugPrint(allEvents.toString());
      allEvents = allEvents;
      setEventInCalendar(allEvents);
    });
  }

  setEventInCalendar(List<CalendarEvent>? events){
    events?.forEach((event) {
      var createdEvent = CalendarEventData(
        date: event.eventStartDate!,
        event:  event.eventType,
        title: "${event.title}",
        description: "${event.description}",
        startTime: DateTime(event.eventStartDate!.year, event.eventStartDate!.month, event.eventStartDate!.day, event.startHour!, event.startMinute!),
        endTime: DateTime(event.eventEndDate!.year, event.eventEndDate!.month, event.eventEndDate!.day, event.endHour!, event.endMinute!),
      );
      eventController.add(createdEvent);
    });
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
           floatingActionButton: FloatingActionButton(heroTag: "create", onPressed: (){

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
                      FloatingActionButton(heroTag: "menu",backgroundColor: THEME_COLOR,onPressed: (){
                        setState(() {
                          toggleMenu = !toggleMenu;
                        });
                        },child: const Icon(Icons.menu)),
                           const Padding(padding: EdgeInsets.only(right: 12)),
                            Visibility(
                                visible: toggleMenu,
                                child:
                            FloatingActionButton(heroTag: "calendar",backgroundColor: THEME_COLOR,onPressed: (){
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
                            FloatingActionButton(heroTag:"profile",backgroundColor: THEME_COLOR,onPressed: (){
                            },child: const Icon(Icons.person_outline))),
                          ]
                        )),),
             ],
           )
         ),
       ),
     );
  }
}
