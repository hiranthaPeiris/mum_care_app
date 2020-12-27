import 'package:flutter/material.dart';
import 'package:mun_care_app/models/user.dart';
import 'package:mun_care_app/services/AuthServices.dart';
import 'package:sign_button/sign_button.dart';

class Signup extends StatefulWidget {
  final Function toggleView;

  Signup({this.toggleView});

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  AuthService _auth = AuthService();

  bool _termsAgreed = false;
  bool newValue = true;
  String error = "";
  String name = "";
  String email = "";
  String confPassword = "";
  String password = "";
  String _comfirmPassword = "";
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController telController = new TextEditingController();
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    telController.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  bool validate() {
    if (email.isEmpty &&
        password.isEmpty &&
        name.isEmpty &&
        confPassword.isEmpty) {
      print("fields empty");
      return false;
    }
    if (confPassword == password) {
      print("pass match");
      return true;
    }
    print("else");
    return false;
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
              padding: EdgeInsets.all(10),
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
                  mainAxisAlignment: MainAxisAlignment.center,
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
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(16),
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        labelText: 'Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(16),
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: TextField(
                      controller: telController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(16),
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        labelText: 'Mobile Number',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(16),
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        labelText: 'Password',
                      ),
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      obscureText: true,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(16),
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        labelText: 'Confirm Password',
                      ),
                      onChanged: (val) {
                        setState(() {
                          confPassword = val;
                        });
                      },
                      obscureText: true,
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
                        width: 5,
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
                        'I agree with privacy policy',
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 40.0,
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: RaisedButton(
                shape: StadiumBorder(),
                textColor: Colors.white,
                color: Colors.lightBlue,
                child: Text('Sign Up',
                    style: TextStyle(
                      fontSize: 20.0,
                    )),
                onPressed: () {
                  if (validate()) {
                    UserModel userMod = UserModel(
                        email: emailController.text.trim(),
                        name: nameController.text.trim(),
                        role: "user",
                        tel: telController.text.trim());
                        
                    dynamic result = _auth.register(userMod, password.trim());
                    if (result == null) {
                      setState(() {
                        error = 'Please supply a valid email';
                      });
                    }
                  } else {
                    setState(() {
                      error = 'Please check the details again';
                    });
                  }
                },
              ),
            ),
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
