import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mun_care_app/RouteGenerator.dart';
void main()
{
  runApp(App());
}
class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MedicationReport(),
    );
  }
}


class MedicationReport extends StatefulWidget {
  @override
  _MedicationState createState() => new _MedicationState();
}

class  _MedicationState extends State<MedicationReport> {
  DateTime selected;
  _showDateTimePicker() async {
    selected = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1960),
      lastDate: new DateTime(2050),
    );
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {

    var dateFormat_1 = new Column(
      children: <Widget>[
        new SizedBox(
          height: 30.0,
        ),
        selected != null
            ? new Text(
          new DateFormat('yyyy-MMMM-dd').format(selected),
          style: new TextStyle(
            color: Colors.black,
            fontSize: 15.0,
          ),
        )
            : new SizedBox(
          width: 0.0,
          height: 0.0,
        ),
      ],
    );


    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Container(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height:MediaQuery.of(context).copyWith().size.height/6,
                  width: MediaQuery.of(context).copyWith().size.width,

                  color: Colors.lightBlue,
                  child: Container(
                    child: Text('Private Medication Report',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,),
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.2,
                        MediaQuery.of(context).size.height * 0.06,
                        MediaQuery.of(context).size.width * 0.2,
                        MediaQuery.of(context).size.height * 0.02),
                  ),

                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10 ,10, 10, 10),
                  height:MediaQuery.of(context).copyWith().size.height*(5/6),
                  width: MediaQuery.of(context).copyWith().size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child:ListView(
                    children: <Widget>[
                      Column(
                  children: <Widget>[
                        Container(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.05,
                                MediaQuery.of(context).size.height * 0.005,
                                MediaQuery.of(context).size.width * 0.05,
                                MediaQuery.of(context).size.height * 0.005),
                            child: showTextField("Name ", "_Name"),
                            ),
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                               MediaQuery.of(context).size.width * 0.05,
                               MediaQuery.of(context).size.height * 0.005,
                               MediaQuery.of(context).size.width * 0.05,
                               MediaQuery.of(context).size.height * 0.005),
                            child: showTextField("NIC Number", "_NICnumber"),
                           ),
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.05,
                              MediaQuery.of(context).size.height * 0.005,
                              MediaQuery.of(context).size.width * 0.05,
                              MediaQuery.of(context).size.height * 0.005),
                            child: showTextField("Eligible Family Number", "_EFsnumber"),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.1,
                              MediaQuery.of(context).size.height * 0.05,
                              MediaQuery.of(context).size.width * 0.05,
                              MediaQuery.of(context).size.height * 0.05),
                            child: Text('About Medication',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.05,
                              MediaQuery.of(context).size.height * 0.005,
                              MediaQuery.of(context).size.width * 0.05,
                              MediaQuery.of(context).size.height * 0.005),
                            child: showTextField("Doctor's Name", "_Doctor's_name"),
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.05,
                              MediaQuery.of(context).size.height * 0.005,
                              MediaQuery.of(context).size.width * 0.05,
                              MediaQuery.of(context).size.height * 0.005),
                            child: showTextField("Vaccines Name", "_Vacciness_name"),
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.05,
                                MediaQuery.of(context).size.height * 0.005,
                                MediaQuery.of(context).size.width * 0.05,
                                MediaQuery.of(context).size.height * 0.005),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 20,
                                  child: Text(
                                    "Date",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        child:  new Padding(
                                          padding: EdgeInsets.all(20.0),
                                          child: new Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              dateFormat_1,
                                              new SizedBox(
                                                height: 20.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: IconButton(
                                          icon: new Icon(Icons.date_range,
                                            color: Colors.black,
                                          ),
                                          onPressed: () => _showDateTimePicker(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.1,
                              MediaQuery.of(context).size.height * 0.005,
                              MediaQuery.of(context).size.width * 0.05,
                              MediaQuery.of(context).size.height * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: <Widget>[
                              Container(
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Back'),
                                  ),
                                ),
                              ),
                              Container(
                                child: Align(
                                  alignment: Alignment.bottomRight,

                                  child: ElevatedButton(

                                    child: Text('Submit'),
                                    onPressed: (){
                                    },

                                  ),

                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      ),
                    ],
                  ),
            ),
          ],
        ),
       ],
      ),
      ),
    );

  }
}

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


