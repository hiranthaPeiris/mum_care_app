import 'package:cloud_firestore/cloud_firestore.dart';
class LeaveFormDB{
  String applicantName;
  String mohDropDownValue;
  DateTime applyDate;
  String department;
  DateTime appoimentDate;
  String numOfDays;
  DateTime leaveOnDate;
  DateTime leaveOffDate;
  String reason;
  String applicantAddress;
  String midwifeID;
  DocumentReference midwifeUserRef;
  bool accept;
  bool reject;

  DocumentReference documentReference;

  LeaveFormDB(
    {
      this.applicantName,
      this.mohDropDownValue,
      this.applyDate,
      this.department,
      this.appoimentDate,
      this.numOfDays,
      this.leaveOnDate,
      this.leaveOffDate,
      this.reason,
      this.applicantAddress,
      this.midwifeID,
      this.midwifeUserRef,
      this.accept,
      this.reject
    }
  );
  LeaveFormDB.fromMap(Map<String, dynamic> map, {this.documentReference}) {
    applicantName = map["_applicantName"];
    mohDropDownValue = map["_mohDropDownValue"];
    applyDate = map["_applyDate"];
    department = map["_department"];
    appoimentDate = map["_appoimentDate"];
    numOfDays = map["_numOfDays"];
    leaveOnDate = map["_leaveOnDate"];
    midwifeID = map["_midwifeID"];
    midwifeUserRef = map["_midwifeUserRef"];
    leaveOffDate = map["_leaveOffDate"];
    reason = map["_reason"];
    applicantAddress = map["_applicantAddress"];
    accept=map["_accept"];
    reject=map["_reject"];
  }
   LeaveFormDB.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), documentReference: snapshot.reference);

  toJson() {
    return {
      '_applicantName': applicantName,
      '_mohDropDownValue': mohDropDownValue,
      '_applyDate': applyDate,
      '_department': department,
      '_appoimentDate': appoimentDate,
      '_numOfDays': numOfDays,
      '_leaveOnDate': leaveOnDate,
      '_leaveOffDate': leaveOffDate,
      '_reason': reason,
      '_applicantAddress': applicantAddress,
      '_midwifeID':midwifeID,
      '_midwifeUserRef':midwifeUserRef,
      '_accept': accept,
      '_reject': reject,

    };
  }
}