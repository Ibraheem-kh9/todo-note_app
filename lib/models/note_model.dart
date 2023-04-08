import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel{
  String? noteId;
  String? titleNote;
  String? contentNote;
  Timestamp? dateCreatedNote;
  bool? pinNote;

  NoteModel(
      {this.noteId, this.titleNote, this.contentNote, this.dateCreatedNote,this.pinNote});

  NoteModel.fromDocumentSnap(DocumentSnapshot noteSnap){
    noteId = noteSnap.id;
    titleNote = noteSnap['Title'];
    contentNote = noteSnap['Content'];
    dateCreatedNote = noteSnap['DateCreated'];
    pinNote = noteSnap['PinNote'];
  }


}
