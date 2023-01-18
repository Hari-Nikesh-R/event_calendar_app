import 'package:flutter/material.dart';
import 'package:sece_event_calendar/utils/colors.dart';


class DlsButton extends StatefulWidget {
  const DlsButton({super.key,required this.text, required this.onPressed});
  final String text;
  final VoidCallback? onPressed;

  @override
  State<DlsButton> createState() => _DlsButtonState();
}

class _DlsButtonState extends State<DlsButton> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width/3,
      height: 50,
    child: ElevatedButton(
      style: TextButton.styleFrom(
        backgroundColor: THEME_COLOR
      ),
      onPressed: widget.onPressed,
      child: Text(
      widget.text,
        style: const TextStyle(
          color:  Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16
        ),
    ),
    ));
  }
}
