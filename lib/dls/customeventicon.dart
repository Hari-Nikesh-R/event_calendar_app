import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomEventIcon extends StatelessWidget {
  const CustomEventIcon({super.key, required this.iconResource});
  final IconData iconResource;

  @override
  Widget build(BuildContext context) {
    return  Padding(padding:const EdgeInsets.all(24), child: CircleAvatar(
        maxRadius: 20,
        backgroundColor: THEME_COLOR,
        child:  Icon(iconResource, color: Colors.white,)));
  }
}
