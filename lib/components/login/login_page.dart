import 'package:flutter/material.dart';
import 'package:sece_event_calendar/components/home/home_page.dart';
import 'package:sece_event_calendar/components/login/signup_page.dart';
import 'package:sece_event_calendar/dls/custombutton.dart';
import 'package:sece_event_calendar/dls/customedittext.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var isObscured = true;

  @override
  void initState() {
    // TODO: implement initState
    isObscured = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //todo: Implement login page
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child:
                  Container(
                    width: 250,
                    height: 250,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/login/secelogo.png"),fit: BoxFit.cover
                      )
                    )
                  )),SizedBox(
                  width: MediaQuery.of(context).size.width-1,
                  height: 40,
                  child: const Center(child: Text(
                  "EvenT CalendaR",
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                  ))),
                const Padding(padding: EdgeInsets.only(top: 12), child: Text("LOGIN", textAlign: TextAlign.center, style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black,
                ),)),
               const CustomEditText(hintText: "Email", sufficeIcon: Icon(Icons.email, color: Colors.black,),),
                Padding(padding: const EdgeInsets.all(16), child:
                TextFormField(
                  obscureText: isObscured,
                  decoration: InputDecoration(
                      hintText: "Password",
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: IconButton(icon: isObscured?const Icon(Icons.visibility, color: Colors.black,) :
                      const Icon(Icons.visibility_off, color: Colors.black,),
                        onPressed: (){
                        setState(() {
                          isObscured = !isObscured;
                        });
                        },),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:const BorderSide(
                              color: Colors.black
                          )
                      )
                  ),
                )),
                Padding(padding: const EdgeInsets.only(top: 12), child: DlsButton(text: "LOG IN", onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                })),
               const Padding(padding: EdgeInsets.only(top: 20)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    const Text("Don't have an account?", style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                      },
                      child: const Text(" Sign Up", style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 16,
                      ),),
                    )

                  ],
                 )
              ]
            ),

          )
        ],
      ),
    );
  }
}
