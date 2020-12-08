//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:mun_care_app/Wapper.dart';
import 'package:mun_care_app/screens/Clinic/ClinicHomeWapper.dart';

import 'package:mun_care_app/screens/Dashboard/Dashboard.dart';
import 'package:mun_care_app/screens/Error/ErrorView.dart';
import 'package:mun_care_app/screens/LeavingAreaReport/LeavingReport.dart';
import 'package:mun_care_app/screens/MedicationReport/MedicationReport.dart';
import 'package:mun_care_app/screens/MedicationReport/ViewMedication.dart';
import 'package:mun_care_app/screens/Notification/NotificationScreen.dart';
import 'package:mun_care_app/screens/Profile/Profile.dart';
import 'package:mun_care_app/screens/Reports/DairlyReportView.dart';
import 'package:mun_care_app/screens/Reports/MonthlyReportView.dart';
import 'package:mun_care_app/screens/Reports/ReportSearch.dart';
import 'package:mun_care_app/screens/Reviews/PregReview.dart';
import 'package:mun_care_app/screens/Signup/Signup.dart';
import 'package:mun_care_app/screens/ViewUpcomingClinics/ViewUpcomingClinic.dart';
import 'package:mun_care_app/screens/chat/homechat.dart';
import 'package:mun_care_app/screens/ViewUpcomingHomevisit/ViewUpcomingHomevisit.dart';
import 'package:mun_care_app/screens/registration/ComFamReg.dart';
import 'package:mun_care_app/screens/Reviews/MotherList.dart';
import 'package:mun_care_app/screens/registration/PreFamReg.dart';
import 'package:mun_care_app/screens/registration/RenderData.dart';
import 'package:mun_care_app/screens/reminders/SchHomeSearch.dart';
import 'package:mun_care_app/screens/reminders/CreateScreens/ScheduleClinic.dart';
import 'package:mun_care_app/services/GeoLocation.dart';

import 'screens/LeavingAreaReport/ViewLeaving.dart';

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

      //Midwife Mother reviews
      case '/motherAssign':
        return MaterialPageRoute(builder: (_) => MotherList());
      case '/motherPregReview':
        return MaterialPageRoute(builder: (_) => PregReview());

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
      case '/geoLocate':
        return MaterialPageRoute(builder: (_) => GeoLocation());

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
      //  
      // Upcomming home visits and clinics
      case '/UpcomingClinics':
        return MaterialPageRoute(builder: (_) => ViewUpcomingClinic());
      case '/UpcomingHome':
        return MaterialPageRoute(builder: (_) => ViewUpcomingHomevisit());
      case '/viewupcominghomevisit':
        return MaterialPageRoute(builder: (_) => ViewUpcomingHomevisit());
        
      //Profile
      case '/profile':
        return MaterialPageRoute(
            builder: (_) => Profile(
                  review: false,
                ));
      //Reports (Daily | Monthly)
      case '/searchReport':
        return MaterialPageRoute(builder: (_) => ReportSearch());
      case '/dairlyReportView':
        return MaterialPageRoute(builder: (_) => DairlyReportView());
      case '/monthlyReportView':
        return MaterialPageRoute(builder: (_) => MonthlyReportView());

      case '/error':
        return MaterialPageRoute(
            builder: (_) => ErrorView(errorMsg: "Direct Route"));
      default:
        return MaterialPageRoute(
            builder: (_) => ErrorView(errorMsg: 'Default Route'));
    }
  }
}
