import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/Screens/demo.dart';
import 'package:notes_app/Screens/home_page.dart';

class Sign_up_page extends StatefulWidget {
  const Sign_up_page({super.key});

  @override
  State<Sign_up_page> createState() => _Sign_up_pageState();
}

class _Sign_up_pageState extends State<Sign_up_page> {

  TextEditingController email_Controller = TextEditingController();
  TextEditingController pass_Controller = TextEditingController();
  
  create_user()async{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email_Controller.text, password: pass_Controller.text);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>home_page()));
    }
    on FirebaseAuthException
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message!),));
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up "),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: TextField(
              controller: email_Controller,
              decoration: InputDecoration(
                hintText: "Email",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: TextField(
              controller: pass_Controller,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "password",
              ),
            ),
          ),
          ElevatedButton(onPressed: ()=>demo(), child: Text("Sign up")),
        ],
      ),
    );
  }
}
