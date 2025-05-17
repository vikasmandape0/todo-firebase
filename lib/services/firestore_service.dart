import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference notes = FirebaseFirestore.instance.collection("notes",);

  Future<void> addNote(String note) {
    return notes.add({'note': note, 'timestamp': Timestamp.now()});
  }

  Stream<QuerySnapshot> getNoteStream() {
    final noteStream = notes.orderBy('timestamp', descending: true).snapshots();
    return noteStream;
  }

  Future<void> updateNote(String docId, String newNote) {
    return notes.doc(docId).update({'note': newNote, 'timestamp': Timestamp.now()});
  }

  Future<void> deleteNote(String docId) {
    return notes.doc(docId).delete();
  }
}
