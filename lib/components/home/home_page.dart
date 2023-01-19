import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:sece_event_calendar/utils/colors.dart';
import 'package:sece_event_calendar/utils/constants.dart';

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

  @override
  void initState() {
    view = 1;
    calendarView = WEEK_VIEW;
    calendarIcon = const Icon(Icons.calendar_view_week);
    toggleMenu = false;
    final event = CalendarEventData(
      date: DateTime(2023, 1, 1),
      event: "Event 1", title: 'Title',
    );
    eventController.add(event);
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
         home: Scaffold(
           floatingActionButton: FloatingActionButton(onPressed: (){
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
