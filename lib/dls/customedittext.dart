import 'package:flutter/material.dart';


class CustomEditText extends StatefulWidget {
  const CustomEditText({super.key, required this.hintText, this.sufficeIcon, this.width});
  final String hintText;
  final Widget? sufficeIcon;
  final double? width;

  @override
  State<CustomEditText> createState() => _CustomEditTextState();
}

class _CustomEditTextState extends State<CustomEditText> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: widget.width,
    margin: const EdgeInsets.all(16),
    child: TextFormField(
      maxLines: 1,
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

class FillPageEditText extends StatefulWidget {
  const FillPageEditText({Key? key}) : super(key: key);

  @override
  State<FillPageEditText> createState() => _FillPageEditTextState();
}

class _FillPageEditTextState extends State<FillPageEditText> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

