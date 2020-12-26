import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';

class Task {
  String taskName;
  String title;
  String date;
  String time;

  DocumentReference documentReference;
  //constructor
  Task({this.taskName, this.title, this.date, this.time});
  //map kiriima
  Task.fromMap(Map<String, dynamic> map, {this.documentReference}) {
    taskName = map["task"];
    title = map["title"];
    date = map["date"];
    time = map["time"];
  }
  Task.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), documentReference: snapshot.reference);
  toJson() {
    return {"task": taskName, "title": title, "date": date, time: "time"};
  }
}
