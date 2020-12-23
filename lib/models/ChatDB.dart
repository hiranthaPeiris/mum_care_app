
import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
   String senderID;
   String time; // Would usually be type DateTime or Firebase Timestamp in production apps
   String text;
   bool reciveID;
   bool unread;
DocumentReference documentReference;
  Message({
    this.senderID,
    this.time,
    this.text,
    this.reciveID,
    this.unread,
  });
Message.fromMap(Map<String, dynamic> map, {this.documentReference}) {
    senderID = map["_senderID"];
    time = map["_time"];
    text = map["_text"];
    reciveID = map["_reciveID"];
    unread = map["_unread"];
  }
Message.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), documentReference: snapshot.reference);

  toJson() {
    return {
      '_senderID': senderID,
      '_time': time,
      '_text': text,
      '_reciveID': reciveID,
      '_unread': unread,
    };
  }
}

class ChatUser {
   int id;
   String name;
   String imageUrl;
DocumentReference documentReference;
  ChatUser({
    this.id,
    this.name,
    this.imageUrl,
  });
  ChatUser.fromMap(Map<String, dynamic> map, {this.documentReference}) {
    id = map["_id"];
    name = map["_name"];
    imageUrl = map["_imageUrl"];
  }
  ChatUser.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), documentReference: snapshot.reference);

  toJson() {
    return {
      '_id': id,
      '_name': name,
      '_imageUrl': imageUrl,
    };
  }
}