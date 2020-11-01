import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new LeavingReport(),
  ));
}

class LeavingReport extends StatefulWidget {
  @override
  _LeavingState createState() => new _LeavingState();
}

class _LeavingState extends State<LeavingReport> {

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

    return new Scaffold(
        backgroundColor: Colors.lightBlue,
        body:Container(
          child: ListView(
              children: <Widget>[
            Column(
            children: <Widget>[
              Container(
                height:MediaQuery.of(context).copyWith().size.height/5,
                width: MediaQuery.of(context).copyWith().size.width,
                color: Colors.lightBlue,
                child: Container(
                  child: Text('Leaving Residensial Area Report',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,),
                  padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.2,
                    MediaQuery.of(context).size.height * 0.06,
                    MediaQuery.of(context).size.width * 0.2,
                    MediaQuery.of(context).size.height * 0.04),
                 ),
              ),

              Container(
                padding: EdgeInsets.fromLTRB(10 ,50, 10, 20),
                height:MediaQuery.of(context).copyWith().size.height*(4/5),
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
                      child: Column(
                        children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(flex: 10, child: Container()),
                            Expanded(
                              flex: 40,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                    height: 25,
                                    child: Text(
                                        "New MOH Area  -",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 40,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    height: 25,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(0),
                                        boxShadow: [
                                              new BoxShadow(
                                                color: Colors.black, blurRadius: 10.0),
                                        ],
                                    color: Colors.grey[300],
                                        border: Border.all(
                                          color: Colors.black,
                                          style: BorderStyle.solid,
                                          width: 0.5)),
                                  child: mohDropDownMenu()),
                              ),
                            ),
                            Expanded(flex: 5, child: Container()),
                           ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(flex: 10, child: Container()),
                            Expanded(
                              flex: 40,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  height: 25,
                                  child: Text(
                                    "New PHM Area  -",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                           Expanded(
                               flex: 40,
                               child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0),
                                       boxShadow: [
                                         new BoxShadow(
                                          color: Colors.black, blurRadius: 10.0),
                                      ],
                                    color: Colors.grey[300],
                                    border: Border.all(
                                     color: Colors.black,
                                     style: BorderStyle.solid,
                                     width: 0.5)
                                    ),
                                      child: phmDropDownMenu()
                                  ),
                               ),
                           ),
                           Expanded(flex: 5, child: Container()),
                           ],
                        ),
                        ],
                      ),
                    ),
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
                                "Leaving Date",
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
            ),
            ],
         ),
        ],
        ),
    )
    );
  }

}


String mohDropdownValue = 'Select Area';
String phmDropdownValue = 'Select Area';

Widget mohDropDownMenu() {
  return DropdownButton<String>(
    value: mohDropdownValue,
    icon: Icon(Icons.arrow_downward),
    iconSize: 18,
    elevation: 36,
    isExpanded: true,
    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
    items: <String>[
      'Select Area',
      'One',
      'Two',
      'five',
      'Four'
    ].map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 4),
          child: Text(
            value,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }).toList(),
    onChanged: (String value) {
      /*setState(() {
          mohDropdownValue = value;
        });*/
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
    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
    items: <String>['Select Area', 'Five', 'Six', 'Seven', 'Eight']
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 4),
          child: Text(
            value,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }).toList(),
    onChanged: (String value) {
      /* setState(() {
          phmDropdownValue = value;
        });*/
    },
  );
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

