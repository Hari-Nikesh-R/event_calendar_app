import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sece_event_calendar/dls/customcartview.dart';
import 'package:sece_event_calendar/dls/customdialog.dart';
import 'package:sece_event_calendar/dls/customeventicon.dart';
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
          GestureDetector(onTap: (){
            Navigator.pop(context);
          }, child: const CustomEventIcon(iconResource: Icons.close)),
          Align(alignment: Alignment.topRight, child: GestureDetector(
            onTap: (){
              CustomCupertinoAlertDialog(context).showCupertinoDialog("Delete","Do you want to delete this event");
            },
           child: Padding(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width/7),child:const CustomEventIcon(iconResource: Icons.delete,)),
          )),
          Align(alignment: Alignment.topRight,
          child: GestureDetector(
              onTap:(){
                //todo: Edit event page
              },child: const CustomEventIcon(iconResource: Icons.edit,))),
           Padding(padding: const EdgeInsets.only(top: 80), child:
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)
                  ),
                  child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                //   child:
                // Container(
                //   decoration: const BoxDecoration(
                //     image: DecorationImage(
                //       image: AssetImage(
                //         ""
                //       ),fit: BoxFit.cover
                //     )
                //   ),
                // )
                   )),
                const CustomCardView(title: "Event Name", data: "Mech Event"),
                 const CustomCardView(title: "Venue", data: "Placement Lab"),
                const CustomCardView(title: "Description", data: "Hey this is a Good event"),
                  const CustomNestedCardView(title: "Conducting department", nestedCardContent: "MECH"),
                  const CustomNestedCardView(title: "Event starts at", nestedCardContent: "2020",description: "20 Feb 2020",),
                  const CustomNestedCardView(title: "Event ends at", nestedCardContent: "2020", description: "20 Feb 2020"),
                const CustomCardView(title: "Event Ends at", data: "20 Feb 2023"),
                const CustomCardView(title: "Created by", data: "Arun"),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
