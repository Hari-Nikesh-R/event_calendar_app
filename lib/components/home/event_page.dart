import 'package:flutter/material.dart';
import 'package:sece_event_calendar/components/home/home_page.dart';
import 'package:sece_event_calendar/dls/custombutton.dart';
import 'package:sece_event_calendar/dls/customedittext.dart';
import 'package:sece_event_calendar/service/api_interface.dart';

import '../../model/calendar_event.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

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
  var homePage;

  String currentTime = "-";
  late Future<CalendarEvent?> addedEvent;

  saveEvent(CalendarEvent calendarEvent) async{
     addedEvent = ApiInterface().addEvent(calendarEvent);

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
        setState(() {
          if(selectedStartTime.hour > selectedEndTime.hour) {
            selectedEndTime = selectedStartTime;
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
          currentDate = selectedStartDate?.day.toString().length == 1?
          "0${selectedStartDate?.day
              .toString()}-${selectedStartDate?.month.toString().padLeft(
              2, '0')}-${selectedStartDate?.year.toString().padLeft(2, '0')}":
          "${selectedStartDate?.day
              .toString()}-${selectedStartDate?.month.toString().padLeft(
              2, '0')}-${selectedStartDate?.year.toString().padLeft(2, '0')}";
          setState(() {
            if(selectedStartDate!.isAfter(selectedEndDate!)){ selectedEndDate = selectedStartDate;
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

  @override
  void initState() {
    selectedEndTime = TimeOfDay.now();
    selectedStartTime = TimeOfDay.now();
    selectedStartDate = DateTime.now();
    selectedEndDate = DateTime.now();
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
    super.initState();
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
                                            selectedStartTime.hour.toString().length == 1?
                                            "0${selectedStartTime.hour}:${selectedStartTime.minute}":
                                            "${selectedStartTime.hour}:${selectedStartTime.minute}",
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
                                        selectedEndTime.hour.toString().length == 1?
                                        "0${selectedEndTime.hour}:${selectedEndTime.minute}":
                                        "${selectedEndTime.hour}:${selectedEndTime.minute}",
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
                  CustomEditText(hintText: "Add Location", sufficeIcon: const Icon(Icons.location_on, color: Colors.black,size: 25,),textField: eventLocation,),
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
                  Row(
                    children: [
                      const Padding(padding: EdgeInsets.only(right: 8)),
                      Checkbox(value: notifyIndividual, onChanged: (bool? value){
                        setState(() {
                          notifyIndividual = value!;
                        });
                      }),
                      const Text("Notify before 5 minutes", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),)
                    ],

                  ),
                  Center(
                    child: DlsButton(
                      text: "Save",
                      onPressed: (){
                        CalendarEvent calendarEvent = CalendarEvent(title: eventTitle.text, description: eventDescription.text, startHour: selectedStartTime.hour, endHour: selectedEndTime.hour, startMinute: selectedStartTime.minute, endMinute: selectedEndTime.minute, eventStartDate: selectedStartDate, eventEndDate: selectedEndDate, location: eventLocation.text, notifyAll: notifyAll);
                        saveEvent(calendarEvent);
                        setState(() {
                        Navigator.push(
                        context,
                         MaterialPageRoute(
                        builder: (context) =>  const HomePage()),
                          );
                        });
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