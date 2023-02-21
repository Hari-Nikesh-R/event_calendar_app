import 'package:flutter/material.dart';
import 'package:sece_event_calendar/components/login/verify_page.dart';
import 'package:sece_event_calendar/dls/custombutton.dart';
import 'package:sece_event_calendar/dls/customedittext.dart';
import 'package:sece_event_calendar/model/userdetail.dart';
import 'package:sece_event_calendar/service/api_interface.dart';

import '../../utils/constants.dart';

class EmailEntryPage extends StatefulWidget {
  const EmailEntryPage({Key? key}) : super(key: key);

  @override
  State<EmailEntryPage> createState() => _EmailEntryPageState();
}

class _EmailEntryPageState extends State<EmailEntryPage> {

  TextEditingController emailField = TextEditingController();


  verifyEmail() async{
     await ApiInterface().verifyEmail(emailField.text).then((value) {
       if(value??false){
         setState(() {
           Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyPage(details: UserDetail(email: emailField.text), isForgotPassword: true,)));
         });
       }
     });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(padding: const EdgeInsets.all(16), child:Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height,
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("FoRGoT PaSSwoRD", style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                )),
                const Padding(padding: EdgeInsets.only(top: 12),child: Text("Enter your registered email and we’ll send you OTP to reset password", style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ), textAlign: TextAlign.center,)),
                Padding(padding: const EdgeInsets.only(top: 12),child: CustomEditText(textField: emailField, hintText: "Email")),
                DlsButton(text: "Send", onPressed: (){
                  verifyEmail();
                })
              ],
            )),
          ))
    );
  }
}

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key, required this.email});
  final String? email;

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController passwordField = TextEditingController();
  TextEditingController confirmPasswordField = TextEditingController();
  bool isObscured = true;
  bool confirmPassObscured = true;
  String? verificationMessage;

  changePassword() async{
    verificationMessage = await ApiInterface().changePassword(widget.email,passwordField.text);
    if(verificationMessage == UPDATE_PASSWORD){
      setState(() {
        Navigator.pushNamedAndRemoveUntil(context, "/login_page", ModalRoute.withName('/'));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Password Updated"
            )));
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    isObscured = true;
    confirmPassObscured = true;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("ChANgE PaSSWorD", style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
              Container(
                  margin: const EdgeInsets.all(16),
                  child: TextFormField(
                      controller: passwordField,
                      obscureText: isObscured,
                      decoration: InputDecoration(
                          hintText: "Password",
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
                      ))),
            Container(
              margin: const EdgeInsets.all(16),
              child: TextFormField(
              controller: confirmPasswordField,
              obscureText: confirmPassObscured,
              decoration: InputDecoration(
                  hintText: "Confirm Password",
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: IconButton(icon: confirmPassObscured?const Icon(Icons.visibility, color: Colors.black,) :
                  const Icon(Icons.visibility_off, color: Colors.black,),
                    onPressed: (){
                      setState(() {
                        confirmPassObscured = !confirmPassObscured;
                      });
                    },),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:const BorderSide(
                          color: Colors.blue
                      )
                  )
              ))),DlsButton(text: "Save", onPressed: (){
                  changePassword();
              })
            ],
          ),
        ),
      ),
    );
  }
}

