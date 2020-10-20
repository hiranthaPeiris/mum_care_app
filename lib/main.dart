import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'package:mun_care_app/RouteGenerator.dart';
import 'package:mun_care_app/models/UserM.dart';
import 'package:mun_care_app/screens/Error/ErrorView.dart';
import 'package:mun_care_app/services/AuthServices.dart';
import 'package:provider/provider.dart';
import 'helpers/Constants.dart';




void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(AppFire());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Create the initialization Future outside of `build`:
  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserM>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Mun & Baby',
        theme: ThemeData(
          fontFamily: "Roboto",
          scaffoldBackgroundColor: kBackgroundColor,
          textTheme:
              Theme.of(context).textTheme.apply(displayColor: kTextColor),
        ),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

//firebase
class AppFire extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
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
            child: Text("loading"),
          ),
        );
      },
    );
  }
}
