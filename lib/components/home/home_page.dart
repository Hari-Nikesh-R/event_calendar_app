import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:sece_event_calendar/dls/custombutton.dart';
import 'package:sece_event_calendar/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  EventController eventController = EventController();
  @override
  void initState() {
    final event = CalendarEventData(
      date: DateTime(2023, 1, 1),
      event: "Event 1", title: 'Title',
    );
    eventController.add(event);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return CalendarControllerProvider(
       controller: eventController,
       child:  MaterialApp(
         home: Scaffold(
           floatingActionButton: FloatingActionButton(onPressed: (){},
             backgroundColor: THEME_COLOR,
               child: const Icon(Icons.add,color: Colors.white)
           ),
           body: Stack(
             children: [
                 const WeekView(
                   heightPerMinute: 1.2,
                 ),
                Align(alignment: Alignment.bottomLeft, child:
                    Padding(padding: const EdgeInsets.all(16),child:
                FloatingActionButton(backgroundColor: THEME_COLOR,onPressed: (){},child: const Icon(Icons.menu))))
             ],
           )
         ),
       ),
     );
  }
}
