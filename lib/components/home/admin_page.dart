import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sece_event_calendar/dls/custombutton.dart';
import 'package:sece_event_calendar/model/authority.dart';
import 'package:sece_event_calendar/service/api_interface.dart';
import 'package:sece_event_calendar/utils/colors.dart';

import '../../utils/utility.dart';


class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  List<Authority>? authorityList;
  List<Authority>? searchList;
  TextEditingController searchField = TextEditingController();

  getAllUserAuthority() async{
    authorityList = await ApiInterface().getUserAuthority();
    setState(() {
      authorityList = authorityList;
    });
  }

  @override
  void initState() {
    getAllUserAuthority();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(Utility().tokenRefreshed){
      Utility().showRefreshDialog(context);
    }
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Stack(
        children: [
          Padding(padding: const EdgeInsets.all(24), child: TextFormField(
            controller: searchField,
            onChanged: (value){
              setState(() {
              });
            },
            decoration: InputDecoration(
              labelText: "Search email",
              filled: true,
              fillColor: Colors.white,
              suffixIcon: IconButton(
                onPressed: (){}, icon:const  Icon(Icons.search, color: Colors.black, size: 25,),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(
                  color: Colors.black
                )
              ),
              border:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
            color: Colors.black
        )
    )
            ),
          )),
          (authorityList!=null)?
          Padding(padding: const EdgeInsets.symmetric(vertical: 100), child: ListView.builder(itemCount:authorityList?.length, itemBuilder:  (context,index) {
            return UserListCard(authority: authorityList?[index]);
          })
          ):const Padding(padding: EdgeInsets.symmetric(vertical: 100)),
        ]
      )
    );
  }
}
class UserListCard extends StatefulWidget {
  const UserListCard({super.key, required this.authority});
  final Authority? authority;

  @override
  State<UserListCard> createState() => _UserListCardState();
}

class _UserListCardState extends State<UserListCard> {
  bool isAuthorized = false;
  String authorityRole = "ADMIN";
  Map<String,String> newAuthority = HashMap<String, String>();
  List<Authority>? updateAuthorityList = [];
  String? updateMessage;

  updateAuthority(bool authorized) async{
    debugPrint(widget.authority?.email??""+ " "+authorized.toString());
   updateMessage = await ApiInterface().updateAuthority(widget.authority?.email??"",authorized);
   debugPrint(updateMessage);
  }
  
  @override
  void initState() {
    isAuthorized = widget.authority?.authorized??false;
    if(isAuthorized){
      authorityRole = "ADMIN";
    }
    else{
      authorityRole = "USER";
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      child: Container(
        margin: const EdgeInsets.all(4),
        child: Padding(padding: const EdgeInsets.all(12), child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.authority?.email??""),
            Card(
              color: isAuthorized?THEME_COLOR:Colors.white,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24)
              ), child: Padding(padding: const EdgeInsets.all(12),child: GestureDetector(onTap: (){
                setState(() {
                  isAuthorized = !isAuthorized;
                  isAuthorized ? authorityRole = "ADMIN": authorityRole = "USER";
                  updateAuthority(isAuthorized);
                });
            },child:Text(authorityRole, style: TextStyle(
              color: isAuthorized?Colors.white:Colors.black))
            ),)
            )
          ],
        ),
      ),
    ));
  }
}

