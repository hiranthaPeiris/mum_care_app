import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mun_care_app/widgets/Menu_linear_card.dart';

class ComRegDB {
  String mohDropDownValue;
  String phmDropDownValue;
  String husbandName;
  String wifeName;
  String address;
  String nic;

  String menDOB;
  String womenDOB;
  String contactNum;
  String email;
  String job;
  String eduDropDownValue;
  String marrageDate;

  bool md1,
      md2,
      md3,
      md4,
      md5,
      md6,
      md7,
      md8,
      md9,
      md10,
      md11,
      md12,
      md13,
      md14,
      md15;

  bool wd1,
      wd2,
      wd3,
      wd4,
      wd5,
      wd6,
      wd7,
      wd8,
      wd9,
      wd10,
      wd11,
      wd12,
      wd13,
      wd14,
      wd15;

  String rubellaDropDownValue;
  String formicDropDownValue;
  String conDropDownValue;
  String womenWeight;
  String menWeight;
  String womenHeight;
  String menHeight;
  String womenBloodDropDownValue;
  String menBloodDropDownValue;
  String regDate;
  String regMonth;
  double latitudeData;
  double longitiduData;
  bool delete;

  DocumentReference documentReference;

  ComRegDB(
      {this.husbandName,
      this.wifeName,
      this.address,
      this.nic,
      this.mohDropDownValue,
      this.phmDropDownValue,
      this.menDOB,
      this.womenDOB,
      this.contactNum,
      this.email,
      this.job,
      this.eduDropDownValue,
      this.marrageDate,
      this.md1,
      this.md2,
      this.md3,
      this.md4,
      this.md5,
      this.md6,
      this.md7,
      this.md8,
      this.md9,
      this.md10,
      this.md11,
      this.md12,
      this.md13,
      this.md14,
      this.md15,
      this.wd1,
      this.wd2,
      this.wd3,
      this.wd4,
      this.wd5,
      this.wd6,
      this.wd7,
      this.wd8,
      this.wd9,
      this.wd10,
      this.wd11,
      this.wd12,
      this.wd13,
      this.wd14,
      this.wd15,
      this.rubellaDropDownValue,
      this.formicDropDownValue,
      this.conDropDownValue,
      this.womenWeight,
      this.menWeight,
      this.womenHeight,
      this.menHeight,
      this.womenBloodDropDownValue,
      this.menBloodDropDownValue,
      this.regDate,
      this.regMonth,
      this.latitudeData,
      this.longitiduData,
      this.delete});

