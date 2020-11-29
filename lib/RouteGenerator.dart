//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:mun_care_app/Wapper.dart';
import 'package:mun_care_app/screens/Clinic/ClinicHomeWapper.dart';

import 'package:mun_care_app/screens/Dashboard/Dashboard.dart';
import 'package:mun_care_app/screens/Error/ErrorView.dart';
import 'package:mun_care_app/screens/LeavingReport/LeavingReport.dart';
import 'package:mun_care_app/screens/LeavingReport/ViewLeaving.dart';
import 'package:mun_care_app/screens/MedicationReport/MedicationReport.dart';
import 'package:mun_care_app/screens/MedicationReport/VewMedication.dart';
import 'package:mun_care_app/screens/Notification/NotificationScreen.dart';
import 'package:mun_care_app/screens/Profile/Profile.dart';
import 'package:mun_care_app/screens/Signup/Signup.dart';
import 'package:mun_care_app/screens/ViewUpcomingClinics/ViewUpcomingClinic.dart';
import 'package:mun_care_app/screens/chat/homechat.dart';
import 'package:mun_care_app/screens/ViewUpcomingHomevisit/ViewUpcomingHomevisit.dart';
import 'package:mun_care_app/screens/registration/ComFamReg.dart';
import 'package:mun_care_app/screens/Reports/dairlyRepo.dart';
import 'package:mun_care_app/screens/Reports/monthlyRepo.dart';
import 'package:mun_care_app/screens/Reports/diary.dart';
import 'package:mun_care_app/screens/registration/MotherList.dart';
import 'package:mun_care_app/screens/registration/PreFamReg.dart';
import 'package:mun_care_app/screens/registration/RenderData.dart';
import 'package:mun_care_app/screens/reminders/SchHomeSearch.dart';
import 'package:mun_care_app/screens/reminders/CreateScreens/ScheduleClinic.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map<String, String> args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Wapper());
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => Dashboard());
      case '/comReg':
        return MaterialPageRoute(builder: (_) => ComFamReg());
      case '/preReg':
        return MaterialPageRoute(builder: (_) => PreFamReg());
      case '/renderData':
        return MaterialPageRoute(builder: (_) => ComRenderData());
      case '/motherAssign':
        return MaterialPageRoute(builder: (_) => MotherList());
      case '/signup':
        return MaterialPageRoute(builder: (_) => Signup());
      case '/notification':
        return MaterialPageRoute(builder: (_) => NotificationScreen());
      case '/sechHomeVisits':
        return MaterialPageRoute(builder: (_) => SchHomeVisitSearch());
      case '/sechClinics':
        return MaterialPageRoute(
            builder: (_) => ScheduleClinic(rescheduleFLAG: false));
      case '/clinicHome':
        return MaterialPageRoute(
            builder: (_) => ClinicHomeWapper(
                  key: Key('clinic'),
                  viewSwitch: args['switchView'],
                ));

      case '/chat':
        return MaterialPageRoute(builder: (_) => HomeChat());
      case '/motherList':
        return MaterialPageRoute(builder: (_) => MotherList());
      case '/leavingReport':
        return MaterialPageRoute(builder: (_) => LeavingReport());
      case '/MedicalReport':
        return MaterialPageRoute(builder: (_) => MedicationReport());
      case '/ViewleavingReport':
        return MaterialPageRoute(builder: (_) => ViewLeaving());
      case '/ViewMedicalReport':
        return MaterialPageRoute(builder: (_) => ViewMedication());
      case '/UpcomingClinics':
        return MaterialPageRoute(builder: (_) => ViewUpcomingClinic());
      case '/UpcomingHome':
        return MaterialPageRoute(builder: (_) => ViewUpcomingHomevisit());
      case '/profile':
        return MaterialPageRoute(builder: (_) => Profile());
      case '/diary':
        return MaterialPageRoute(builder: (_) => DairlyDiary());
      case '/dailyRepo':
        return MaterialPageRoute(builder: (_) => DairlyReport());
      case '/monthlyRepo':
        return MaterialPageRoute(builder: (_) => MonthlyReport());
      case '/profile':
        return MaterialPageRoute(builder: (_) => Profile());
      case '/viewupcominghomevisit':
        return MaterialPageRoute(builder: (_) => ViewUpcomingHomevisit());
      case '/error':
        return MaterialPageRoute(
            builder: (_) => ErrorView(errorMsg: "Direct Route"));
      default:
        return MaterialPageRoute(
            builder: (_) => ErrorView(errorMsg: 'Default Route'));
    }
  }
}
