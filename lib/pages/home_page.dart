import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pkart/services/firestore_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  FirestoreService service = FirestoreService();
  void openNoteBox({String? docId}) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: TextField(controller: controller),
            actions: [
              ElevatedButton(
                onPressed: () {
                  if (docId != null) {
                    service.updateNote(docId, controller.text);
                  } else {
                    service.addNote(controller.text);
                  }
                  controller.clear();
                  Navigator.pop(context);
                },
                child: Text("Add"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: StreamBuilder<QuerySnapshot>(
        stream: service.getNoteStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;
            return ListView.builder(
              itemBuilder: (context, index) {
                DocumentSnapshot docSnapshot = notesList[index];
                String docId = docSnapshot.id;
                Map<String, dynamic> note =
                    docSnapshot.data() as Map<String, dynamic>;
                String noteText = note['note'];
                return ListTile(
                  title: Text(noteText),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          openNoteBox(docId: docId);
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          service.deleteNote(docId);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
              itemCount: notesList.length,
            );
          } else {
            return Center(child: Text("No Notes"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: openNoteBox),
    );
  }
}
