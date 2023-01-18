import 'package:flutter/material.dart';


class CustomEditText extends StatefulWidget {
  const CustomEditText({super.key, required this.hintText, this.sufficeIcon});
  final String hintText;
  final Widget? sufficeIcon;

  @override
  State<CustomEditText> createState() => _CustomEditTextState();
}

class _CustomEditTextState extends State<CustomEditText> {
  @override
  Widget build(BuildContext context) {
    return  Padding(padding: const EdgeInsets.all(16), child:
    TextFormField(
      decoration: InputDecoration(
          hintText: widget.hintText,
          fillColor: Colors.white,
          filled: true,
          suffixIcon: widget.sufficeIcon,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:const BorderSide(
                  color: Colors.black
              )
          )
      ),
    ));
  }
}
