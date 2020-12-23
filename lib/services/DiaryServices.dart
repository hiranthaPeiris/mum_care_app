import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:mun_care_app/models/DailyNoteModel.dart';
import 'package:mun_care_app/services/NotificationService.dart';

class DiaryServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final NotificationService _notificationService = NotificationService();

  Future<dynamic> saveDailyNote(
      DailyNoteModel dailyNote, String midwifeID) async {
    await _firestore
        .collection("diaryNotes")
        .doc(midwifeID)
        .collection("notes")
        .add(dailyNote.toJson())
        .then((value) {
      print(value);
      return value;
    }).catchError((err) => print(err));
  }

  Future<dynamic> saveWorkJob(
      DateTime dateTime, String dateSlug, String midwifeID) async {
    await _firestore
        .collection("workJobs")
        .doc(midwifeID)
        .collection("jobs")
        .doc(dateSlug)
        .set({"startTime": dateTime, "endTime": "", "duration": ""}).then(
            (value) {
      return value;
    }).catchError((err) {
      print(err);
      return err;
    });
  }

  Future<dynamic> updateWorkJob(
      DateTime dateTime, String dateSlug, String midwifeID) async {
    //Getting WorkJob Start Time
    var jobStartTime = await getStartTime(dateSlug, midwifeID);
    //var dDay = new DateTime.utc(1944, DateTime.june, 6);

    //Work job time difference
    Duration difference = jobStartTime.difference(dateTime);

    return await _firestore
        .collection("workJobs")
        .doc(midwifeID)
        .collection("jobs")
        .doc(dateSlug)
        .update({"endTime": dateTime, "duration": difference.inHours}).then((value) {
      return value;
    }).catchError((err) => print(err));
  }

  Future<DateTime> getStartTime(String dateSlug, String midwifeID) async {
    return await _firestore
        .collection("workJobs")
        .doc(midwifeID)
        .collection("jobs")
        .doc(dateSlug)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Timestamp startTime = documentSnapshot.data()['startTime'];
        return new DateTime.fromMillisecondsSinceEpoch(
            startTime.millisecondsSinceEpoch);
      }
      return null;
    }).catchError((err) => print(err));
  }
}
