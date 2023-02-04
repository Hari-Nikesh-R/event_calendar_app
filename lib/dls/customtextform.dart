import 'package:flutter/material.dart';

class CustomTextForm extends StatefulWidget {
  const CustomTextForm({super.key, required this.controller, required this.editable, required this.hint});
  final TextEditingController controller;
  final bool editable;
  final String hint;

  @override
  State<CustomTextForm> createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(16),
        child: TextFormField(
          controller: widget.controller,
          readOnly: !widget.editable,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: widget.hint,
              fillColor: Colors.white,
              filled: true,
              border:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:const BorderSide(
              color: Colors.blue
    ))
              ,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:const BorderSide(
                      color: Colors.blue
                  )
              )
          ),
        ));
  }
}
