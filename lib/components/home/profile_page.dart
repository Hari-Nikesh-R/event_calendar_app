import 'package:flutter/material.dart';
import 'package:sece_event_calendar/components/login/login_page.dart';
import 'package:sece_event_calendar/dls/custombutton.dart';
import 'package:sece_event_calendar/dls/customcartview.dart';
import 'package:sece_event_calendar/dls/customedittext.dart';
import 'package:sece_event_calendar/dls/customeventicon.dart';
import 'package:sece_event_calendar/model/userdetail.dart';
import 'package:sece_event_calendar/service/api_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import '../../utils/utility.dart';
import 'home_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController userNameField = TextEditingController();

  TextEditingController firstNameField = TextEditingController();
  TextEditingController lastNameField = TextEditingController();
  TextEditingController emailField = TextEditingController();
  TextEditingController phoneNumberField = TextEditingController();
  TextEditingController organizationField = TextEditingController();
  TextEditingController passwordField = TextEditingController();

  bool isObscured = true;


  updateProfile(UserDetail detail) async{
    userDetail = await ApiInterface().updateProfile(detail);
    setState(() {
      userDetail = userDetail;
    });
  }

  UserDetail? userDetail;
  getUserDetails() async{
    userDetail = await ApiInterface().getUserDetails();
    setState(() {
      userDetail = userDetail;
    });
  }
  @override
  void initState() {

    setState(() {
      getUserDetails();
    });
    super.initState();
  }

  setUserDetails(){
    firstNameField.text = userDetail?.firstName??"";
    lastNameField.text = userDetail?.lastName??"";
    emailField.text = userDetail?.email??"";
    phoneNumberField.text = userDetail?.phoneNumber??"";
    organizationField.text = userDetail?.organization??"";
  }

  Future<void> logout() async{
    final prefs =await SharedPreferences.getInstance();
    prefs.clear();
    prefs.setBool(ISLOGIN,false);
    setState(() {
      Navigator.pushAndRemoveUntil<void>(
        context,
        MaterialPageRoute<void>(builder: (BuildContext context) => const LoginPage()),
        ModalRoute.withName("/"),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    if(Utility().tokenRefreshed){
      Utility().showRefreshDialog(context);
    }
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/home/profilebg.png"),
                  fit: BoxFit.fill)),
        ),
        GestureDetector(
          onTap: (){
            Navigator.pushAndRemoveUntil<void>(
                context,
                MaterialPageRoute<void>(
                builder: (BuildContext context) => const HomePage()),
            ModalRoute.withName("/home_page"));
          },
          child:const CustomEventIcon(iconResource: Icons.close)
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.5,
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height /
                                                10)),
                                 CustomCardView(
                                    title: "Phone Number", data: userDetail?.phoneNumber??"-"),
                                 CustomCardView(
                                    title: "Organization", data: userDetail?.organization??"-"),
                                 CustomCardView(
                                    title: "Email",
                                    data: userDetail?.email??"-"),
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: DlsButton(
                                        text: "Log out",
                                        onPressed: () {
                                         logout();
                                        }))
                              ],
                            ),
                          ),
                        ),
                      ],
                    )))),
        Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Card(
                elevation: 4,
                margin: const EdgeInsets.only(left: 24, right: 24),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                color: Colors.white,
                child: SizedBox(
                    height: 200,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            child:  Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                  padding:const EdgeInsets.all(42),
                                  child: Text("${userDetail?.firstName} ${userDetail?.lastName}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ))),
                            )),
                         GestureDetector(
                          onTap: (){
                            setUserDetails();
                            showModalBottomSheet(shape: const RoundedRectangleBorder(
                              borderRadius:BorderRadius.only(
                                topRight: Radius.circular(40),
                              ),
                            ), backgroundColor: Colors.white,
                            context: context, builder: (context){
                              return  Padding(padding: const EdgeInsets.only(top: 20),
                              child:Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom+10),child: SingleChildScrollView(
                                physics:const BouncingScrollPhysics(),
                                child: Column(
                                children: <Widget>[
                                  const Padding(padding: EdgeInsets.only(top: 24)),
                                  const Text("Edit Profile", style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  )),
                                  CustomEditText(textField: firstNameField, hintText: "First Name"),
                                  CustomEditText(textField: lastNameField, hintText: "Last Name"),
                                  CustomEditText(textField: phoneNumberField, hintText:"Phone number"),
                                  CustomEditText(textField: organizationField, hintText: "Organization"),
                                // Container(
                                //     margin: const EdgeInsets.all(16),
                                //     child: TextFormField(
                                //       controller: passwordField,
                                //       maxLines: 1,
                                //       obscureText: isObscured,
                                //       decoration: InputDecoration(
                                //           hintText: 'password',
                                //           fillColor: Colors.white,
                                //           filled: true,
                                //           suffixIcon:IconButton(icon: isObscured?const Icon(Icons.visibility, color: Colors.black,) :
                                //           const Icon(Icons.visibility_off, color: Colors.black,),
                                //             onPressed: (){
                                //               setState(() {
                                //                 isObscured = !isObscured;
                                //               });
                                //             },),
                                //           enabledBorder: OutlineInputBorder(
                                //               borderRadius: BorderRadius.circular(12),
                                //               borderSide:const BorderSide(
                                //                   color: Colors.blue
                                //               )
                                //           )
                                //       ),
                                //     )),
                                  Center(child: DlsButton(text: "Save", onPressed: (){
                                    UserDetail detail = UserDetail(firstName: firstNameField.text, lastName: lastNameField.text, organization: organizationField.text, phoneNumber: phoneNumberField.text);
                                    updateProfile(detail);
                                    Navigator.pop(context);
                                  },),)
                                ],
                              ))));
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Align(
                                alignment: Alignment.topRight,
                                child: Icon(Icons.edit))))
                      ],
                    )))),
        Align(
            alignment: Alignment.topCenter,
            child: Padding(
                padding: const EdgeInsets.all(32),
                child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10, color: Colors.grey, spreadRadius: 5)
                      ],
                    ),
                    child: const CircleAvatar(
                        radius: 75,
                        backgroundImage: NetworkImage(
                            'https://www.tutorialkart.com/img/hummingbird.png'))))),
      ],
    ));
  }
}
