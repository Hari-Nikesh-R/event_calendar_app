import 'package:flutter/material.dart';


class CustomCardView extends StatelessWidget {
  const CustomCardView({super.key, required this.title, required this.data});
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(padding: const EdgeInsets.all(12),child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black
                  ),),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(data)
                ],
              )),
            )));
  }
}
