
import 'package:cloud_firestore/cloud_firestore.dart';

class MediData {
  String name;
  String nic;
  String eligibleFamNumber;
  String doctorName;
  String vaccine;
  String date;
  String regDate;

  DocumentReference documentReference;

  MediData({
    this.name,
    this.nic,
    this.eligibleFamNumber,
    this.doctorName,
    this.vaccine,
    this.date,
    this.regDate,
  });

  MediData.fromMap(Map<String, dynamic> map, {this.documentReference}) {
    name = map["_Name"];
    nic = map["_NICnumber"];
    eligibleFamNumber = map["_EFsnumber"];
    doctorName = map["_Doctors_name"];
    vaccine = map["_Vacciness_name"];
    date = map["_date"];

    regDate = map['_regDate'];
  }
  MediData.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), documentReference: snapshot.reference);

  toJson() {
    return {
      '_Name': name,
      '_NICnumber': nic,
      '_EFsnumber': eligibleFamNumber,
      '__Doctors_name': doctorName,
      '_Vacciness_name': vaccine,
      '_date': date,
      '_regDate': regDate,
    };
  }
}

class LeaveData {
  String mohDropDownValue;
  String phmDropDownValue;
  String name;
  String nic;
  String eligibleFamNumber;
  String date;
  String regDate;

  DocumentReference documentReference;

  LeaveData({
    this.name,
    this.nic,
    this.eligibleFamNumber,
    this.date,
    this.regDate,
    this.mohDropDownValue,
    this.phmDropDownValue,
  });

  LeaveData.fromMap(Map<String, dynamic> map, {this.documentReference}) {
    name = map["_Name"];
    nic = map["_NICnumber"];
    eligibleFamNumber = map["_EFsnumber"];
    date = map["_date"];
    mohDropDownValue = map["_mohDropDownValue"];
    phmDropDownValue = map["_phmDropDownValue"];

    regDate = map['_regDate'];
  }
  LeaveData.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), documentReference: snapshot.reference);

  toJson() {
    return {
      '_Name': name,
      '_NICnumber': nic,
      '_EFsnumber': eligibleFamNumber,
      '_date': date,
      '_mohDropDownValue': mohDropDownValue,
      '_phmDropDownValue': phmDropDownValue,
      '_regDate': regDate,
    };
  }
}