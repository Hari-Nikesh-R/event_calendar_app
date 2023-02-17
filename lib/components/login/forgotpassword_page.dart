import 'package:flutter/material.dart';
import 'package:sece_event_calendar/dls/customedittext.dart';

class EmailEntryPage extends StatefulWidget {
  const EmailEntryPage({Key? key}) : super(key: key);

  @override
  State<EmailEntryPage> createState() => _EmailEntryPageState();
}

class _EmailEntryPageState extends State<EmailEntryPage> {

  TextEditingController emailField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [

          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                CustomEditText(textField: emailField, hintText: "Email")
              ],
            ),
          )
        ],
      ),
    );
  }
}
