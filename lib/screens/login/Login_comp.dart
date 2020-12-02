import 'package:flutter/material.dart';

import 'package:mun_care_app/models/UserM.dart';
import 'package:mun_care_app/helpers/Loading.dart';
import 'package:mun_care_app/services/AuthServices.dart';
import 'package:provider/provider.dart';
import 'package:sign_button/sign_button.dart';

class LoginComp extends StatefulWidget {
  final Function toggleView;
  //bool onDuty = false;
  LoginComp({this.toggleView});

  @override
  _LoginCompState createState() => _LoginCompState();
}

class _LoginCompState extends State<LoginComp> {
  final AuthService _auth = AuthService();
  LoginComp v;
  String email = '';
  String password = '';
  String error = '';

  bool pending = false;

  // set onDuty(bool onDuty) {
  // onDuty = true;
  //}

  bool validate() {
    if (email.isEmpty && password.isEmpty) {
      print("empty");
      return false;
    }
    print("not empty");
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserM>(context);
    return pending
        ? Loading()
        : Scaffold(
            body: Padding(
              padding: EdgeInsets.all(40),
              child: ListView(
                children: <Widget>[
                  Container(
                    child: Text(
                      'LogIn Now',
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
                      'Please login to continue using our app',
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
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SignInButton.mini(
                            buttonType: ButtonType.facebook,
                            onPressed: () {},
                          ),
                          SignInButton.mini(
                              buttonType: ButtonType.google,
                              buttonSize: ButtonSize
                                  .large, // small(default), medium, large
                              onPressed: () {
                                print('click');
                              })
                        ]),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'or login with email',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        labelText: 'email',
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
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //forgot password screen
                    },
                    child: Text(
                      'Forgot Password',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    height: 50.0,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      shape: StadiumBorder(),
                      textColor: Colors.white,
                      color: Colors.lightBlue,
                      child: Text('LogIn'),
                      onPressed: () async {
                        if (validate()) {
                          setState(() {
                            pending = true;
                          });
                          dynamic result = await _auth.signIn(email, password);
                          if (result == null) {
                            setState(() {
                              pending = false;
                              error = 'Please supply a valid email';
                            });
                          } else {
                            print(new UserM.get().userCredential.user.uid);
                            _auth.setUserMessageToken();
                            //onDuty = true;
                          }
                        } else {
                          setState(() {
                            error = 'Please supply a valid email';
                          });
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
                        Text('Does not have account?'),
                        FlatButton(
                          textColor: Colors.lightBlueAccent,
                          onPressed: () {
                            widget.toggleView();
                          },
                          child: Text(
                            'SingUp',
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
