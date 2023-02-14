import 'package:flutter/material.dart';
import 'package:sece_event_calendar/dls/custombutton.dart';
import 'package:sece_event_calendar/model/authority.dart';
import 'package:sece_event_calendar/service/api_interface.dart';
import 'package:sece_event_calendar/utils/colors.dart';


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
      searchList = authorityList;
    });
  }

  @override
  void initState() {
    getAllUserAuthority();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Stack(
        children: [
          Padding(padding: const EdgeInsets.all(24), child: TextFormField(
            controller: searchField,
            onChanged: (value){
              setState(() {
                debugPrint(value);
                searchList?.clear();
                authorityList?.forEach((element) {
                  if(element.email.contains(value)){
                    searchList?.add(element);
                  }
                });

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
          Padding(padding: const EdgeInsets.symmetric(vertical: 100), child: ListView.builder(itemCount:authorityList?.length, itemBuilder:  (context,index) {
            return UserListCard(authority: authorityList?[index]);
          })
          ),
          Align(alignment: Alignment.bottomCenter, child: DlsButton(
            onPressed: (){
              //todo: API call for saving authorities
            }, text: "Save",
          ),)
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
  @override
  void initState() {
    // TODO: implement initState
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
              color: widget.authority?.authorized??false?THEME_COLOR:Colors.white,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24)
              ), child: Padding(padding: const EdgeInsets.all(12),child: GestureDetector(onTap: (){
             
            },child:Text(widget.authority?.authorized??false?"ADMIN":"USER", style: TextStyle(
              color: widget.authority?.authorized??false?Colors.white:Colors.black))
            ),)
            )
          ],
        ),
      ),
    ));
  }
}

