import 'package:cloud_firestore/cloud_firestore.dart';

class MediData {
  String name;
  String description;
  String doctorName;
  String vaccine;
  String hospital;
  String mumRemarks;
  String date;
  String regDate;
  String midwifeID;
  String midwifeRemarks;
  String status;
  DocumentReference userDocRef;

  DocumentReference documentReference;

  MediData(
      {this.name,
      this.description,
      this.doctorName,
      this.vaccine,
      this.mumRemarks,
      this.date,
      this.regDate,
      this.midwifeID,
      this.status,
      this.userDocRef});

  MediData.fromMap(Map<String, dynamic> map, {this.documentReference}) {
    name = map["_Name"];
    description =  map["_Description"];
    doctorName = map["_Doctors_name"];
    vaccine = map["_Vacciness_name"];
    mumRemarks = map["_MumRemarks"];
    date = map["_date"];
    midwifeID =  map["_midwifeID"];
    midwifeRemarks = map["_midwifeRemarks"];
    regDate = map['_regDate'];
    status = map['_status'];
    userDocRef = map['_userDocRef'];
  }
  MediData.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), documentReference: snapshot.reference);

  toJson() {
    return {
      '_Name':name,
      '_Description': description,
      '_midwifeID': midwifeID,
      '_midwifeRemarks':midwifeRemarks,
      '__Doctors_name': doctorName,
      '_Vacciness_name': vaccine,
      '_MumRemarks':mumRemarks,
      '_date': date,
      '_regDate': regDate,
      '_status':status,
      '_userDocRef': userDocRef
    };
  }
}

class LeaveData {
  String mohDropDownValue;
  String phmDropDownValue;
  String name;
  String nic;
  String mumRemarks; 
  String date;
  String regDate;
  String midwifeID;
  String midwifeRemarks;
  String status;
  DocumentReference userDocRef;

  DocumentReference documentReference;

  LeaveData({
    this.name,
    this.nic,
    this.mumRemarks,
    this.date,
    this.regDate,
    this.midwifeID,
    this.mohDropDownValue,
    this.phmDropDownValue,
    this.midwifeRemarks,
    this.status
  });

  LeaveData.fromMap(Map<String, dynamic> map, {this.documentReference}) {
    name = map["_Name"];
    midwifeID = map['_midwifeID'];
    nic = map["_NICnumber"];
    mumRemarks = map["_MumRemarks"];
    midwifeRemarks = map['_midwifeRemarks'];
    date = map["_date"];
    mohDropDownValue = map["_mohDropDownValue"];
    phmDropDownValue = map["_phmDropDownValue"];
    userDocRef = map['_userDocRef'];
    regDate = map['_regDate'];
    status = map['_status'];
  }
  LeaveData.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), documentReference: snapshot.reference);

  toJson() {
    return {
      '_Name': name,
      '_midwifeID':midwifeID,
      '_midwifeRemarks':midwifeRemarks,
      '_NICnumber': nic,
      '_MumRemarks': mumRemarks,
      '_date': date,
      '_mohDropDownValue': mohDropDownValue,
      '_phmDropDownValue': phmDropDownValue,
      '_regDate': regDate,
      '_userDocRef':userDocRef,
      '_status':status
    };
  }
}