  ComRegDB.fromMap(Map<String, dynamic> map, {this.documentReference}) {
    mohDropDownValue = map["_mohDropDownValue"];
    phmDropDownValue = map["_phmDropDownValue"];
    husbandName = map["_husbandName"];
    wifeName = map["_wifeName"];
    address = map["_address"];
    nic = map["_nic"];

    menDOB = map["_menDOB"];
    womenDOB = map["_womenDOB"];
    contactNum = map["_contactNumber"];
    email = map["_email"];
    job = map["_job"];
    eduDropDownValue = map["_eduDropDownValue"];
    marrageDate = map["_dateMarrage"];

    md1 = map["m_desease1"];
    md2 = map["m_desease2"];
    md3 = map["m_desease3"];
    md4 = map["m_desease4"];
    md5 = map["m_desease5"];
    md6 = map["m_desease6"];
    md7 = map["m_desease7"];
    md8 = map["m_desease8"];
    md9 = map["m_desease9"];
    md10 = map["m_desease10"];
    md11 = map["m_desease11"];
    md12 = map["m_desease12"];
    md13 = map["m_desease13"];
    md14 = map["m_desease14"];
    md15 = map["m_desease15"];

    wd1 = map["w_desease1"];
    wd2 = map["w_desease2"];
    wd3 = map["w_desease3"];
    wd4 = map["w_desease4"];
    wd5 = map["w_desease5"];
    wd6 = map["w_desease6"];
    wd7 = map["w_desease7"];
    wd8 = map["w_desease8"];
    wd9 = map["w_desease9"];
    wd10 = map["w_desease10"];
    wd11 = map["w_desease11"];
    wd12 = map["w_desease12"];
    wd13 = map["w_desease13"];
    wd14 = map["w_desease14"];
    wd15 = map["w_desease15"];

    rubellaDropDownValue = map["_rubellaDropDownValue"];
    formicDropDownValue = map["_formicDropDownValue"];
    conDropDownValue = map["_conDropDownValue"];
    womenWeight = map["_womenWeight"];
    menWeight = map["_menWeight"];
    womenHeight = map["_womenHeight"];
    menHeight = map["_menHeight"];
    womenBloodDropDownValue = map["_womenBloodDropDownValue"];
    menBloodDropDownValue = map["_menBloodDropDownValue"];
    regDate = map['_regDate'];
    regMonth = map['_regMonth'];
    latitudeData = map['_latitudeData'];
    longitiduData = map['_longitiduData'];
    delete = map['_delete'];
    
  }
  ComRegDB.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), documentReference: snapshot.reference);

  toJson() {
    return {
      '_mohDropDownValue': mohDropDownValue,
      '_phmDropDownValue': phmDropDownValue,
      '_husbandName': husbandName,
      '_wifeName': wifeName,
      '_address': address,
      '_nic': nic,
      '_menDOB': menDOB,
      '_womenDOB': womenDOB,
      '_contactNumber': contactNum,
      '_email': email,
      '_job': job,
      '_eduDropDownValue': eduDropDownValue,
      '_dateMarrage': marrageDate,
      'm_desease1': md1,
      'm_desease2': md2,
      'm_desease3': md3,
      'm_desease4': md4,
      'm_desease5': md5,
      'm_desease6': md6,
      'm_desease7': md7,
      'm_desease8': md8,
      'm_desease9': md9,
      'm_desease10': md10,
      'm_desease11': md11,
      'm_desease12': md12,
      'm_desease13': md13,
      'm_desease14': md14,
      'm_desease15': md15,
      'w_desease1': wd1,
      'w_desease2': wd2,
      'w_desease3': wd3,
      'w_desease4': wd4,
      'w_desease5': wd5,
      'w_desease6': wd6,
      'w_desease7': wd7,
      'w_desease8': wd8,
      'w_desease9': wd9,
      'w_desease10': wd10,
      'w_desease11': wd11,
      'w_desease12': wd12,
      'w_desease13': wd13,
      'w_desease14': wd14,
      'w_desease15': wd15,
      '_rubellaDropDownValue': rubellaDropDownValue,
      '_formicDropDownValue': formicDropDownValue,
      '_conDropDownValue': conDropDownValue,
      '_womenWeight': womenWeight,
      '_menWeight': menWeight,
      '_womenHeight': womenHeight,
      '_menHeight': menHeight,
      '_womenBloodDropDownValue': womenBloodDropDownValue,
      '_menBloodDropDownValue': menBloodDropDownValue,
      '_regDate': regDate,
      '_regMonth': regMonth,
      '_latitudeData': latitudeData,
      '_longitiduData': longitiduData,
      '_delete': delete,
    };
  }
}

class PreRegDB {
  String mohDropDownValue;
  String phmDropDownValue;
  String gnDivision;
  String fcName;
  String hcName;
  String coName;

  String womb;
  String result;
  String details;
  String kgWeight;
  String gWeight;
  String sex;

  bool pvb;
  String bloodPresure;
  bool diabetic;
  bool maleria;
  bool heartDisorder;
  bool kidneyDisorder;
  String regDate;
  String regMonth;
  bool delete;

  DocumentReference documentReference;

