//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:geolocation/geolocation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mun_care_app/Wapper.dart';

import 'package:mun_care_app/screens/Dashboard/Dashboard.dart';
import 'package:mun_care_app/screens/leavingForm/sisterLeaveView.dart';
import 'package:mun_care_app/sister/DutyChecking.dart';
import 'package:mun_care_app/sister/LeavingAccept.dart';
import 'package:mun_care_app/screens/Error/ErrorView.dart';
import 'package:mun_care_app/screens/LeavingReport/LeavingReport.dart';
import 'package:mun_care_app/screens/MedicationReport/MedicationReport.dart';
import 'package:mun_care_app/screens/Notification/NotificationScreen.dart';
import 'package:mun_care_app/screens/Profile/Profile.dart';
import 'package:mun_care_app/screens/Signup/Signup.dart';
import 'package:mun_care_app/screens/ViewUpcomingClinics/ViewUpcomingClinic.dart';
import 'package:mun_care_app/screens/chat/homechat.dart';
import 'package:mun_care_app/screens/leavingForm/leaveForm.dart';
import 'package:mun_care_app/screens/ViewUpcomingHomevisit/ViewUpcomingHomevisit.dart';

import 'package:mun_care_app/screens/registration/ComFamReg.dart';

import 'package:mun_care_app/screens/Reports/diary.dart';
import 'package:mun_care_app/screens/registration/MotherList.dart';
import 'package:mun_care_app/screens/registration/PreFamReg.dart';
import 'package:mun_care_app/screens/registration/RenderData.dart';
import 'package:mun_care_app/screens/reminders/SchHomeSearch.dart';
import 'package:mun_care_app/screens/reminders/CreateScreens/ScheduleClinic.dart';

import 'package:mun_care_app/screens/reminders/CreateScreens/ScheduleHomeVisits.dart';
import 'package:mun_care_app/screens/viewHomeVisit/viewUpcomingHomeVisit.dart';
import 'package:mun_care_app/screens/reports/dairlyDiry.dart';
import 'package:mun_care_app/screens/reports/monthlyReport.dart';
import 'package:mun_care_app/screens/reports/dairlyReportView.dart';
import 'package:mun_care_app/services/GeoLocation.dart';

import 'screens/reports/ReportSearch.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    DateTime getDate;

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
      case '/chat':
        return MaterialPageRoute(builder: (_) => HomeChat());
      case '/leavingReport':
        return MaterialPageRoute(builder: (_) => LeavingReport());
      case '/MedicalReport':
        return MaterialPageRoute(builder: (_) => MedicationReport());
      case '/UpcomingClinics':
        return MaterialPageRoute(builder: (_) => ViewUpcomingClinic());
      case '/UpcomingHome':
        return MaterialPageRoute(builder: (_) => ViewUpcomingHomevisit());
      case '/profile':
        return MaterialPageRoute(builder: (_) => Profile());
      case '/searchReport':
        return MaterialPageRoute(builder: (_) => ReportSearch());
      case '/dairlyReportView':
        return MaterialPageRoute(builder: (_) => DairlyReportView());
      case '/geoLocate':
        return MaterialPageRoute(builder: (_) => GeoLocation());
      case '/leaveForm':
        return MaterialPageRoute(builder: (_) => LeaveForm());
      case '/leaveFormsView':
        return MaterialPageRoute(builder: (_) => LeaveReportView());
      case '/leavingAccept':
        return MaterialPageRoute(builder: (_) => LeaveAccept());
      case '/dutyChecking':
        return MaterialPageRoute(builder: (_) => DutyCheck());
      case '/upcomingHomeVisit':
        return MaterialPageRoute(
            builder: (_) => UpcomingHomeVisitFirebaseDemo());
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
