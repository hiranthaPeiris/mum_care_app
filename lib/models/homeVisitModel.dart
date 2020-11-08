import 'package:cloud_firestore/cloud_firestore.dart';

class UpHomeVisit {
  String uid;
  String dateTime;
  String description;
  //UserM user;

  //var doc= snapshot.data.documents;
//var docId=doc[index].documentID

  DocumentReference documentReference;

  //constructor
  UpHomeVisit({this.uid, this.dateTime, this.description});
  //map kiriima
  /*UpHomeVisit.fromMap(Map<String, dynamic> map, {this.documentReference}) {
    
    dateTime = map["dateTime"];
    description = map["description"];
  }**/

  UpHomeVisit.fromSnapshot(DocumentSnapshot snapshot)
      //: this.fromMap(snapshot.data(), documentReference: snapshot.reference);
      : uid = snapshot.id,
        dateTime = snapshot['dateTime'],
        description = snapshot['description'];
  toJson() {
    return {"uid": uid, "dateTime": dateTime, "description": description};
  }
}