  PreRegDB(
      {this.mohDropDownValue,
      this.phmDropDownValue,
      this.gnDivision,
      this.fcName,
      this.hcName,
      this.coName,
      this.womb,
      this.result,
      this.details,
      this.kgWeight,
      this.gWeight,
      this.sex,
      this.pvb,
      this.bloodPresure,
      this.diabetic,
      this.maleria,
      this.heartDisorder,
      this.kidneyDisorder,
      this.regDate,
      this.regMonth,
      this.delete});

  PreRegDB.fromMap(Map<String, dynamic> map, {this.documentReference}) {
    mohDropDownValue = map["_mohDropDownValue"];
    phmDropDownValue = map["_phmDropDownValue"];
    gnDivision = map["_gnDivision"];
    fcName = map["_fcName"];
    hcName = map["_hcName"];
    coName = map["_coName"];

    womb = map["_womb"];
    result = map["_result"];
    details = map["_details"];
    kgWeight = map["_kgWeight"];
    gWeight = map["_gWeight"];
    sex = map["_sex"];

    pvb = map["_pvb"];
    bloodPresure = map["_bloodPresure"];
    diabetic = map["_diabetic"];
    maleria = map["_maleria"];
    heartDisorder = map["_heartDisorder"];
    maleria = map["_maleria"];
    regDate = map["_regDate"];
    regMonth = map['_regMonth'];
    delete = map['_delete'];
  }
  PreRegDB.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), documentReference: snapshot.reference);

  toJson() {
    return {
      '_mohDropDownValue': mohDropDownValue,
      '_phmDropDownValue': phmDropDownValue,
      '_gnDivision': gnDivision,
      '_fcName': fcName,
      '_hcName': hcName,
      '_coName': coName,
      '_womb': womb,
      '_result': result,
      '_details': details,
      '_kgWeight': kgWeight,
      '_gWeight': gWeight,
      '_sex': sex,
      '_pvb': pvb,
      '_bloodPresure': bloodPresure,
      '_diabetic': diabetic,
      '_maleria': maleria,
      '_heartDisorder': heartDisorder,
      '_kidneyDisorder': kidneyDisorder,
      '_regDate': regDate,
      '_regMonth': regMonth,
      '_delete': delete,
    };
  }
}

class WombPreRegDB {
  String womb;
  String result;
  String details;
  String kgWeight;
  String gWeight;
  String sex;

  DocumentReference documentReference;

  WombPreRegDB({
    this.womb,
    this.result,
    this.details,
    this.kgWeight,
    this.gWeight,
    this.sex,
  });

  WombPreRegDB.fromMap(Map<String, dynamic> map, {this.documentReference}) {
    womb = map["_womb"];
    result = map["_result"];
    details = map["_details"];
    kgWeight = map["_kgWeight"];
    gWeight = map["_gWeight"];
    sex = map["_sex"];
  }
  WombPreRegDB.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), documentReference: snapshot.reference);

  toJson() {
    return {
      '_womb': womb,
      '_result': result,
      '_details': details,
      '_kgWeight': kgWeight,
      '_gWeight': gWeight,
      '_sex': sex,
    };
  }
}

class ComSetState {
  bool allreadyComReg;

  DocumentReference documentReference;

  ComSetState({
    this.allreadyComReg,
  });

  ComSetState.fromMap(Map<String, dynamic> map, {this.documentReference}) {
    allreadyComReg = map["_allreadyComReg"];
  }
  ComSetState.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), documentReference: snapshot.reference);

  toJson() {
    return {
      '_allreadyComReg': allreadyComReg,
    };
  }
}

/*class OndutyState {
  bool onDuty;
  String logTime;

  DocumentReference documentReference;

  OndutyState({this.onDuty, this.logTime});

  OndutyState.fromMap(Map<String, dynamic> map, {this.documentReference}) {
    onDuty = map["_onDuty"];
    logTime = map["_logTime"];
  }
  OndutyState.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), documentReference: snapshot.reference);

  toJson() {
    return {'_onDuty': onDuty, '_logTime': logTime};
  }
}*/
