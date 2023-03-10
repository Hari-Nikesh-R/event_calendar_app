import 'package:flutter/material.dart';
import 'package:sece_event_calendar/components/login/verify_page.dart';
import 'package:sece_event_calendar/dls/custombutton.dart';
import 'package:sece_event_calendar/dls/customedittext.dart';
import 'package:sece_event_calendar/dls/custominfobar.dart';
import 'package:sece_event_calendar/model/userdetail.dart';
import 'package:sece_event_calendar/service/api_interface.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  TextEditingController firstNameField = TextEditingController();
  TextEditingController lastNameField = TextEditingController();
  TextEditingController emailField = TextEditingController();
  TextEditingController phoneNumberField = TextEditingController();
  TextEditingController organizationField = TextEditingController();
  TextEditingController passwordField = TextEditingController();
  var isObscured = true;

  void registerUser(UserDetail userDetail) async{
      String? sendMainInfo = await ApiInterface().registerUser(userDetail);
      debugPrint(sendMainInfo.toString());
  }

  @override
  void initState() {
    isObscured = true;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
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
                      CustomEditText(hintText: "First Name*",width: MediaQuery.of(context).size.width/2.5, textField: firstNameField,),
                      CustomEditText(hintText: "Last Name*",width: MediaQuery.of(context).size.width/2.5,textField: lastNameField,),
                    ]
                ),
                 CustomEditText(hintText: "Email*",textField: emailField,),
                 CustomEditText(hintText: "Phone Number*",textField: phoneNumberField,),
                 CustomEditText(hintText: "Organization*", textField: organizationField,),
                Padding(padding: const EdgeInsets.all(16), child:
                TextFormField(
                  obscureText: isObscured,
                  controller: passwordField,
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
                              color: Colors.blue
                          )
                      )
                  ),
                )),
                Padding(padding: const EdgeInsets.only(top: 12),child:
                DlsButton(text: "Sign Up", onPressed: (){
                  if(emailField.text.contains("@sece.ac.in")) {
                    UserDetail userDetail = UserDetail(
                      email: emailField.text,
                      firstName: firstNameField.text,
                      lastName: lastNameField.text,
                      organization: organizationField.text,
                      phoneNumber: phoneNumberField.text,
                      password: passwordField.text,
                    );
                    registerUser(userDetail);
                    Navigator.push(context, MaterialPageRoute(builder: (
                        context) => VerifyPage(details: userDetail, isForgotPassword: false,)));
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Invalid email"
                        )));
                  }
                }))
              ],
            ),
          )
        ],
      ),
    );
  }
}
