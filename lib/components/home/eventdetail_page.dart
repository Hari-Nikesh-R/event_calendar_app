import 'package:flutter/material.dart';
import 'package:sece_event_calendar/components/home/event_page.dart';
import 'package:sece_event_calendar/components/home/home_page.dart';
import 'package:sece_event_calendar/dls/customcartview.dart';
import 'package:sece_event_calendar/dls/customdialog.dart';
import 'package:sece_event_calendar/dls/customeventicon.dart';
import 'package:sece_event_calendar/model/calendar_event.dart';
import 'package:sece_event_calendar/service/api_interface.dart';
import 'package:sece_event_calendar/utils/utility.dart';

class EventDetailPage extends StatefulWidget {
  const EventDetailPage({super.key, this.title, this.description, required this.department});
  final String? title;
  final String? description;
  final String department;

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  String monthIntToString(int? month){
    switch(month){
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
      default:
        return "";
    }
  }
  String formatDate(DateTime? dateTime){
    return "${dateTime?.day} ${monthIntToString(dateTime?.month)} ${dateTime?.year}";
  }
  CalendarEvent? event;
  getCalendarDetail(String title, String description, String department) async{
    event = await ApiInterface().getCalendarDetail(title,description);
    setState(() {
        event = event;
      });
  }
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      getCalendarDetail(widget.title??"", widget.description??"", widget.department);
    });
    super.initState();
  }

  
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
            Navigator.pushAndRemoveUntil<void>(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => const HomePage()),
              ModalRoute.withName("/home_page"),
            );
          }, child: const CustomEventIcon(iconResource: Icons.close)),
          Align(alignment: Alignment.topRight, child: GestureDetector(
            onTap: (){
    CustomCupertinoAlertDialog(context,event??CalendarEvent(),"DELETE_EVENT"
              ).showCupertinoDialog("Delete","Do you want to delete this event");
            },
           child: Padding(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width/7),child:const CustomEventIcon(iconResource: Icons.delete,)),
          )),
          Align(alignment: Alignment.topRight,
          child: GestureDetector(
              onTap:(){
                //todo: Edit event page
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  EventPage(event: event,)));
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
                  CustomCardView(title: "Event Title", data: event?.title??""),
                  CustomCardView(title: "Venue", data: event?.location??""),
                 CustomCardView(title: "Description", data: event?.description??""),
                   CustomNestedCardView(title: "Conducting department", nestedCardContent: event?.department??""),
                   CustomNestedCardView(title: "Event starts at", nestedCardContent: "${event?.startHour.toString().padLeft(2,'0')}:${event?.startMinute.toString().padLeft(2,'0')}"??"",description: formatDate(event?.eventStartDate)??"",),
                   CustomNestedCardView(title: "Event ends at", nestedCardContent: "${event?.endHour.toString().padLeft(2,'0')}:${event?.endMinute.toString().padLeft(2,'0')}"??"",description: formatDate(event?.eventEndDate)??""),
                 CustomCardView(title: "Created by", data: event?.createdBy??""),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
