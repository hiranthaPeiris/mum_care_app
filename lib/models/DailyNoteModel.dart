import 'package:cloud_firestore/cloud_firestore.dart';

class DailyNoteModel {
  String title;
  String subTitle;
  String subject;
  String description;
  String remarks;
  var createdAt;

  DocumentReference documentReference;

  DailyNoteModel(
      {this.title,
      this.subTitle,
      this.subject,
      this.description,
      this.remarks,this.createdAt});

  DailyNoteModel.fromMap(Map<String, dynamic> map, {this.documentReference}) {
    title = map['title'];
    subTitle = map['subTitle'];
    subject = map['subject'];
    description = map['desc'];
    remarks = map['remarks'];
    createdAt = map['createdAt'];
  }

   DailyNoteModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), documentReference: snapshot.reference);

  toJson() {
    return {
      'title': title,
      'subTitle': subTitle,
      'subject': subject,
      'desc': description,
      'remarks': remarks,
      'createdAt':createdAt
    };
  }
}
