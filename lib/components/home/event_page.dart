import 'package:flutter/material.dart';
import 'package:sece_event_calendar/dls/custombutton.dart';
import 'package:sece_event_calendar/dls/customedittext.dart';
import 'package:sece_event_calendar/dls/customtext.dart';
import 'package:sece_event_calendar/utils/colors.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {

  bool notifyAll = true;

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
                  const CustomEditText(hintText: "Title*",sufficeIcon: Icon(Icons.title, color: Colors.black,size: 25,)),
                  Container(
                    margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                    child:
                  TextField(
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
                  const CustomEditText(hintText: "Announcement",sufficeIcon: Icon(Icons.announcement, color: Colors.black,size: 25,)),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Padding(padding: EdgeInsets.all(16), child: Icon(Icons.access_time, color: Colors.black, size: 30,)),
                            const Text("Day, Date", style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            ),),
                            Padding(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/2.5)),
                           const Text("Time", style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),)
                          ],
                        ),
                        Row(
                          // todo: Date picker and Time Picker
                        ),
                        Row(
                          // todo: Date picker and Time Picker
                        )
                      ],
                    ),
                  ))),
                  const CustomEditText(hintText: "Add Location", sufficeIcon: Icon(Icons.location_on, color: Colors.black,size: 25,),),
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
                  Center(
                    child: DlsButton(
                      text: "Save",
                      onPressed: (){},
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
