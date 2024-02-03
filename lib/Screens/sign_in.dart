import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/Screens/forgaot_pass.dart';
import 'package:notes_app/Screens/home_page.dart';

class Sign_in_page extends StatefulWidget {
  const Sign_in_page({super.key});

  @override
  State<Sign_in_page> createState() => _Sign_in_pageState();
}

class _Sign_in_pageState extends State<Sign_in_page> {

  TextEditingController email_Controller = TextEditingController();
  TextEditingController pass_Controller = TextEditingController();

  sign_in_user()async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email_Controller.text, password: pass_Controller.text);
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
        title: Text("Sign in "),
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
          GestureDetector(onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Forgot_pass_page())),
              child: Text("forgot Password ?",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),)),
          ElevatedButton(onPressed: ()=>sign_in_user(), child: Text("Sign in")),
        ],
      ),
    );
  }
}
