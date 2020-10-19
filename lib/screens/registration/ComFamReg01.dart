
import 'package:flutter/material.dart';

import 'ComFamReg02.dart';

class ComFamRegMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Registration01(),
    );
  }
}

class ShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.blueAccent;

    var rect = Rect.fromLTWH(0, 0, size.width, size.height*0.7);
    canvas.drawRect(rect, paint);
  }

  bool shouldRepaint(CustomPainter oldDelegate) => false;
}



class Registration01 extends StatefulWidget {
  @override
  _Registration01State createState() => _Registration01State();
}

class _Registration01State extends State<Registration01> {
String mohDropdownValue = 'Select Area';
String phmDropdownValue = 'Select Area';
String yearDropdownValue = 'Year';
String monthDropdownValue = 'Mon';
String dayDropdownValue = 'Day';

 Widget showTextField(String hintText, String inputName) {
  return TextFormField(
    maxLines: 1,
    decoration: InputDecoration(
      hintText: hintText,
    ),
    // ignore: missing_return
    validator: (input) {
      if (input.isEmpty) {
        return 'This can\'t be empty';
      }
    },
    onSaved: (input) => inputName = input,
  );
}

  Widget mohDropDownMenu() {
    return DropdownButton<String>(
    value: mohDropdownValue,
    icon: Icon(Icons.arrow_downward),
    iconSize: 18,
    elevation: 36,
    isExpanded: true,
    style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w700
      ),
    items: <String>['Select Area','One', 'Two', 'Happy New Year mmmmmm', 'Four']
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 4),
          child: Text(value,
          textAlign: TextAlign.center,
          ),
        ),
      );
    }).toList(),
    onChanged: (String value) {
      setState(() {
              mohDropdownValue = value;
            });
          },
        );
      }
  Widget phmDropDownMenu() {
    return DropdownButton<String>(
    value: phmDropdownValue,
    icon: Icon(Icons.arrow_downward),
    iconSize: 18,
    elevation: 36,
    isExpanded: true,
    style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w700
      ),
    items: <String>['Select Area','Five','Six','Seven','Eight']
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 4),
          child: Text(value,
          textAlign: TextAlign.center,
          ),
        ),
      );
    }).toList(),
    onChanged: (String value) {
      setState(() {
              phmDropdownValue = value;
            });
          },
        );
      }
 Widget yearDropDownMenu() {
    return DropdownButton<String>(
    value: yearDropdownValue,
    icon: Icon(Icons.arrow_downward),
    iconSize: 18,
    elevation: 36,
    isExpanded: true,
    style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w700
      ),
    items: <String>['Year','1990', '1991', '1992', '1993','1994','1995']
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 4),
          child: Text(value,
          textAlign: TextAlign.center,
          ),
        ),
      );
    }).toList(),
    onChanged: (String value) {
      setState(() {
              yearDropdownValue = value;
            });
          },
        );
      }
 Widget monthDropDownMenu() {
    return DropdownButton<String>(
    value: monthDropdownValue,
    icon: Icon(Icons.arrow_downward),
    iconSize: 18,
    elevation: 36,
    isExpanded: true,
    style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w700
      ),
    items: <String>['Mon','Jan', 'Feb', 'Mar', '','Apr','May','Jun','jul','Aug','Sep','Oct','Nov','Dec']
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 4),
          child: Text(value,
          textAlign: TextAlign.center,
          ),
        ),
      );
    }).toList(),
    onChanged: (String value) {
      setState(() {
              monthDropdownValue = value;
            });
          },
        );
      }
 Widget dayDropDownMenu() {
    return DropdownButton<String>(
    value: dayDropdownValue,
    icon: Icon(Icons.arrow_downward),
    iconSize: 18,
    elevation: 36,
    isExpanded: true,
    style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w700
      ),
    items: <String>['Day','01', '02', '03', '04','05','06','07','08','09','10']
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 4),
          child: Text(value,
          textAlign: TextAlign.center,
          ),
        ),
      );
    }).toList(),
    onChanged: (String value) {
      setState(() {
              dayDropdownValue = value;
            });
          },
        );
      }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.05,
                MediaQuery.of(context).size.height * 0.03,
                MediaQuery.of(context).size.width * 0.03,
                MediaQuery.of(context).size.height * 0.03),
            child: Container(
              child: Text(
                "Registration",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(500, 21, 166, 211),
                  fontSize: 30,
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            child: CustomPaint(
              painter: ShapePainter(),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.height * 0.016,
                    MediaQuery.of(context).size.width * 0.03,
                    MediaQuery.of(context).size.height * 0.01),
                child: Text(
                  "Competency Family",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 10,
                      child: Container()
                      ),
                    Expanded(
                      flex: 40,
                      child:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 25,
                          child: Text("MOH Area  -",
                          textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        )
                      ),
                    Expanded(
                      flex: 40,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            boxShadow:[new BoxShadow(
                              color: Colors.black,
                              blurRadius: 10.0
                            ),],
                            color: Colors.grey[300],
                            border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 0.5
                            )
                          ),
                          child: mohDropDownMenu()
                          ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container()
                      ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 10,
                      child: Container()
                      ),
                    Expanded(
                      flex: 40,
                      child:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 25,
                          child: Text("PHM Area  -",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        )
                      ),
                    Expanded(
                      flex: 40,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            boxShadow:[new BoxShadow(
                              color: Colors.black,
                              blurRadius: 10.0
                            ),],
                            color: Colors.grey[300],
                            border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 0.5
                            )
                          ),
                          child: phmDropDownMenu()
                          ),
                      ),
                    ),
                     Expanded(
                      flex: 5,
                      child: Container()
                      ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.1,
                  MediaQuery.of(context).size.height * 0.025,
                  MediaQuery.of(context).size.width * 0.05,
                  MediaQuery.of(context).size.height * 0.005),
              child: showTextField("Husbond\'s Name", "_husbondName"),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.1,
                  MediaQuery.of(context).size.height * 0.005,
                  MediaQuery.of(context).size.width * 0.05,
                  MediaQuery.of(context).size.height * 0.005),
              child: showTextField("Wife\'s Name", "_wifeName"),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.1,
                  MediaQuery.of(context).size.height * 0.005,
                  MediaQuery.of(context).size.width * 0.05,
                  MediaQuery.of(context).size.height * 0.005),
              child: showTextField("Address", "_address"),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.1,
                  MediaQuery.of(context).size.height * 0.005,
                  MediaQuery.of(context).size.width * 0.05,
                  MediaQuery.of(context).size.height * 0.005),
              child: showTextField("NIC Number", "_nic"),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.1,
                  MediaQuery.of(context).size.height * 0.005,
                  MediaQuery.of(context).size.width * 0.05,
                  MediaQuery.of(context).size.height * 0.005),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 37,
                        child: Text("Date of Birth"),
                        ),
                      Expanded(
                        flex: 23,
                        child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            boxShadow:[new BoxShadow(
                              color: Colors.black,
                              blurRadius: 10.0
                            ),],
                            color: Colors.grey[300],
                            border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 0.5
                            )
                          ),
                          child: yearDropDownMenu()
                          ),
                      ),
                        ),
                      Expanded(
                        flex: 21,
                        child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            boxShadow:[new BoxShadow(
                              color: Colors.black,
                              blurRadius: 10.0
                            ),],
                            color: Colors.grey[300],
                            border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 0.5
                            )
                          ),
                          child: monthDropDownMenu()
                          ),
                      ),
                        ),
                      Expanded(
                        flex: 19,
                        child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            boxShadow:[new BoxShadow(
                              color: Colors.black,
                              blurRadius: 10.0
                            ),],
                            color: Colors.grey[300],
                            border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 0.5
                            )
                          ),
                          child: dayDropDownMenu()
                          ),
                      ),
                        )
                    ],
                  ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.1,
                  MediaQuery.of(context).size.height * 0.005,
                  MediaQuery.of(context).size.width * 0.05,
                  MediaQuery.of(context).size.height * 0.005),
              child: showTextField("Contact Number", "_contactNumber"),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.1,
                  MediaQuery.of(context).size.height * 0.005,
                  MediaQuery.of(context).size.width * 0.05,
                  MediaQuery.of(context).size.height * 0.005),
              child: showTextField("Email", "_email"),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.1,
                  MediaQuery.of(context).size.height * 0.005,
                  MediaQuery.of(context).size.width * 0.05,
                  MediaQuery.of(context).size.height * 0.005),
              child: showTextField("Job", "_job"),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.1,
                  MediaQuery.of(context).size.height * 0.005,
                  MediaQuery.of(context).size.width * 0.05,
                  MediaQuery.of(context).size.height * 0.005),
            child: Container(
              height: 100,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 50,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: RaisedButton(
                        color: Colors.white,
                        textColor: Color.fromARGB(500, 21, 166, 211),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Color.fromARGB(500, 21, 166, 211),
                          )
                        ),
                        child:Container(
                        decoration: BoxDecoration(
                            boxShadow:[new BoxShadow(
                              color: Colors.black,
                              blurRadius: 30.0
                            ),],
                          ),
                        child: Text("Prev",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        )
                        ),
                        onPressed: (){},
                        ),
                    )
                    ),
                  Expanded(
                    flex: 50,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: RaisedButton(
                        color: Color.fromARGB(500, 21, 166, 211),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Colors.white
                          )
                        ),
                        child:Container(
                        decoration: BoxDecoration(
                            boxShadow:[new BoxShadow(
                              color: Colors.black,
                              blurRadius: 30.0
                            ),],
                          ),
                        child: Text("Next",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                        ),
                        onPressed: (){
                          Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ComFamRegNext()));
                        },
                        ),
                    )
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
