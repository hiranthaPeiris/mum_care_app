import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:date_format/date_format.dart';
//import 'package:firebase_core/firebase_core.dart';

class HomeShedule {
  String description;
  String date;
  //DateFormat _dateFormat;

  String time;
  String mothername;

  DocumentReference documentReference;
  //constructor
  HomeShedule({this.description, this.date, this.time, this.mothername});
  //map kiriima
  HomeShedule.fromMap(Map<String, dynamic> map, {this.documentReference}) {
    description = map["description"];
    date = map["date"];
    time = map["time"];
    mothername = map["mothername"];
  }
  HomeShedule.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), documentReference: snapshot.reference);
  toJson() {
    return {
      "description": description,
      "date": date,
      "time": time,
      "mothername": mothername
    };
  }
}
