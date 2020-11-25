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
import 'package:mun_care_app/screens/leavingForm/leaveForm.dart';
import 'package:mun_care_app/screens/registration/ComFamReg.dart';
import 'package:mun_care_app/screens/reminders/SchHomeSearch.dart';
import 'package:mun_care_app/screens/reminders/CreateScreens/ScheduleClinic.dart';
import 'package:mun_care_app/screens/reminders/CreateScreens/ScheduleHomeVisits.dart';
import 'package:mun_care_app/screens/viewHomeVisit/viewUpcomingHomeVisit.dart';
import 'package:mun_care_app/screens/reports/dairlyDiry.dart';
import 'package:mun_care_app/screens/reports/dairlyReport.dart';
import 'package:mun_care_app/screens/reports/monthlyReport.dart';
import 'package:mun_care_app/screens/reports/dairlyReportView.dart';

import 'screens/reports/ReportSearch.dart';

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
      case '/dairlyDiary':
        return MaterialPageRoute(builder: (_) => DairlyDiary());
      case '/dairlyReport':
        return MaterialPageRoute(builder: (_) => DairlyReport());
      case '/dairlyReportView':
        return MaterialPageRoute(builder: (_) => DairlyReportView());
      case '/monthlyReport':
        return MaterialPageRoute(builder: (_) => MonthlyReport());
      case '/searchReport':
        return MaterialPageRoute(builder: (_) => ReportSearch());
      case '/leaveForm':
        return MaterialPageRoute(builder: (_) => LeaveForm());
      case '/upcomingHomeVisit':
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
