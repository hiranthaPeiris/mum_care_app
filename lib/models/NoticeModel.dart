import 'package:cloud_firestore/cloud_firestore.dart';

class NoticeModel {
  String title;
  String description;
  String subject;
  String level;
  String midwifeID;

  DocumentReference documentReference;

  NoticeModel.fromMap(Map<String, dynamic> map, {this.documentReference}) {
    title = map['title'];
    description = map['title'];
    subject = map['title'];
    level = map['title'];
    midwifeID = map['title'];
  }
  NoticeModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), documentReference: snapshot.reference);
  NoticeModel(
      {this.title, this.description, this.subject, this.level, this.midwifeID});

  toJson() {
    return {
      'title': title,
      'description': description,
      'subject': subject,
      'level': level,
      'midwifeID': midwifeID,
    };
  }
}
