import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String name;
  String imageUrl;
  String role;
  String area01;
  String mohArea;
  bool competencyFam = false;
  bool pregnanctFam = false;
  bool compApp = false;
  bool pregApp = false;
  bool onDuty = false;
  String tel;
  String email;
  String token;
  String condition;
  List <String> nameSearch;
  String timeStamp;

  DocumentReference documentReference;

  UserModel({
    this.uid,
    this.name,
    this.imageUrl,
    this.role,
    this.area01,
    this.mohArea,
    this.competencyFam,
    this.pregnanctFam,
    this.compApp,
    this.pregApp,
    this.onDuty,
    this.tel,
    this.email,
    this.token,
    this.condition,
    this.timeStamp,
  });

  UserModel.setUID(this.uid);
  UserModel.fromMap(Map<String, dynamic> map, {this.documentReference}) {
    uid = map["uid"];
    name = map["name"];
    imageUrl = map["imageUrl"];
    role = map["role"];
    area01 = map["area01"];
    mohArea = map['mohArea'];
    competencyFam = map["competencyFam"];
    pregnanctFam = map["pregnanctFam"];
    compApp = map["compApp"];
    pregApp = map["pregApp"];
    onDuty = map["onDuty"];
    tel = map["tel"];
    email = map["email"];
    token = map["token"];
    condition = map["condition"];
    nameSearch = map['nameSearch'];
    timeStamp = map['timeStamp'];
  }
  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), documentReference: snapshot.reference);

  toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'role': role,
      'area01': area01,
      'mohArea': mohArea,
      'competencyFam': competencyFam,
      'pregnanctFam': pregnanctFam,
      'compApp': compApp,
      'pregApp': pregApp,
      'onDuty': onDuty,
      'tel': tel,
      'email': email,
      'token': token,
      'condition': condition,
      'nameSearch':getSearchParam(name),
      'timeStamp':timeStamp
    };
  }
  //search data creator
  List<String> getSearchParam(String param) {
    List<String> searchList = List();
    String temp = "";
    for (int i = 0; i < param.length; i++) {
      temp = temp + param[i];
      searchList.add(temp);
    }
    return searchList;
  }
}

// 'name': name,
//           'role': role,
//           'area01': 'notSelect',
//           'competencyFam': false,
//           'pregnanctFam': false,
//           'compApp': false,
//           'pregApp': false,
//           'midwifeID': 'null',
//           'onDuty': false,
//           'tel': "",
//           'email': "",
//           'token': "",
//           'condition':"normal",
//           'timeStamp': FieldValue.serverTimestamp(),
//           'nameSearch': getSearchParam(name)
