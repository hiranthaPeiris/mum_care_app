import 'package:cloud_firestore/cloud_firestore.dart';

class NoticeModel {
  String title;
  String description;
  String subject;
  String level;
  String midwifeID;
  String audiance;
  DocumentReference documentReference;

  NoticeModel.fromMap(Map<String, dynamic> map, {this.documentReference}) {
    title = map['title'];
    description = map['title'];
    subject = map['title'];
    level = map['title'];
    midwifeID = map['title'];
    audiance = map['audiance'];
  }
  NoticeModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), documentReference: snapshot.reference);
  NoticeModel(
      {this.title, this.description, this.subject, this.level, this.midwifeID,this.audiance});

  toJson() {
    return {
      'title': title,
      'description': description,
      'subject': subject,
      'level': level,
      'midwifeID': midwifeID,
      'audiance':audiance
    };
  }
}
