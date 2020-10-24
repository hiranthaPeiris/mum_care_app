import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class ComStepOne{

  String mohDropDownValue;
  String phmDropDownValue;
  String husbandName;
  String wifeName;
  String address;
  String nic;

  DocumentReference documentReference;

  ComStepOne({this.husbandName,this.wifeName,this.address,this.nic,this.mohDropDownValue,this.phmDropDownValue});

  ComStepOne.fromMap(Map<String,dynamic> map,{this.documentReference}){

      mohDropDownValue=map["_mohDropDownValue"];
      phmDropDownValue=map["_phmDropDownValue"];
      husbandName=map["_husbandName"];
      wifeName=map["_wifeName"];
      address=map["_address"];
      nic=map["_nic"];

  }
  ComStepOne.fromSnapshot(DocumentSnapshot snapshot):this.fromMap(snapshot.data(),documentReference:snapshot.reference);

  toJson(){
     return {
       '_mohDropDownValue':mohDropDownValue,
       '_phmDropDownValue':phmDropDownValue,
       '_husbandName':husbandName,
       '_wifeName':wifeName,
       '_address':address,
       '_nic':nic
     };
  }

}


class ComStepTwo{

  String dateDOB;
  String contactNum;
  String email;
  String job;
  String eduDropDownValue;
  String marrageDate;

  DocumentReference documentReference;

  ComStepTwo({this.dateDOB,this.contactNum,this.email,this.job,this.eduDropDownValue,this.marrageDate});

  ComStepTwo.fromMap(Map<String,dynamic> map,{this.documentReference}){

      dateDOB=map["_dateDOB"];
      contactNum=map["_contactNumber"];
      email=map["_email"];
      job=map["_job"];
      eduDropDownValue=map["_eduDropDownValue"];
      marrageDate=map["_dateMarrage"];

  }
  ComStepTwo.fromSnapshot(DocumentSnapshot snapshot):this.fromMap(snapshot.data(),documentReference:snapshot.reference);

  toJson(){
     return {
       '_dateDOB':dateDOB,
       '_contactNumber':contactNum,
       '_email':email,
       '_job':job,
       '_eduDropDownValue':eduDropDownValue,
       '_dateMarrage':marrageDate
     };
  }
}

class ComStepThreeMen{

  bool d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11;

  DocumentReference documentReference;

  ComStepThreeMen({this.d1,this.d2,this.d3,this.d4,this.d5,this.d6,this.d7,this.d8,this.d9,this.d10});

  ComStepThreeMen.fromMap(Map<String,dynamic> map,{this.documentReference}){

      d1=map["_desease1"];
      d2=map["_desease2"];
      d3=map["_desease3"];
      d4=map["_desease4"];
      d5=map["_desease5"];
      d6=map["_desease6"];
      d7=map["_desease7"];
      d8=map["_desease8"];
      d9=map["_desease9"];
      d10=map["_desease10"];

  }
  ComStepThreeMen.fromSnapshot(DocumentSnapshot snapshot):this.fromMap(snapshot.data(),documentReference:snapshot.reference);

  toJson(){
     return {
       '_desease1':d1,
       '_desease2':d2,
       '_desease3':d3,
       '_desease4':d4,
       '_desease5':d5,
       '_desease6':d6,
       '_desease7':d7,
       '_desease8':d8,
       '_desease9':d9,
       '_desease10':d10
     };
  }
}

class ComStepThreeWomen{

  bool d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11;

  DocumentReference documentReference;

  ComStepThreeWomen({this.d1,this.d2,this.d3,this.d4,this.d5,this.d6,this.d7,this.d8,this.d9,this.d10});

  ComStepThreeWomen.fromMap(Map<String,dynamic> map,{this.documentReference}){

      d1=map["_desease1"];
      d2=map["_desease2"];
      d3=map["_desease3"];
      d4=map["_desease4"];
      d5=map["_desease5"];
      d6=map["_desease6"];
      d7=map["_desease7"];
      d8=map["_desease8"];
      d9=map["_desease9"];
      d10=map["_desease10"];

  }
  ComStepThreeWomen.fromSnapshot(DocumentSnapshot snapshot):this.fromMap(snapshot.data(),documentReference:snapshot.reference);

  toJson(){
     return {
       '_desease1':d1,
       '_desease2':d2,
       '_desease3':d3,
       '_desease4':d4,
       '_desease5':d5,
       '_desease6':d6,
       '_desease7':d7,
       '_desease8':d8,
       '_desease9':d9,
       '_desease10':d10
     };
  }
}

class ComStepFour{

  String rubellaDropDownValue;
  String formicDropDownValue;
  String conDropDownValue;
  String womenWeight;
  String menWeight;
  String womenHeight;
  String menHeight;
  String womenBloodDropDownValue;
  String menBloodDropDownValue;

  DocumentReference documentReference;

  ComStepFour({this.rubellaDropDownValue,this.formicDropDownValue,this.conDropDownValue,this.womenWeight,this.menWeight,this.womenHeight,this.menHeight,this.womenBloodDropDownValue,this.menBloodDropDownValue});

  ComStepFour.fromMap(Map<String,dynamic> map,{this.documentReference}){

      rubellaDropDownValue=map["_rubellaDropDownValue"];
      formicDropDownValue=map["_formicDropDownValue"];
      conDropDownValue=map["_conDropDownValue"];
      womenWeight=map["_womenWeight"];
      menWeight=map["_menWeight"];
      womenHeight=map["_womenHeight"];
      menHeight=map["_menHeight"];
      womenBloodDropDownValue=map["_womenBloodDropDownValue"];
      menBloodDropDownValue=map["_menBloodDropDownValue"];

  }
  ComStepFour.fromSnapshot(DocumentSnapshot snapshot):this.fromMap(snapshot.data(),documentReference:snapshot.reference);

  toJson(){
     return {
       '_rubellaDropDownValue':rubellaDropDownValue,
       '_formicDropDownValue':formicDropDownValue,
       '_conDropDownValue':conDropDownValue,
       '_womenWeight':womenWeight,
       '_menWeight':menWeight,
       '_womenHeight':womenHeight,
       '_menHeight':menHeight,
       '_womenBloodDropDownValue':womenBloodDropDownValue,
       '_menBloodDropDownValue':menBloodDropDownValue
     };
  }
}