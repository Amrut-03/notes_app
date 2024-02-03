
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  add_note({required String note, required String phonenumber}) async {
    await FirebaseFirestore.instance.collection("notes").add({
      "note": note,
      "timestamp": Timestamp.now(),
      "phonenumber": phonenumber
    });
  }

  updateNote({required String docId, required String updatedNote})async{
    await FirebaseFirestore.instance.collection("notes").doc(docId).update({
      "note": updatedNote,
      "timestamp": Timestamp.now(),
    });
  }
  
  deleteNote({required String docId})async{
    await FirebaseFirestore.instance.collection("notes").doc(docId).delete();
  }
  
  Stream getnotes() {
    final notesStream = FirebaseFirestore.instance
        .collection("notes")
        .orderBy(
          "timestamp",
          descending: true,
        )
        .snapshots();
    return notesStream;
  }

  TextEditingController controller = TextEditingController();
  TextEditingController phone_controller = TextEditingController();
  TextEditingController updated_controller = TextEditingController();

  open_dialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add note"),
            actions: [
              TextField(
                controller: controller,
                decoration:const InputDecoration(
                  hintText: "Enter your note",
                ),
              ),
              TextField(
                keyboardType: TextInputType.phone,
                controller: phone_controller,
                decoration: InputDecoration(
                  hintText: "Enter your number",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    add_note(
                        note: controller.text,
                        phonenumber: phone_controller.text);
                    Navigator.pop(context);
                  },
                  child: Text("Add")),
            ],
          );
        });
  }

  updated_dialog({required String docId}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add note"),
            actions: [
              TextField(
                controller: updated_controller,
                decoration: InputDecoration(
                  hintText: "Enter your note",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    updateNote(docId: docId, updatedNote: updated_controller.text);
                    updated_controller.clear();
                    Navigator.pop(context);
                  },
                  child: Text("Add")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;
            return ListView.builder(itemCount: notesList.length,itemBuilder: (context, index) {
              DocumentSnapshot document = notesList[index];
              String docId = document.id;
              Map <String,dynamic> data = document.data() as Map <String,dynamic>;
              
              return ListTile(
                title: Text(data["note"]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: ()=>updated_dialog(docId: docId) ,icon: Icon(Icons.edit)),
                    IconButton(onPressed: ()=>deleteNote(docId: docId) ,icon: Icon(Icons.delete)),
                  ],
                ),
              );
            });
          } else {
            return Text("No notes");
          }
        },
        stream: getnotes(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          open_dialog();
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("home page"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 200,
            ),
            ListTile(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              leading: Icon(Icons.logout),
              title: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
