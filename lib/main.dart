import 'package:flutter/material.dart';
//import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:sign_button/sign_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
     debugShowCheckedModeBanner: false,
      home:HomePage(),
    );//material app

  }
}

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState()=> _HomePageState();
}

class  _HomePageState extends State<HomePage>{

bool _termsAgreed=false;
bool newValue=true;

  @override
   Widget build(BuildContext context) {

      //debugShowCheckedModeBanner:false;
  return  Scaffold(
 body: Padding(
   padding: EdgeInsets.all(40),
   child: ListView(
     children: <Widget>[
       Container(
       
         child: Text('Sign Up',
           style: TextStyle(
             color: Colors.lightBlue,
             fontWeight: FontWeight.bold,
             fontSize: 24,
            ),
           ),
         
            ),
             Container(
                
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text('Please Registration with email signUp to continue using our App',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
             ),
            
             Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              alignment: Alignment.center,
              child: Text('Enter via Social Networks',
                style: TextStyle(color: Colors.lightBlue,
                  fontWeight: FontWeight.bold,
                  
                  fontSize: 15,
                ),
              ),

             ),
             Center(
             child:Container(
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
  
  
  
  
           /*SignInButton(
              Buttons.GoogleDark,
              //shape: CircleBorder(),
              text:'Sign Up With Google',
            // max: true,
              onPressed: () {},
             // shape: CircleBorder(),
              ),
                                     
            SignInButton(
              
             Buttons.Facebook,
              text:'Sign With Google',
               mini: true,
             onPressed: () {},
              
             //shape: CircleBorder(),

              ), */
             /* SignInButtonBuilder(
  text: 'Sign in with Email',
  icon: Icons.email,
  onPressed: () {},
  backgroundColor: Colors.blueGrey[700],
),*/


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
          child: Text('or login with Email',
            style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
               
       Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: new BorderRadius.circular(20.0)),
                  labelText: 'Email',
                ),
              ),
            ),
        Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
             child: TextField(
             decoration: InputDecoration(
             border: OutlineInputBorder(borderRadius: new BorderRadius.circular(20.0)),
             labelText: 'Password',
              ),
         ),
        ),

                    Container(
                //padding: EdgeInsets.all(10.0),
            child: Column(
               children: <Widget>[
                  Row(  
                    children: <Widget>[  
                      SizedBox(width: 10,),  
                      Checkbox(
                        value: _termsAgreed,
                       activeColor: Colors.blue,
                        onChanged:(newValue){
                       setState(() {
                       _termsAgreed = newValue;
                     });
       
                  }),
            Text('I agree with private policy' ,textAlign: TextAlign.right,),  

        
          ],),
           ],),
            ),///////////

        Container(
              height: 50.0,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: RaisedButton(
                shape: StadiumBorder(),
                textColor: Colors.white,
                color: Colors.lightBlue,
                child: Text('Sign Up',style:TextStyle(fontSize:24.0,)),
                onPressed: (){
                },
              ),
            ),

         Container(
              child: Row(
                children: <Widget>[
                  Text('You already have an Acoount?'),
                  FlatButton(
                    textColor: Colors.lightBlueAccent,
                    child: Text('Login',
                      style: TextStyle(fontSize: 16,
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


final leftSection = new Container(
  alignment: Alignment.center,
  padding: EdgeInsets.fromLTRB(80, 10, 10, 10),  child: Image.asset(
    "assets/fb.jpg",
    width: 70.0,
    height: 70,
  ),
);









