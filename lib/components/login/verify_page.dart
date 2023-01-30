import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sece_event_calendar/dls/custombutton.dart';

import 'login_page.dart';


class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  OtpFieldController otpFieldController = OtpFieldController();
  var otpField="";
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
            const Center(
              child: Padding(
                padding:  EdgeInsets.only(top: 24),
                child: Text(
                  "Verify EMAIL",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20
                  ),
                ),
              ),
            ),
            const Center(
              child: Padding(padding: EdgeInsets.only(top: 24),
                child: Text(
                  "Enter your 6-digit OTP sent to your Email",
                  textAlign:TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16
                  ),
                ),
              ),
            ),
            Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: OTPTextField(
                    controller: otpFieldController,
                    length: 6,
                    fieldStyle: FieldStyle.box,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 4,right: 4),
                    textFieldAlignment: MainAxisAlignment.center,
                    fieldWidth: 48,
                    onChanged: (pin){
                      debugPrint("Onchange $pin");
                    },
                    onCompleted: (pin){
                      otpField = pin.toString();
                      debugPrint("OnComplete $pin");
                    },
                  ),
                )
            ),
            Padding(padding:const EdgeInsets.only(top: 52),
              child: DlsButton(text: "VERIFY", onPressed: (){
                //todo: Api for verifying code
              }),),
            Padding(padding:const EdgeInsets.only(top: 32),
                child: GestureDetector(
                    onTap: (){
                      Navigator.pushAndRemoveUntil<void>(
                        context,
                        MaterialPageRoute<void>(builder: (BuildContext context) => const LoginPage()),
                        ModalRoute.withName("/"),
                      );
                    },
                    child: SizedBox(
                        width: double.maxFinite,
                        height: MediaQuery.of(context).size.height/2,
                        child:  const Align(alignment: Alignment.bottomCenter,child: Text(
                          "<Back to Login",
                          style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              color: Colors.grey,
                              fontFamily: "Cabin"
                          ),
                        ),)
                    )))
          ],
        ),
      )],
    ));
  }
}
