import 'package:cloud_firestore/cloud_firestore.dart';
class LeaveFormDB{
  String applicantName;
  DateTime applyDate;
  String department;
  DateTime appoimentDate;
  String numOfDays;
  DateTime leaveOnDate;
  DateTime leaveOffDate;
  String reason;
  String applicantAddress;
  bool accept;
  bool reject;

  DocumentReference documentReference;

  LeaveFormDB(
    {
      this.applicantName,
      this.applyDate,
      this.department,
      this.appoimentDate,
      this.numOfDays,
      this.leaveOnDate,
      this.leaveOffDate,
      this.reason,
      this.applicantAddress,
      this.accept,
      this.reject
    }
  );
  LeaveFormDB.fromMap(Map<String, dynamic> map, {this.documentReference}) {
    applicantName = map["_applicantName"];
    applyDate = map["_applyDate"];
    department = map["_department"];
    appoimentDate = map["_appoimentDate"];
    numOfDays = map["_numOfDays"];
    leaveOnDate = map["_leaveOnDate"];

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
      '_applyDate': applyDate,
      '_department': department,
      '_appoimentDate': appoimentDate,
      '_numOfDays': numOfDays,
      '_leaveOnDate': leaveOnDate,
      '_leaveOffDate': leaveOffDate,
      '_reason': reason,
      '_applicantAddress': applicantAddress,
      '_accept': accept,
      '_reject': reject,

    };
  }
}