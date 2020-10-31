import 'package:flutter/material.dart';
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
class MedicationReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.05,
                              MediaQuery.of(context).size.height * 0.0005,
                              MediaQuery.of(context).size.width * 0.05,
                              MediaQuery.of(context).size.height * 0.0005),
                          child: showTextField("Name ", "_Name"),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.05,
                              MediaQuery.of(context).size.height * 0.0005,
                              MediaQuery.of(context).size.width * 0.05,
                              MediaQuery.of(context).size.height * 0.0005),
                          child: showTextField("NIC Number", "_NICnumber"),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.05,
                              MediaQuery.of(context).size.height * 0.0005,
                              MediaQuery.of(context).size.width * 0.05,
                              MediaQuery.of(context).size.height * 0.0005),
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
                            MediaQuery.of(context).size.height * 0.0005,
                            MediaQuery.of(context).size.width * 0.05,
                            MediaQuery.of(context).size.height * 0.0005),
                        child: showTextField("Doctor's Name", "_Doctor's_name"),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.05,
                            MediaQuery.of(context).size.height * 0.0005,
                            MediaQuery.of(context).size.width * 0.05,
                            MediaQuery.of(context).size.height * 0.0005),
                        child: showTextField("Vaccines Name", "_Vacciness_name"),
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.05,
                              MediaQuery.of(context).size.height * 0.005,
                              MediaQuery.of(context).size.width * 0.005,
                              MediaQuery.of(context).size.height * 0.005),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 30,
                                child: Text(
                                  "Date",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.05,
                                    MediaQuery.of(context).size.height * 0.005,
                                    MediaQuery.of(context).size.width * 0.5,
                                    MediaQuery.of(context).size.height * 0.005),
                                // alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    /*Text(_dateDOB == null
                                        ? "Select DOB"
                                        : _dateDOB.year.toString() +
                                        "/" +
                                        _dateDOB.month.toString() +
                                        "/" +
                                        _dateDOB.day.toString()),*/
                                    SizedBox(
                                      width: 20,
                                    ),
                                    SizedBox(
                                      width: 40,
                                      height: 20,
                                      child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                              side: BorderSide(
                                                color: Color.fromARGB(500, 21, 166, 211),
                                              )),
                                          onPressed: () {
                                            showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1980),
                                                lastDate: DateTime(2021))
                                                .then((date) {
                                              // setState(() {
                                              //  _dateDOB = date;
                                              // });
                                            });
                                          }),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),


                      Container(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.1,
                            MediaQuery.of(context).size.height * 0.05,
                            MediaQuery.of(context).size.width * 0.05,
                            MediaQuery.of(context).size.height * 0.005),
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
                )
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


