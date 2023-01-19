import 'package:flutter/material.dart';

import '../utils/colors.dart';


class CustomInfoBar extends StatefulWidget {
  const CustomInfoBar({super.key, required this.message});
  final String message;

  @override
  State<CustomInfoBar> createState() => _CustomInfoBarState();
}

class _CustomInfoBarState extends State<CustomInfoBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: THEME_COLOR,
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [BoxShadow(
                spreadRadius: 0.5
            )]
        ),
        child: Row(
          children: [
            const Padding(padding: EdgeInsets.all(4), child:
            Icon(Icons.info, color: Colors.white,size: 35,)),
            Text(
              widget.message,
              maxLines: 1,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16
              ),
            )
          ],
        ));
  }
}
