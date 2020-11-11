//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:mun_care_app/Wapper.dart';

import 'package:mun_care_app/screens/Dashboard/Dashboard.dart';
import 'package:mun_care_app/screens/Error/ErrorView.dart';
import 'package:mun_care_app/screens/LeavingReport/LeavingReport.dart';
import 'package:mun_care_app/screens/MedicationReport/MedicationReport.dart';
import 'package:mun_care_app/screens/Notification/NotificationScreen.dart';
import 'package:mun_care_app/screens/Profile/Profile.dart';
import 'package:mun_care_app/screens/Signup/Signup.dart';
import 'package:mun_care_app/screens/chat/homechat.dart';
import 'package:mun_care_app/screens/registration/ComFamReg.dart';
import 'package:mun_care_app/screens/Reports/dairlyRepo.dart';
import 'package:mun_care_app/screens/Reports/monthlyRepo.dart';
import 'package:mun_care_app/screens/Reports/diary.dart';
import 'package:mun_care_app/screens/upcomingHomevisits/upcomingHomevisit.dart';
import 'package:mun_care_app/screens/reminders/SchHomeSearch.dart';
import 'package:mun_care_app/screens/reminders/CreateScreens/ScheduleClinic.dart';
import 'package:mun_care_app/screens/reminders/CreateScreens/ScheduleHomeVisits.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Wapper());
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => Dashboard());
      case '/comReg':
        return MaterialPageRoute(builder: (_) => ComFamReg());
      case '/signup':
        return MaterialPageRoute(builder: (_) => Signup());
      case '/notification':
        return MaterialPageRoute(builder: (_) => NotificationScreen());
      case '/sechHomeVisits':
        return MaterialPageRoute(builder: (_) => SchHomeVisitSearch());
      case '/sechClinics':
        return MaterialPageRoute(builder: (_) => ScheduleClinic());
      case '/chat':
        return MaterialPageRoute(builder: (_) => HomeChat());
      case '/leavingReport':
        return MaterialPageRoute(builder: (_) => LeavingReport());
      case '/MedicalReport':
        return MaterialPageRoute(builder: (_) => MedicationReport());
      case '/profile':
        return MaterialPageRoute(builder: (_) => Profile());

      case '/diary':
        return MaterialPageRoute(builder: (_) => DairlyDiary());
      case '/dailyRepo':
        return MaterialPageRoute(builder: (_) => DairlyReport());
      case '/monthlyRepo':
        return MaterialPageRoute(builder: (_) => MonthlyReport());
      // case '/sub':
      //return MaterialPageRoute(builder: (_) => SubCategoery(String));
      case '/upcomingHomevisit':
        return MaterialPageRoute(
            builder: (_) => UpcomingHomeVisitFirebaseDemo());
      case '/error':
        return MaterialPageRoute(
            builder: (_) => ErrorView(errorMsg: "Direct Route"));
      default:
        return MaterialPageRoute(
            builder: (_) => ErrorView(errorMsg: 'Default Route'));
    }
  }
}
