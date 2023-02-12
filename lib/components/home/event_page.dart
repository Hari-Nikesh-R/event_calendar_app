import 'package:flutter/material.dart';
import 'package:sece_event_calendar/components/home/eventdetail_page.dart';
import 'package:sece_event_calendar/components/home/home_page.dart';
import 'package:sece_event_calendar/dls/custombutton.dart';
import 'package:sece_event_calendar/dls/customedittext.dart';
import 'package:sece_event_calendar/service/api_interface.dart';
import 'package:sece_event_calendar/utils/colors.dart';
import 'package:sece_event_calendar/utils/constants.dart';

import '../../model/calendar_event.dart';
import '../../utils/utility.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key,this.event});
  final CalendarEvent? event;

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  TextEditingController eventTitle = TextEditingController();
  TextEditingController eventDescription = TextEditingController();
  TextEditingController eventAnnouncement = TextEditingController();
  TextEditingController eventLocation = TextEditingController();
  bool notifyAll = true;
  bool notifyIndividual = true;
  String currentDate = "-";
  String endDate = "-";
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();
  late String selectedDepartment;
  String selectedVenue = "Respective Department";
  bool editEventFlag = false;

  List<DropdownMenuItem<String>> dropdownItems = const [
    DropdownMenuItem(value: "CCE", child: Text(CCE)),
    DropdownMenuItem(value: "CSE", child: Text(CSE)),
    DropdownMenuItem(value: "ECE", child: Text(ECE)),
    DropdownMenuItem(value: "EEE", child: Text(EEE)),
    DropdownMenuItem(value: "MECH", child: Text(MECH)),
    DropdownMenuItem(value: "PLACEMENT", child: Text(PLACEMENT)),
    DropdownMenuItem(value: "ADMIN", child: Text(ADMIN)),
    DropdownMenuItem(value: "TRAINING", child: Text(TRAINING)),
  ];

  List<String> venues = ["Placement Lab","Auditorium 1","Auditorium 2","IT center","Placement Cell","Conference Hall","Ignite GroundFloor","Respective Department"];
  var homePage;

  String currentTime = "-";
  String endTime = "-";
  late CalendarEvent? addedEvent;
  String? editedEventMessage ="";

  saveEvent(CalendarEvent calendarEvent) async{
     addedEvent = await ApiInterface().addEvent(calendarEvent).whenComplete(() =>  setState(() {
       if(calendarEvent.error?.isEmpty??true) {
         Navigator.pushAndRemoveUntil<void>(
           context,
           MaterialPageRoute<void>(
               builder: (BuildContext context) => const HomePage()),
           ModalRoute.withName("/home_page"),
         );
       }
       else {
        debugPrint(calendarEvent.error.toString());
         if (calendarEvent.error?.contains("duplicate event") ?? false) {
           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
               content: Text("Already event created in that Venue"
               )));
         }
       }
     }));
  }

  editEvent(CalendarEvent? calendarEvent) async{
    editedEventMessage = await ApiInterface().editEvent(calendarEvent).whenComplete(() =>  setState(() {
      if(calendarEvent?.error?.isEmpty??true) {
        Navigator.pushAndRemoveUntil<void>(
          context,
          MaterialPageRoute<void>(
              builder: (BuildContext context) => EventDetailPage(title: calendarEvent?.title, description: calendarEvent?.description, department: calendarEvent?.department??"")),
          ModalRoute.withName("/home_page"),
        );
      }
      else {
        debugPrint(calendarEvent?.error.toString());
        if (calendarEvent?.error?.contains("duplicate event") ?? false) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Already event created in that Venue"
              )));
        }
      }
    }));
  }

  Future<void> selectStartTime() async{
    final TimeOfDay? pickedS = await showTimePicker(
        context: context,
        initialTime: selectedStartTime, builder: ( context, child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      );});

    if (pickedS != null && pickedS != selectedStartTime ) {
      setState(() {
        selectedStartTime = pickedS;
        if(widget.event!=null){
          widget.event?.startHour = pickedS.hour;
          widget.event?.startMinute = pickedS.minute;
        }
        currentTime = selectedStartTime.hour.toString().length == 1?
        "0${selectedStartTime.hour}:${selectedStartTime.minute.toString().padLeft(2,'0')}":
        "${selectedStartTime.hour}:${selectedStartTime.minute.toString().padLeft(2,'0')}";
        setState(() {
          if(selectedStartTime.hour > selectedEndTime.hour) {
            selectedEndTime = selectedStartTime;
            if(widget.event!=null){
              widget.event?.endHour = selectedEndTime.hour;
              widget.event?.endMinute = selectedEndTime.minute;
            }
            endTime = selectedEndTime.hour.toString().length == 1?
            "0${selectedEndTime.hour}:${selectedEndTime.minute.toString().padLeft(2,'0')}":
            "${selectedEndTime.hour}:${selectedEndTime.minute.toString().padLeft(2,'0')}";
            changeSelectedDateTime();
          }
        });
      });
    }
  }

  Future<void> selectEndTime() async{
    final TimeOfDay? pickedS = await showTimePicker(
        context: context,
        initialTime: selectedEndTime, builder: ( context, child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      );});

    if (pickedS != null && pickedS != selectedEndTime ) {
      setState(() {
        selectedEndTime = pickedS;
        if(widget.event!=null) {
            widget.event?.endHour = pickedS.hour;
            widget.event?.endMinute = pickedS.minute;
          }
        endTime = selectedEndTime.hour.toString().length == 1?
        "0${selectedEndTime.hour}:${selectedEndTime.minute.toString().padLeft(2,'0')}":
        "${selectedEndTime.hour}:${selectedEndTime.minute.toString().padLeft(2,'0')}";
      });
    }
    compareStartEndTime();
  }

  void selectStartDate() {
    showDatePicker(
      context: context,
      initialDate: selectedStartDate!,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    ).then((value) {
      setState(() {
        if(value!=null) {
          selectedStartDate = value;
          if(widget.event!=null) {
              widget.event?.eventStartDate = value;
            }
          currentDate = selectedStartDate?.day.toString().length == 1?
          "0${selectedStartDate?.day
              .toString()}-${selectedStartDate?.month.toString().padLeft(
              2, '0')}-${selectedStartDate?.year.toString().padLeft(2, '0')}":
          "${selectedStartDate?.day
              .toString()}-${selectedStartDate?.month.toString().padLeft(
              2, '0')}-${selectedStartDate?.year.toString().padLeft(2, '0')}";
          setState(() {
            if(selectedStartDate!.isAfter(selectedEndDate!)){ selectedEndDate = selectedStartDate;
              if(widget.event!=null) {
                  widget.event?.eventEndDate = selectedEndDate;
                }
            changeSelectedDateTime();
            }
          });

        }
        if(currentDate == "null-null-null")
        {
          currentDate = "";
        }
      });
    });
  }

  void selectEndDate() {
    showDatePicker(
      context: context,
      initialDate: selectedEndDate!,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    ).then((value) {
      setState(() {
        if(value!=null) {
          selectedEndDate = value;
          if(widget.event!=null){
            widget.event?.eventEndDate = value;
          }
          endDate = selectedEndDate?.day.toString().length == 1? "0${selectedEndDate?.day
              .toString()}-${selectedEndDate?.month.toString().padLeft(
              2, '0')}-${selectedEndDate?.year.toString().padLeft(2, '0')}":
          "${selectedEndDate?.day
              .toString()}-${selectedEndDate?.month.toString().padLeft(
              2, '0')}-${selectedEndDate?.year.toString().padLeft(2, '0')}";
        }
        if(endDate == "null-null-null")
        {
          currentDate = "";
        }
        compareStartEndDate();
      });
    });
  }

  void changeSelectedDateTime(){
    selectedEndDate = selectedStartDate;
    selectedEndTime = selectedStartTime;
    if(widget.event!=null){
      widget.event?.eventEndDate = selectedEndDate;
      widget.event?.endHour = selectedEndTime.hour;
      widget.event?.endMinute = selectedEndTime.minute;
    }
    endTime = selectedEndTime.hour.toString().length == 1?
    "0${selectedEndTime.hour}:${selectedEndTime.minute.toString().padLeft(2,'0')}":
    "${selectedEndTime.hour}:${selectedEndTime.minute.toString().padLeft(2,'0')}";
    endDate = selectedEndDate?.day.toString().length == 1? "0${selectedEndDate?.day
        .toString()}-${selectedEndDate?.month.toString().padLeft(
        2, '0')}-${selectedEndDate?.year.toString().padLeft(2, '0')}":
    "${selectedEndDate?.day
        .toString()}-${selectedEndDate?.month.toString().padLeft(
        2, '0')}-${selectedEndDate?.year.toString().padLeft(2, '0')}";
  }

  bool compareStartEndDate(){
    if(!selectedEndDate!.isAfter(selectedStartDate!)) {
      changeSelectedDateTime();
      return false;
    }
    return true;
  }

  bool compareStartEndTime(){
    if(selectedEndDate == selectedStartDate) {
        if(selectedEndTime.hour > selectedStartTime.hour) {
            return true;
          }
        else if(selectedEndTime.hour == selectedStartTime.hour) {
            if(selectedEndTime.minute > selectedStartTime.minute) {
                return true;
              }
            else{
              changeSelectedDateTime();
              return false;
            }
          }
        else{
          changeSelectedDateTime();
          return false;
        }
      }
    else{
      return true;
    }
  }

  void initializeTextController(CalendarEvent? calendar){
    eventTitle.text = calendar?.title??"";
    widget.event?.title = calendar?.title??"";
     eventDescription.text = calendar?.description??"";
     widget.event?.description = calendar?.description??"";
     eventAnnouncement.text = calendar?.eventType??"";
     widget.event?.eventType = calendar?.eventType??"";
     endDate = calendar?.eventEndDate?.day.toString().length == 1? "0${calendar?.eventEndDate?.day
         .toString()}-${calendar?.eventEndDate?.month.toString().padLeft(
         2, '0')}-${calendar?.eventEndDate?.year.toString().padLeft(2, '0')}":
     "${calendar?.eventEndDate?.day
         .toString()}-${calendar?.eventEndDate?.month.toString().padLeft(
         2, '0')}-${calendar?.eventEndDate?.year.toString().padLeft(2, '0')}";
    currentDate = calendar?.eventStartDate?.day.toString().length == 1?
    "0${calendar?.eventStartDate?.day
        .toString()}-${calendar?.eventStartDate?.month.toString().padLeft(
        2, '0')}-${calendar?.eventStartDate?.year.toString().padLeft(2, '0')}":
    "${calendar?.eventStartDate?.day
        .toString()}-${calendar?.eventStartDate?.month.toString().padLeft(
        2, '0')}-${calendar?.eventStartDate?.year.toString().padLeft(2, '0')}";
    selectedDepartment = calendar?.department??"";
    widget.event?.department = calendar?.department??"";
    selectedVenue = calendar?.location??"";
    eventLocation.text = calendar?.location??"";
    widget.event?.location = calendar?.location??"";
    currentTime = calendar?.startHour.toString().length == 1?
    "0${calendar?.startHour}:${calendar?.startMinute.toString().padLeft(2,'0')}":
    "${calendar?.startHour}:${calendar?.startMinute.toString().padLeft(2,'0')}";
    endTime = calendar?.endHour.toString().length == 1?
    "0${calendar?.endHour}:${calendar?.endMinute.toString().padLeft(2,'0')}":
    "${calendar?.endHour}:${calendar?.endMinute.toString().padLeft(2,'0')}";
  }

  @override
  void initState() {
    selectedEndTime = TimeOfDay.now();
    selectedStartTime = TimeOfDay.now();
    selectedStartDate = DateTime.now();
    selectedEndDate = DateTime.now();
    currentTime = selectedStartTime.hour.toString().length == 1?
    "0${selectedStartTime.hour}:${selectedStartTime.minute.toString().padLeft(2,'0')}":
    "${selectedStartTime.hour}:${selectedStartTime.minute.toString().padLeft(2,'0')}";
    endTime = selectedEndTime.hour.toString().length == 1?
    "0${selectedEndTime.hour}:${selectedEndTime.minute.toString().padLeft(2,'0')}":
    "${selectedEndTime.hour}:${selectedEndTime.minute.toString().padLeft(2,'0')}";
    currentDate = selectedStartDate?.day.toString().length == 1?
    "0${selectedStartDate?.day
        .toString()}-${selectedStartDate?.month.toString().padLeft(
        2, '0')}-${selectedStartDate?.year.toString().padLeft(2, '0')}":
    "${selectedStartDate?.day
        .toString()}-${selectedStartDate?.month.toString().padLeft(
        2, '0')}-${selectedStartDate?.year.toString().padLeft(2, '0')}";
    endDate = selectedEndDate?.day.toString().length == 1? "0${selectedEndDate?.day
        .toString()}-${selectedEndDate?.month.toString().padLeft(
        2, '0')}-${selectedEndDate?.year.toString().padLeft(2, '0')}":
    "${selectedEndDate?.day
        .toString()}-${selectedEndDate?.month.toString().padLeft(
        2, '0')}-${selectedEndDate?.year.toString().padLeft(2, '0')}";
    if(widget.event!=null) {
      initializeTextController(widget.event);
      editEventFlag = true;

    }
    else{
      selectedDepartment = "CCE";
    }
    super.initState();
  }

  Widget setupVenueSelected() {
    return SizedBox(
      width: 300,
    height: 250,
        child:
     ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
            return  ListTile(
            title: Text(venues[index]),
              onTap: (){
                selectedVenue = venues[index];
                eventLocation.text = selectedVenue;
                Navigator.pop(context);
              },
          );
        },
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                   Padding(padding: const EdgeInsets.all(12),child: IconButton(icon:const Icon(Icons.close, size: 30,color: Colors.black),
                    onPressed: (){
                        Navigator.pop(context);
                  },)),
                  CustomEditText(hintText: "Title*",sufficeIcon: const Icon(Icons.title, color: Colors.black,size: 25,), textField: eventTitle),
                  Container(
                    margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                    child:
                  TextField(
                    controller: eventDescription,
                    maxLines: 6,
                    decoration: InputDecoration(
                      labelText: "Description*",
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                          borderSide:const BorderSide(
                              color: Colors.blue
                          )
                      )
                    )
                  )),
                   CustomEditText(hintText: "Announcement",sufficeIcon: const Icon(Icons.announcement, color: Colors.black,size: 25,), textField: eventAnnouncement,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/8),child: const Text("Organizing Department*", style: TextStyle(
                      fontSize: 16,color: Colors.black,
                       fontWeight: FontWeight.bold
                    ),)),
                      const Padding(padding: EdgeInsets.only(left: 12,bottom: 12)),
                      Row(
                      children: [
                      Padding(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/7.5),
                          child:Card(
                            elevation: 12,
                            child: Padding(padding: const EdgeInsets.only(left: 8,right: 8),child: DropdownButton(
                              value: selectedDepartment,
                              items: dropdownItems, onChanged: (String? value) {
                              setState(() {
                                selectedDepartment = value??"CCE";
                                if(widget.event!=null) {
                                    widget.event?.department = selectedDepartment;
                                  }
                              });
                            },
                            )
                            ),
                          )),
                         Padding(padding: const EdgeInsets.symmetric(horizontal: 12),child: CircleAvatar(
                          backgroundColor: Utility().setDepartmentColor(selectedDepartment),
                          maxRadius: 15,
                        ))
                      ])
                    ],
                  )
                    ,
                  Padding(padding: const EdgeInsets.all(16), child:
                      Container(
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          ),
                          child:
                  Card(
                    elevation: 12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    color: Colors.white,
                    child: Padding(padding: const EdgeInsets.all(8),child:Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(padding: EdgeInsets.all(6), child: Icon(Icons.access_time, color: Colors.black, size: 30,)),
                        Row(
                          children: [
                            const Padding(padding: EdgeInsets.all(6), child: Text("From: ")),
                            GestureDetector(
                                onTap: (){
                                  setState(() {
                                    selectStartDate();
                                  });
                                },
                                child:Card(
                                  elevation: 12,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Padding(padding:const EdgeInsets.all(12),
                                      child: Text(
                                        currentDate,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontSize: 18
                                        ),
                                        textAlign: TextAlign.center,
                                      )),
                                )),
                            GestureDetector(
                                onTap: (){
                                  setState(() {
                                    selectStartTime();
                                  });
                                },
                                child: Padding(padding:const EdgeInsets.only(left: 32),child:Card(
                                  elevation: 12,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Padding(padding:const EdgeInsets.all(12),
                                      child: Row(
                                        children: [
                                          Text(
                                            currentTime,
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontSize: 18
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const Padding(padding: EdgeInsets.only(right: 6)),
                                          const Icon(Icons.more_time_sharp,size: 25, color: Colors.black,)
                                        ],
                                      )),
                                ))),

                          ],
                        ),
                        Row(
                          children: [
                            const Padding(padding: EdgeInsets.all(16), child: Text("To:")),
                            GestureDetector(
                                onTap: (){
                                  setState(() {
                                    selectEndDate();
                                  });
                                },
                                child:Card(
                                  elevation: 12,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Padding(padding:const EdgeInsets.all(12),
                                      child: Text(
                                        endDate,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontSize: 18
                                        ),
                                        textAlign: TextAlign.center,
                                      )),
                                )),
                            GestureDetector(
                                onTap: (){
                                  setState(() {
                                    selectEndTime();
                                  });
                                },
                                child: Padding(padding:const EdgeInsets.only(left: 32),child:Card(
                                  elevation: 12,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Padding(padding:const EdgeInsets.all(12),
                                      child: Row(
                                        children: [
                                      Text(
                                        endTime,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontSize: 18
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                        const Padding(padding: EdgeInsets.only(right: 6)),
                                          const Icon(Icons.more_time_sharp,size: 25, color: Colors.black,)
                                        ],
                                      )
                                )))),

                          ],
                        )
                      ],
                    ),
                  )))),
                  Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(16),
                  child: TextFormField(
                  controller: eventLocation,
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Select Venue', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18
                            ),),
                            content: setupVenueSelected(),
                          );
                        });
                  },
                  readOnly: true,
                  maxLines: 1,
                  decoration: InputDecoration(
                  hintText: "Add Venue",
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: const Icon(Icons.arrow_drop_down,size: 25,),
                  enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:const BorderSide(
                  color: Colors.blue
                  )
                  )
                  ),
                  )),
                  Row(
                    children: [
                       const Padding(padding: EdgeInsets.only(right: 8)),
                      Checkbox(value: notifyAll, onChanged: (bool? value){
                          setState(() {
                            notifyAll = value!;
                          });
                      }),
                      const Text("Notify All", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),)
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     const Padding(padding: EdgeInsets.only(right: 8)),
                  //     Checkbox(value: notifyIndividual, onChanged: (bool? value){
                  //       setState(() {
                  //         notifyIndividual = value!;
                  //       });
                  //     }),
                  //     const Text("Notify before 5 minutes", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),)
                  //   ],
                  // ),
                  Center(
                    child: DlsButton(
                      text: "Save",
                      onPressed: (){
                        if(!editEventFlag) {
                          CalendarEvent calendarEvent = CalendarEvent(
                              title: eventTitle.text,
                              description: eventDescription.text,
                              startHour: selectedStartTime.hour,
                              endHour: selectedEndTime.hour,
                              startMinute: selectedStartTime.minute,
                              endMinute: selectedEndTime.minute,
                              eventStartDate: selectedStartDate,
                              eventEndDate: selectedEndDate,
                              location: eventLocation.text,
                              notifyAll: notifyAll,
                              department: selectedDepartment,
                              eventType: eventAnnouncement.text);
                          saveEvent(calendarEvent);
                          debugPrint("API success");
                        }
                        else{
                         // CalendarEvent calendarEvent = CalendarEvent(eventId: widget.event?.eventId, title: eventTitle.text, description: eventDescription.text, startHour: widget.event?.startHour, endHour: widget.event?.endHour, startMinute: widget.event?.startMinute, endMinute: widget.event?.endMinute, eventStartDate: widget.event?.eventStartDate, eventEndDate: widget.event?.eventEndDate, location: eventLocation.text, notifyAll: widget.event?.notifyAll, department: widget.event?.department, eventType: widget.event?.eventType);
                          CalendarEvent? calendarEvent = widget.event;
                          calendarEvent?.department = selectedDepartment;
                          calendarEvent?.title = eventTitle.text;
                          calendarEvent?.description = eventDescription.text;
                          calendarEvent?.location= eventLocation.text;
                          calendarEvent?.eventType = eventAnnouncement.text;
                          calendarEvent?.notifyAll = notifyAll;
                          editEvent(calendarEvent);
                          debugPrint("Edit Api Success");
                        }
                      },
                    ),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}
