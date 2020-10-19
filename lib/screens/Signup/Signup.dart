import 'package:flutter/material.dart';
import 'package:mun_care_app/services/AuthServices.dart';
import 'package:sign_button/sign_button.dart';

class Signup extends StatefulWidget {
  final Function toggleView;

  Signup ({ this.toggleView });

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  AuthService _auth = AuthService();

  bool _termsAgreed = false;
  bool newValue = true;
  String error = "";
  String email = "";
  String password = "";
  final _formKey = GlobalKey<FormState>();

  bool validate() {
    if (email.isEmpty && password.isEmpty) {
      print("empty");
      return false;
    }
    print("not");
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(40),
        child: ListView(
          children: <Widget>[
            Container(
              child: Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text(
                'Please Registration with email signUp to continue using our App',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              alignment: Alignment.center,
              child: Text(
                'Enter via Social Networks',
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            Center(
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    SignInButton.mini(
                      buttonType: ButtonType.google,
                      onPressed: () {},
                    ),
                    SignInButton.mini(
                      buttonType: ButtonType.facebook,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),

            Container(
              child: Row(
                children: <Widget>[
                  //leftSection,
                  //rightSection
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              child: Text(
                'or login with Email',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        labelText: 'Email',
                      ),
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        labelText: 'Password',
                      ),
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Checkbox(
                          value: _termsAgreed,
                          activeColor: Colors.blue,
                          onChanged: (newValue) {
                            setState(() {
                              _termsAgreed = newValue;
                            });
                          }),
                      Text(
                        'I agree with private policy',
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ],
              ),
            ), ///////////
            Container(
              height: 50.0,
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: RaisedButton(
                shape: StadiumBorder(),
                textColor: Colors.white,
                color: Colors.lightBlue,
                child: Text('Sign Up',
                    style: TextStyle(
                      fontSize: 24.0,
                    )),
                onPressed: () {
                  if (validate()) {
                    dynamic result = _auth.Register(email, password);
                    if (result == null) {
                      setState(() {
                        error = 'Please supply a valid email';
                      });
                    }
                  }
                },
              ),
            ),
            SizedBox(height: 12.0),
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 14.0),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Text('You already have an Acoount?'),
                  FlatButton(
                    textColor: Colors.lightBlueAccent,
                    onPressed: () {
                      widget.toggleView();
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
