import 'package:flutter/material.dart';
import 'package:sece_event_calendar/dls/custombutton.dart';
import 'package:sece_event_calendar/dls/customtextform.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
   TextEditingController userNameField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/home/profilebg.png"), fit: BoxFit.fill
                  )
              ),
            ),
           Align(alignment: Alignment.bottomCenter,child:
           SizedBox(
             width: MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height/1.5,
           child:
           SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            height:  MediaQuery.of(context).size.height,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/5)),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: DlsButton(text: "Log out", onPressed: (){
                                    // todo: Set preference as false and navigate to log in page
                                  })
                                )
                              ],
                            ),
                          ),
                        ),

                      ],
                    )
                ))),
            Padding(padding: const EdgeInsets.only(top: 100), child: Card(
                margin: const EdgeInsets.only(left: 24, right: 24),
                shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                ),
                color: Colors.white,
                child: Stack(children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: const Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(padding: EdgeInsets.all(42),child: Text("USER NAME",style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ))),
                      )
                  ),
                  const Padding(padding: EdgeInsets.all(16),child:Align(alignment: Alignment.topRight,
                      child:
                   Icon(Icons.edit)
                  ))
    ],)

            )),
             Align(
              alignment: Alignment.topCenter,
                child: Container(
                decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(blurRadius: 10, color: Colors.grey, spreadRadius: 5)],
                ),
                child: const CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage('https://www.tutorialkart.com/img/hummingbird.png')
            ))),

          ],
        )
    );
  }
}
