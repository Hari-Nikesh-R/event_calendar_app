import 'package:flutter/material.dart';
import 'package:sece_event_calendar/dls/custombutton.dart';
import 'package:sece_event_calendar/dls/customedittext.dart';
import 'package:sece_event_calendar/dls/custominfobar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var isObscured = true;
  @override
  void initState() {
    isObscured = true;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                const Padding(padding: EdgeInsets.only(top: 12)),
                const Padding(padding: EdgeInsets.all(32), child:
                Center(child:
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 34,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                ))),
                const Text("Create an Account",style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),),
                const CustomInfoBar(message: "Only SECE email is Allowed!"),
                Row(
                  children: [
                      CustomEditText(hintText: "First Name*",width: MediaQuery.of(context).size.width/2.5),
                      CustomEditText(hintText: "Last Name*",width: MediaQuery.of(context).size.width/2.5),
                    ]
                ),
                const CustomEditText(hintText: "Email*"),
                const CustomEditText(hintText: "Phone Number*"),
                const CustomEditText(hintText: "Organization*"),
                Padding(padding: const EdgeInsets.all(16), child:
                TextFormField(
                  obscureText: isObscured,
                  decoration: InputDecoration(
                      hintText: "Password*",
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: IconButton(icon: isObscured?const Icon(Icons.visibility, color: Colors.black,) :
                      const Icon(Icons.visibility_off, color: Colors.black,),
                        onPressed: (){
                          setState(() {
                            isObscured = !isObscured;
                          });
                        },),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:const BorderSide(
                              color: Colors.black
                          )
                      )
                  ),
                )),
                Padding(padding: const EdgeInsets.only(top: 12),child:
                DlsButton(text: "Sign Up", onPressed: (){
                  //todo: Create API
                }))
              ],
            ),
          )
        ],
      ),
    );
  }
}
