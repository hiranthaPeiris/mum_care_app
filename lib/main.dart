import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:mun_care_app/RouteGenerator.dart';
import 'package:mun_care_app/helpers/Loading.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:mun_care_app/screens/Error/ErrorView.dart';
import 'package:mun_care_app/services/AuthServices.dart';
import 'package:mun_care_app/services/NavigationService.dart';
import 'package:mun_care_app/services/NotificationService.dart';
import 'package:provider/provider.dart';
import 'Locator.dart';
import 'helpers/Constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(AppFire());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  final NotificationService _notificationService = NotificationService();

  Future Startup() async {
    await _notificationService.InitalizeMessaging();
    print("notifi start");
  }

  @override
  Widget build(BuildContext context) {
    Startup();
    return StreamProvider<UserM>.value(
      value: AuthService().user,
      child: MaterialApp(
        navigatorKey: locator<NavigationService>().navigatorKey,
        title: 'Mun & Baby',
        theme: ThemeData(
          fontFamily: "Roboto",
          scaffoldBackgroundColor: kBackgroundColor,
          textTheme:
              Theme.of(context).textTheme.apply(displayColor: kTextColor),
        ),
        initialRoute: '/dairlyReportView',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

//firebase
class AppFire extends StatelessWidget {
  //final Future<FirebaseApp> _initialization = ;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        //Startup();
        if (snapshot.hasError) {
          String tostring = snapshot.error.toString();
          print(tostring);
          return MaterialApp(
              home: ErrorView(
            errorMsg: tostring,
          ));
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
          home: Container(
            child: Loading(),
          ),
        );
      },
    );
  }
}
