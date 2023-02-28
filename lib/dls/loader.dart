import 'package:flutter/material.dart';
import '../utils/colors.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(THEME_COLOR),
          )
        ],
      ),
    );
  }
}
