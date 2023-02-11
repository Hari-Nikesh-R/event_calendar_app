import 'package:flutter/material.dart';
import 'package:sece_event_calendar/utils/colors.dart';


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

class CustomNestedCardView extends StatelessWidget {
  const CustomNestedCardView({super.key, required this.title, this.description, required this.nestedCardContent});
  final String title;
  final String? description;
  final String nestedCardContent;

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
                child: Padding(padding: const EdgeInsets.all(12),child:Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text(title, style:  const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black
                      ),),
                      const SizedBox(
                        height: 4,
                      ),
                        Visibility(visible: description?.isNotEmpty??false,child: Text(description ?? "", style: const TextStyle(

                        ),))

                    ]),
                  Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(44)
                      ),
                      child:  Padding(padding:const EdgeInsets.all(10), child:Text(nestedCardContent, style:const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                      ),),
                      ))]),
                ))));
  }
}

