import 'package:flutter/material.dart';
import 'package:sece_event_calendar/model/calendar_event.dart';
import 'package:sece_event_calendar/utils/utility.dart';

class EventDetailPage extends StatefulWidget {
  const EventDetailPage({super.key,this.event, required this.department});
  final CalendarEvent? event;
  final String department;

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:  [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
              image: AssetImage(
                Utility().setDepartmentBackGround(widget.department??"")
              ), fit: BoxFit.cover
            ),
          )),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
            ),
          )
        ],
      ),
    );
  }
}
