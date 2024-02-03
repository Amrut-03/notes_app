import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/Screens/sign_in.dart';

class Forgot_pass_page extends StatefulWidget {
  const Forgot_pass_page({super.key});

  @override
  State<Forgot_pass_page> createState() => _Forgot_pass_pageState();
}

class _Forgot_pass_pageState extends State<Forgot_pass_page> {
  TextEditingController email_Controller = TextEditingController();

  create_user() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email_Controller.text);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("passwaord reset link sent check your email"),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Sign_in_page())),
                    child: Text("ok"))
              ],
            );
          });
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>Sign_in_page()));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message!),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
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
          ElevatedButton(
              onPressed: () => create_user(), child: Text("Send Email")),
        ],
      ),
    );
  }
}
