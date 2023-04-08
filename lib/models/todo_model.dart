import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel{
  String? todoId;
  String? title;
  bool? done;
  Timestamp? dateCreated;

  TodoModel({this.todoId, this.title, this.done, this.dateCreated});

  TodoModel.fromDocumentSnap(DocumentSnapshot documentSnap){
    todoId = documentSnap.id;
    title = documentSnap['title'];
    done = documentSnap['done'];
    dateCreated = documentSnap['dateCreated'];
  }
}