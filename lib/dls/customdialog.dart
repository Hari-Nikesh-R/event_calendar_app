import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCupertinoAlertDialog {
  BuildContext context;
  CustomCupertinoAlertDialog(this.context);

  showCupertinoDialog(String title, String content){
    showDialog(context: context, builder: (BuildContext context) =>
        CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            CupertinoDialogAction(child: TextButton(onPressed: () {
              //todo: Delete api
            }, child: const Text("Yes"),)),
            CupertinoDialogAction(child: TextButton(onPressed: () {
              Navigator.pop(context);
            }, child: const Text("No"),))
          ],
        ));
  }
}
