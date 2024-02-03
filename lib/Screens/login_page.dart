
import 'package:flutter/material.dart';
import 'package:notes_app/Screens/demo.dart';
import 'package:notes_app/Screens/sign_in.dart';
import 'package:notes_app/Screens/sign_up.dart';

class Login_page extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login page"),
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Sign_in_page()));
          }, child: Text("Sign in")),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>demo()));
          }, child: Text("Sign up")),
        ],
      ),
    );

  }

}